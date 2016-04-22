From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 10:23:25 -0700
Message-ID: <xmqq60v9r20i.fsf@gitster.mtv.corp.google.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPMYSGe0k0eAZCQFtBOHw2yZp0w+HL6iN9YPDX5EvJcg-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:23:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atenn-0003y8-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcDVRX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:23:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754478AbcDVRX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:23:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F41E812A3B;
	Fri, 22 Apr 2016 13:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UaOqZI8hZakgHFQpp/HEbEuR+10=; b=Erubxy
	Rh/4Sjnl/5dQsWkKDRcU1veC3VEV9mVda60IaIGeGb0+LXq0U/lsmxa0B/CABkK/
	wSOB68G7UlQU5HJD/79wL7ONmtpumUCbn5C5/pO4/E4GorknW9xwUx/KXJv/8VQ9
	hudpP4j9if4KT8mFBOOAyey9x/vE2CYMgnh0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0Ttdj/v7ZYFAvXFpBevtf6mmt8cEUzk
	gnIU8xPKwWJ0ldzUcXA/NuXeb21mhjgnyTQGJCrZwDi1K8sNzVMLmRKzWdyebybU
	eQHRGLAROXn09jEyuRqyj8JoEAZRiTj6AEyr70V3omgoaIn+BOXKCm2vFDjzzQeD
	+vyhsdjxM64=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB53012A3A;
	Fri, 22 Apr 2016 13:23:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DACD12A39;
	Fri, 22 Apr 2016 13:23:26 -0400 (EDT)
In-Reply-To: <CAFZEwPMYSGe0k0eAZCQFtBOHw2yZp0w+HL6iN9YPDX5EvJcg-w@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 22 Apr 2016 04:18:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC3B0B4C-08AE-11E6-B8A7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292231>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Fri, Apr 22, 2016 at 3:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> [Cooking]
>>
>> * pb/commit-verbose-config (2016-04-19) 6 commits
>>  - commit: add a commit.verbose config variable
>>  - t7507-commit-verbose: improve test coverage by testing number of diffs
>>  - parse-options.c: make OPTION_COUNTUP respect "unspecified" values
>>  - t0040-parse-options: improve test coverage
>>  - test-parse-options: print quiet as integer
>>  - t0040-test-parse-options.sh: fix style issues
>>
>>  "git commit" learned to pay attention to "commit.verbose"
>>  configuration variable and act as if "--verbose" option was
>>  given from the command line.
>>
>>  Is this going to be rerolled?
>>  ($gmane/291382)
>
> The changes weren't that big enough and I had my end semester exams
> coming so I decided not to re-roll it.
> If you think contrary, I can do a re-roll with the changes suggested
> by Eric Sunshine.

I agree that this was pretty close to be done.  Let me see if I can
find time to finish it up in the coming few days.

Thanks.
