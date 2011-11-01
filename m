From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] completion: match ctags symbol names in grep
 patterns
Date: Tue, 01 Nov 2011 11:14:52 -0700
Message-ID: <7vipn3n203.fsf@alter.siamese.dyndns.org>
References: <20111021172239.GA22289@sigill.intra.peff.net>
 <20111021173021.GC24417@sigill.intra.peff.net>
 <20111023212928.GG22551@goldbirke>
 <20111028060517.GA3993@sigill.intra.peff.net>
 <20111029124755.GE2345@goldbirke>
 <20111101152148.GA5552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 01 19:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLIrT-0000xj-Le
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 19:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab1KASOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 14:14:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab1KASOy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 14:14:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B29C68C9;
	Tue,  1 Nov 2011 14:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3HO0Wyvi+4TocWyNgKrBbnNnM84=; b=ZzRVhH
	2jLU6QaPkCA4GEaLwausSpNni1WktumgRTfSQENBGOkoHXzNZZ/0D1BmZcyyJAPd
	mYt/+HFXJHsfSSHUo/v+INgezGN4XgDdbsvpiTqnPa5Ld2wX6nST+YBnkAr3pnQR
	K87hOkVShEw54Nu9ysuo78gtVUvaRxLwMLlCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxAtELBG93D5fXybAaSeQ3BjUQruhJfp
	98kqVztD2jECX0yy3eKRgLS/GQNewBle+Ge93jbJ/SO9X1CmE0R2mtgMJ2G0vnuY
	UmIwROUGV3FdmKFfUa7Vx+nqcSWH8ftphyBOLxfisImgghzrnlhl2hAWWt33gJxS
	w/mGOdxd+c8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62B4268C8;
	Tue,  1 Nov 2011 14:14:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F036068C7; Tue,  1 Nov 2011
 14:14:53 -0400 (EDT)
In-Reply-To: <20111101152148.GA5552@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 1 Nov 2011 08:21:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65B786B0-04B5-11E1-8D45-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184578>

Jeff King <peff@peff.net> writes:

> Yeah, that makes sense. Again, my inclination is to just leave that for
> a further patch if somebody really wants to make the completion (for
> this and any other positional slots) more accurate.

I tend to agree with your inclination. Let's go with the current simple
version and see if real users want something different.
