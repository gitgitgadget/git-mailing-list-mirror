From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Thu, 20 Jan 2011 13:25:54 -0800
Message-ID: <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch> <4D389E69.608@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Git ML <git@vger.kernel.org>
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:26:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg21O-0006PZ-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab1ATV0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 16:26:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab1ATV0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 16:26:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CE3C3DF9;
	Thu, 20 Jan 2011 16:26:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E8WZuwLh4OuSMiwanRhN+QzNj+Q=; b=P2nEb0
	4dCu5q4eFvRYWL2I07fn1Qfr2LGIR/Rh4FPMF3swYELooD9wdEWc8Vcfwg0zvOPM
	AiPQ48PE6SPfayrRBhXRaOfwnEaD4v5U4BIqVuZJ0iPHihBNhfJpuY0pWk+BgG9T
	7A34I9O0p2Uxd19hRHiiPbOOyy+60lEhjVEvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxpNgHWhiPI80h+AqNrEnx6PiHhZeikj
	HYjm8GWa+GtSOIkkmYV3zgnlhv6lxJ8lTRQWBbqy36pVOAGy3P29QniD8loJHFMJ
	qMTHEoV7rSkcscWI3csG9/89twTYtHHT+kLrblu3wenwqCOkkCF/YnRTswCWX1pw
	ZcyNu5Zjsr8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06F773DF5;
	Thu, 20 Jan 2011 16:26:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C8E4F3DF2; Thu, 20 Jan 2011
 16:26:43 -0500 (EST)
In-Reply-To: <4D389E69.608@hartwork.org> (Sebastian Pipping's message of
 "Thu\, 20 Jan 2011 21\:43\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCD8CCB2-24DB-11E0-BFCA-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165339>

Sebastian Pipping <webmaster@hartwork.org> writes:

> On 01/20/11 21:27, Thomas Rast wrote:
>> Quote from the latter:
>> 
>>        This manual page describes only the most frequently used options.
>
> Okay.  Is that a good a idea?

Yes; the alternative is to list everything.

> Is --abbrev-commit really used more
> frequently with "git show" than --color-words is?

I see this as a not-so-helpful-but-still-interesting question.

It depends on who you are, and if one wants to pick the most often used
ones, that selection may or may not coincide with _your_ usage pattern nor
mine.  The original author apparently thought so, you seem to think
color-words is used a lot more often, and I personally think neither is
used often at all.  So should we swap them, keep things as-is, or remove
both?

We obviously cannot take a poll to update the list every time a new user
starts using git, but it might make sense to review them every once in a
while.
