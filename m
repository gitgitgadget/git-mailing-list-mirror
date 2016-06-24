Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9866C2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 12:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbcFXMZq (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 08:25:46 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35907 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcFXMZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 08:25:45 -0400
Received: by mail-it0-f66.google.com with SMTP id h190so2046023ith.3
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 05:25:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3oSh5Ik5oiWulhhGsi3KI2AtrBbU56gBGB88CuRbo78=;
        b=v0b3cipTgEeO5nk2mZPHBNciCOO1+r/Xg/ilrML5et+xMlN0uxGRZWQe1gMgKpcui1
         WJUJyQ0ejzOhPZOTFoCWRpKvqZCK5WnmaFBaKA4HR5OJRyBwfhI8Bp/9DR1mhsCt7ByW
         V2n2YcBCd26DbUnnakBNy7p4O+uF8w0GwR+32AOORKCNlP2UvoyYGqDvq3GzOk78U48q
         +3gZY2l47tZ+s/D/Mt5OSz+l0FqpqceLIQ42/QvmrwEh2YQWxpfT7JvvoR0T2LY0X6q6
         Ozv8iZNeskkmv5/ax3CTSmUUq75lOUeSqVaVB5hOfrwaQkM0ErsSLjdZb6wc/X3hprTe
         n2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3oSh5Ik5oiWulhhGsi3KI2AtrBbU56gBGB88CuRbo78=;
        b=VcmmtE1EyjF/px3KIpOy+bo/uZ/E0UHwb4koXK0G1rVuYEm6jeknyTKv4DSPmRoSVw
         Q9/DrB9DQByfX6CrU4WPdkHnEo4jh/0MmPNargMs1ZDa4Ah6mKiLKQPAfb+2d6q6o+wh
         kW1nwhdrzFmg4uM3HAuHagrnZ9hA6T/jXtgV1FFszOn7/aKMpU2WprYT/1oz5CT01rYg
         TgexLHmboMpDe+drKKIVxbJcg0HrAuTB06KkNnTWIIiDD5i7eYiPWXSzmaYTDDDWBLxJ
         b7A1MGJNnnKmIMg1J8WVQLO/fmuGFameYbORLA07UhrS7RCtFX6wEYAOOcEtGsWYZpub
         xg0w==
X-Gm-Message-State: ALyK8tLKaKjCHLUwZ1etA3Ra9DH2yDeRGCF6v/g8OfPtzpCelnIhGehhI4yAWYJ9blJgYpyEAPTOP3YPTZUiiA==
X-Received: by 10.36.98.136 with SMTP id d130mr25010692itc.84.1466771144582;
 Fri, 24 Jun 2016 05:25:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Fri, 24 Jun 2016 05:25:44 -0700 (PDT)
In-Reply-To: <CA+DCAeSvb14W5CoEa72DQtM+FHQ+jppSVvoTmQ7rX0EHQAMy6g@mail.gmail.com>
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
 <xmqqr3bpklsd.fsf@gitster.mtv.corp.google.com> <CA+DCAeQUJ4D4kjR6FtTibwPO8o+wv-hQNDDj2ysJaBHGTPkHgA@mail.gmail.com>
 <xmqqd1n8jtzk.fsf@gitster.mtv.corp.google.com> <CA+DCAeSvb14W5CoEa72DQtM+FHQ+jppSVvoTmQ7rX0EHQAMy6g@mail.gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 24 Jun 2016 08:25:44 -0400
X-Google-Sender-Auth: sE670adxvN7SYyzaT6HdN9c425E
Message-ID: <CAPig+cSHRWHUJ+P9nxQXz5YGigD7XOT24oUJs=JSR5L+xDoc0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce log.showSignature config variable
To:	Mehul Jain <mehul.jain2029@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 5:21 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Thu, Jun 23, 2016 at 12:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Mehul Jain <mehul.jain2029@gmail.com> writes:
>>> In patch 2/3 and 3/3, there are many tests which requires a branch
>>> similar to that of "signed" branch, i.e. a branch with a commit having
>>> GPG signature. So previously in v2, I created two new branches,
>>> "test_sign" and "no_sign", which are identical to that of "signed"
>>> branch. And with these branches, I wrote the tests in patch 2/3
>>> and 3/3.
>>>
>>> As suggested by Eric [1], rather than creating new branches, I
>>> can take advantage of "signed" branch which already exists.
>>
>> Yeah, I understand that part.  But you do not _need_ to do the split
>> you do in 1/3 in order to reuse "signed".
>
> If it's fine, then I think it would be OK to drop this 1/3. Without splitting
> the 'log --graph --show-signature' in two test will also serve the
> purpose for the new test to use the signed branch.

My understanding of Junio's response is that the missing PGP
prerequisite along with a weak commit message make for poor
justification of patch 1/3, however, if you add the prerequisite and
use the commit message he proposed (reproduced below) then it becomes
sensible to retain 1/3.

    --->8---
    In 2/3 and 3/3, we will use the same 'signed' branch that the
    first test for 'log --graph --show-signature' uses.  This branch
    is currently created in that 'log --graph --show-signature' test
    itself.

    Split the set-up part into a test of its own, and make the
    existing first test into a separate one that only inspects the
    history on the 'signed' branch.  That way, it would become
    clearer that later tests added by 2/3 and 3/3 reuse the 'signed'
    branch in the same way this 'log --graph --show-signature' uses
    that same branch.
    --->8---
