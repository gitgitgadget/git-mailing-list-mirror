From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] CodingGuidelines: on comparison
Date: Fri, 02 May 2014 13:45:25 -0700
Message-ID: <xmqqppjvap0a.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-8-git-send-email-gitster@pobox.com>
	<20140501213657.GC14441@sigill.intra.peff.net>
	<xmqqk3a4avt1.fsf@gitster.dls.corp.google.com>
	<20140502203116.GA32500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 22:45:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKKv-00022g-4I
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbaEBUpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:45:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50198 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbaEBUpa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:45:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1792123C9;
	Fri,  2 May 2014 16:45:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=76k30SVq5h/oF3UzaMgvHLnOPTg=; b=cgo0Pd
	I4gW/aaYGd3Ol0k7YU/08OZHryJKy8b5I1jrLKB2VIfJ5HgERmIiYOufjnvpdCvM
	iDNpnyaN988toTsRRqTaOamju/HyRF4z7M4LthkVdeZycXQdVuxhfHHBfy2ggXaY
	prEOu16bk0lw8Qpu0Y8s151BFtn4ju8QkI1V4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C93p9NuwgxIL98DzUW4j+AUH2A2Gh+IZ
	VCN8eh3kwfCrJyK69xZ1GlLDEeteX/O+ttOj0e+igiXroUNrZ1gn9/06agMcKyQs
	QejUAAT6n6jHGgETcohs65WjcQZg2LE+L5UXFnkU8pyEZrB8HKerRSKuABBKONyT
	sq0S2grl5qo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5532123C8;
	Fri,  2 May 2014 16:45:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E633123C4;
	Fri,  2 May 2014 16:45:27 -0400 (EDT)
In-Reply-To: <20140502203116.GA32500@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 2 May 2014 16:31:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B13B7272-D23A-11E3-82C3-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247972>

Jeff King <peff@peff.net> writes:

> I meant something even less in-depth. Your message says only "on
> comparison", and I did not even know what "this" in your sentence above
> would mean until I followed the link.
>
>   There are arguments for writing a conditional as "a < b" rather than
>   "b > a", or vice versa. Let's give guidance on which we prefer.
>
> Not a big deal, but I think it is easy when you have just written the
> patch to forget that a reviewer or a reader of "git log" six months have
> no has no context at all.

Thanks; I'll steal that one.
