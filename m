From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 17:09:55 -0700
Message-ID: <7vhb4h1ewc.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vty8h2wda.fsf@alter.siamese.dyndns.org>
 <20110912232756.GD28994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 02:10:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3GZg-0007IX-Fe
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 02:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1IMAJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 20:09:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab1IMAJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 20:09:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 472C35569;
	Mon, 12 Sep 2011 20:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PyDb0gMEbn0+l8zwhwzZUkSpbM=; b=g2kXAW
	uXJYjlSKsTRfiX8laM+udkcWTiRrQYGASr195UZJHBWLYn3bC1Ok4ad4sDDsi96u
	+5kGdX79m5/xTsu4ciR9BwOXWur4oypPp0bqjMsYAKJKnupEbdsQcfJqMWb3ObQb
	U0RjS2uS3sVchM11ReSGmvR5Ql3jeJzYk/N7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fiP5FpvvCXk3BiLOxwIgON5mKGx1wN1n
	CeiGLdZ8RejVKU/6g6ChEtJcVx9GX6w3gLEYbvwdY2jr04sZZ1JA9WhxI8kkJY/F
	vzvB4Dyg/Y2TbHVLcrvtuMpwR2ujr7zx9JcgkXRiTCZDNsfWaKn7K7STXhXQxfuQ
	84ZaS/KKqQ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EFD85568;
	Mon, 12 Sep 2011 20:09:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC9A65566; Mon, 12 Sep 2011
 20:09:56 -0400 (EDT)
In-Reply-To: <20110912232756.GD28994@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Sep 2011 19:27:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B68DAC6C-DD9C-11E0-AC84-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181262>

Jeff King <peff@peff.net> writes:

> ... I
> suspect until then, you could just drop them.

That's a lot simpler than having to worry about it. Thanks.
