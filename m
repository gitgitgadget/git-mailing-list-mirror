Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F0DC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 02:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C216136D
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 02:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhDDC1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 22:27:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64466 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbhDDC1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 22:27:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4DC7C3139;
        Sat,  3 Apr 2021 22:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y7HPStmd3nGT/oLPO7nrA0u2cqM=; b=GbFXMK
        r7Ig2JSfN75vG0q67FTncVdKMUqkYlxpHTOOcnlIEH9dMMrecwq+ezHJCLPS6dCz
        CLvRbMQc489U8oODvLxaDlhPCjn4um9QZiv7+10y1B56+pZCk5lKSA5S6k0BOuLL
        nZmoFzenq5RDDwOaD/SVKz5ITcSg+mcCZAIRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ITYGWKDEOtP8d6rE0ZXpqY+YmTF4tkOZ
        ALsRKZP3K2JNhAkTNh2d05oJrn2rxQJ0yQFeFgYaQRnCm627jc1i57I4VC6yCREc
        Cfpysug1nu6H37Dh96NHxZlRhSy3bP2ZHIaS5ZAtsSHrPqc1Jcwz5yiTuX0c4iAy
        Uu0fpjyJdak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD0D0C3138;
        Sat,  3 Apr 2021 22:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F6BAC3137;
        Sat,  3 Apr 2021 22:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reviewed-by given by celebrities (no subject matter expertise
 on Git development)
References: <345a7b27-8ee4-4b64-0340-40b002a25d1f@gmail.com>
Date:   Sat, 03 Apr 2021 19:27:12 -0700
In-Reply-To: <345a7b27-8ee4-4b64-0340-40b002a25d1f@gmail.com> (Bagas Sanjaya's
        message of "Fri, 2 Apr 2021 12:45:45 +0700")
Message-ID: <xmqqeefqzsvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4402190E-94ED-11EB-A08D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Junio, what will you do in such situation above (celebrities reviewing
> patches and giving Reviewed-by despite of lack of subject matter
> expertise)?

I find the scenario highly unlikely, and I do not see the point of
wasting my time on a trick question, thinking about what I would do
in a scenario that is not realistic, so I was tempted to ignore this
message.  If you have something you really want to ask, ask it
directly instead.

But I'll make it an exception this case, since you are relatively
new.

I do not think the celebrity status of a person who sends a
Reviewed-by matters.  What matters aroud here is the quality of
review that comes with "Reviewed-by".

Just a "Reviewed-by" without comments would most likely not count at
all, unless the perceived competence and expertise the reviewer
possesses in the area is reasonably high.

The "perceived" is a rather important word here.  It does not matter
how good one actually is.  One must have had demonstrated one's
competence and expertise on the list sufficiently to earn trust by
other readers on the list for one's "Reviewed-by" to really count.

"I read the patch with fine toothed comb, I found it very well done,
I have nothing else to add.", coming from somebody who is KNOWN to
know the area the patch touches well, would mean a lot.  When the
same statement was given by somebody who hasn't earned the trust of
the collective mind on the list, regardless of the celebrity status,
would mean a lot less.
