From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: give placeholders to reflog identity
Date: Fri, 16 Dec 2011 13:04:05 -0800
Message-ID: <7vr504grei.fsf@alter.siamese.dyndns.org>
References: <20111216114024.GA16965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 22:04:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbeww-0002eE-Vj
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 22:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760088Ab1LPVEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 16:04:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1LPVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 16:04:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 825296201;
	Fri, 16 Dec 2011 16:04:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrwRpUP5D2oPSNYgYBuQ7SqzNgI=; b=FntxCo
	/37iCi9TLmzRtzkjIQbHSU4bUCZXOsHFN1Uzuw3moEvcA87bvgqxeUgioaAB/2Rq
	hzs5tpPOCuZwjwGEZiqVhcm53cqQ2K1yLR0MOR2ZH/zpiSC90trED07yKRtgLfB+
	YEz7gC4xDxlis9gTuCaNVMmATIZzKwS2Qi5gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rhV4TLcjiOwEAN1srh0y6bWZhrqAnbtL
	Nfx7vbjJiR4mljIWiJWmT+qFv2Xni0pg7ooilnJ37N5IE7Bbpj6fx+J3LtukSohv
	P0qID0CoGlIxKqeuArdW89SvPT87mX5Y2yWoyF0dfMx5X1MUrQz9GXICdLVD0MR9
	IlF0SVA/UWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 794DD6200;
	Fri, 16 Dec 2011 16:04:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1035161FF; Fri, 16 Dec 2011
 16:04:06 -0500 (EST)
In-Reply-To: <20111216114024.GA16965@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 16 Dec 2011 06:40:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E03BD3C-2829-11E1-9D3D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187319>

Makes sense; thanks.

With the existing helper format_person_part(), this is surprisingly
simple. Perhaps I should not be surprised ;-).
