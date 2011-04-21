From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 20:57:25 -0700
Message-ID: <7v1v0wz26y.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net>
 <4a235331-951f-481e-8603-896af4e67df9-mfwitten@gmail.com>
 <7v62q8z824.fsf@alter.siamese.dyndns.org>
 <BANLkTikbgfjq2J3K4_21zVQSTgnteZfMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 05:57:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCl1b-0007Sn-07
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 05:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1DUD5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 23:57:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab1DUD5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 23:57:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FE9151AF;
	Wed, 20 Apr 2011 23:59:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgr2dlS7H9YKn7zft3ejS1UViek=; b=NVGQOy
	b2iDUzxLOUgtlZenGERUNhodVFKHQYT7ave+oM62zAIdfvDIBA3Yq7cjvvcvO2px
	mD3/S74d5Rg4O2yKq6mboxuciNxV4YD5py4AyJrOtwkapYJDKfEMvh84KvLnrFJN
	GM2b1yj+or4lnYVTd2TmxPXlwY6VenMXP6pCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SKVFjrPD5QAZSVoXtT695Qogk4jnwHVk
	K9JlLJy0Xq8abxhvpMrOP+oWgOT1LOCH10mjsPri8FfmX4GdiOigbn4aSJT9944B
	KTKcquFgamd+y8xqM4lBA069snft1lgkP6+5NrB+9QVwFhZJcZvvhguFNDjB6g3e
	1PquaL1eYHo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAF7051AE;
	Wed, 20 Apr 2011 23:59:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C43CF51AD; Wed, 20 Apr 2011
 23:59:28 -0400 (EDT)
In-Reply-To: <BANLkTikbgfjq2J3K4_21zVQSTgnteZfMqg@mail.gmail.com> (Michael
 Witten's message of "Thu, 21 Apr 2011 02:14:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3C54AD6-6BCB-11E0-90FC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171893>

Michael Witten <mfwitten@gmail.com> writes:

>>> I took a cursory look, but I've spent so much time on this series already
>>> that I don't really care what it says...
>>
>> This is not a very good way to motivate somebody who is already tired at
>> the end of the day to reivew the RFC series, I would have to say.
>
> Then you can save us both time and just apply my series immediately :-P

That's not how things work around here.

The default is not to apply, unless the goal of the change is worthy and
the patch implements that change well.  It is submitter's job to convince
people that the change is worthy, justify that it is worth reviewers' time
to review the patch, and respond to questions and suggestions for
improvements.

By doing these responsibly, you win support for the particular patchset,
and win trust from others in you, which would affect further patches from
you.

It is not exactly a good way to win support to dump a patchset, to declare
that you are beyond the point of rethinking, to say a take-it-or-leave-it,
nor to defend your private style that goes against the project's coding
style (style is subjective and there is no right or wrong).

I know you know all of the above from your ":-P" (and your past patch
submissions), but I am writing these down so that people new to the list
do not get a wrong impression from this exchange.
