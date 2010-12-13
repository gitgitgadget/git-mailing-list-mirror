From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] t800?-blame.sh: retitle uniquely
Date: Mon, 13 Dec 2010 11:51:58 -0800
Message-ID: <7vfwu1zc0x.fsf@alter.siamese.dyndns.org>
References: <4D05F1EA.9000403@viscovery.net>
 <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net> <20101213170734.GA24736@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSERV-0003Q1-Lu
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab0LMTwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 14:52:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab0LMTwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 14:52:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3BFD3E48;
	Mon, 13 Dec 2010 14:52:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eg8nPIZsjTjycmzskkxvQXFPi60=; b=vV+u/C
	aHNC8vdG88Q5/2iR7rcq6GXNaLNse7JlpL5UMzzaF+7lVsQPgtnWufXJPD+yHbOy
	84UsePIuNLuE9lAtRcdpkkap27gb3HAvoeNCTmNJEDUhaUq5v3NfnbCIsy6c7C06
	Pen5SfxCn0tXwVF+/ZIWK9waiJc0nigt/qH5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MDlNN0lkUd23K0MM+AdQo48XXtLNAuNP
	CybQgv/XApa0aGRHZdDDekhQULLtFsacqps/JSRUHb/iSuFIFeD9bholWft7bYq7
	Vlyw8A+EYpKeWmzUzBqTkHASO7IGzpvQubbT3akKop+sy7dMd+25j/JjmHK7fwDs
	ja2UzA9R0us=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C55B3E46;
	Mon, 13 Dec 2010 14:52:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 054783E45; Mon, 13 Dec 2010
 14:52:25 -0500 (EST)
In-Reply-To: <20101213170734.GA24736@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 13 Dec 2010 12\:07\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85802CB6-06F2-11E0-93B9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163588>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 13, 2010 at 05:12:29PM +0100, Michael J Gruber wrote:
>
>> On a related note to J6t's patch, how's the stance on unique titles?
>> Unique numbers are important for partial test runs, of course,
>> but unique titles help finding you way through the test.
>> There are more than the blame.sh ones.
>
> I don't think it is a big deal, but I did just 5 minutes ago get annoyed
> at:
>
>   t7500-commit.sh
>   t7501-commit.sh
>   t7502-commit.sh
>   t7509-commit.sh

t7509 seems to be about the authorship, so it is easy to rename it to
t7509-commit-authorship or something, but unfortunately I do not see
unifying theme in any of t750[012].  They test random things and there
seem to be overlaps.

Perhaps somebody wants to consolidate these three into one?
