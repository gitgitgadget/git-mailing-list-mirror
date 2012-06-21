From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 22:43:31 -0700
Message-ID: <7vwr31rzi4.fsf@alter.siamese.dyndns.org>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
 <20120620182855.GA26948@sigill.intra.peff.net>
 <7vk3z1u4lw.fsf@alter.siamese.dyndns.org>
 <20120621051817.GA18102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 07:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShaB9-0002Vg-GT
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 07:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab2FUFnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 01:43:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306Ab2FUFne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 01:43:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A16D8344;
	Thu, 21 Jun 2012 01:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XL9LZ6Uh7xZzMharPqw/FBcBXXU=; b=BBDuVj
	N2UqZIIOzuVyDR13JaEV4JfMmkI25JlR7txa6xWOe1PvGw0P075g80oboirPhInd
	FCFgeIFWzac0PwwmgI8mj6gKKiVIPUpf46SkQ1Udl7C9aND4kyPP9FizLTsHH3OZ
	VNRx4LcrrnQPwwfsV75FuaoI/eIBhGs+EVskw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VVjGEPst0gj+t6wgAFWbw4lesVKC+E4B
	Lfs2XSKV/V0WE25heNa9JMSCSWsde62HAbyh2kZwi1XTDsdqIyH6yC1gQGbYA4be
	48hsPX9BtfbgDlcZQFWxPDqq53D6C2e/TrNYSFQX3kwa7o+2PtggEMAnNW0BfZrv
	PHljsDQSP3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE7DA8341;
	Thu, 21 Jun 2012 01:43:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56B8B833F; Thu, 21 Jun 2012
 01:43:33 -0400 (EDT)
In-Reply-To: <20120621051817.GA18102@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 21 Jun 2012 01:18:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09D16800-BB64-11E1-A9CF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200382>

Jeff King <peff@peff.net> writes:

> You probably noticed a lot of nice review from Jonathan. I had hoped to
> do another round exploring some alternatives we discussed, but didn't
> get to it tonight, and now I'm going to be away from email for about 5
> days.
>
> I don't think there is anything _wrong_ in the series as it is, and
> certainly the things we talked about changing could be built on top. So
> if you want to hold it in pu for a week, I can revisit it next week. But
> I'd also be just as happy to see it move to next, and revisit the topic
> later by building on top.

I'd keep it in 'pu'; it may be replaced with Jonathan's reroll if it
comes.

Have fun, whereever you are.
