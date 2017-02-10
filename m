Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8111FD6A
	for <e@80x24.org>; Fri, 10 Feb 2017 21:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdBJVSA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:18:00 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36051 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdBJVR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:17:58 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so3907446pgf.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qc+iTQH32gna6LsYJmT3QwyP+8VJLQSIAMKiC1WkpW8=;
        b=DpyCOqKKTExKMMa1RqsTCch4LJ2HqdG6Q4F1glwo0LOTVex5icOQDmHjr1YdJ/aVTD
         O0wk3eJqWXzgLjNzLSmNNg6Bdlt7QyLu/IlzpiaqLQXCdh6YScgKJmZpJLA7hVCcOJX3
         /QD8ZRpXwOPPUiZ3Dms0dJ2INnd1rQm71mBaJ2lCfwkdS5DHz5SnipmpKZxNtIY2UE4p
         m2L3QH/uaaXbv1DkzXraCoFKwJ1kKifl9eMsDC1AIBm92fHiA4W5xTBE/2z/0FssV4yw
         WJ7Jmk2ufQWQs7UlKFMbLLOXRTzp5OHpYblniWmLbbqHkBvD2Tl6lCRQWcezpt73P9It
         fVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qc+iTQH32gna6LsYJmT3QwyP+8VJLQSIAMKiC1WkpW8=;
        b=laMBxB7f1uvfoexr5LMDRWEb/SJ76YEaHF2qYHpm6mEyBtEMtcYZkPpXznPyxKmjuS
         Y7MlcbIf96ROmGaog+9yw11b1+6s01c7tqXiAne0JxbgThThBfrMC+j04NlA5tSHn4G9
         4+uvZZzZfAMo5joSQvgx1eA+A01Z+JRRZr8gF7f1+7c6DNUI+l8cM+JKuA9EFuEfSoIr
         50Alg0Iwsl/q0cFs5sM34nyG1d0a5n2oBRU+hwVijARn4cknffb01zK4wTDgVVR6YZHC
         Ss6UvhzF2GYPOWzsY5CEG+BghGSo997X+aZP6dH/DJnOvccNr/D2P6MqFvJYOb/u2RMs
         PFEA==
X-Gm-Message-State: AMke39nGYRWBY/8Piwo1r33Qc2e5VZMkNcRH2sOrHJB/14kragp813Y0kLrH/nsSQf7jkg==
X-Received: by 10.98.1.213 with SMTP id 204mr12580357pfb.61.1486761477960;
        Fri, 10 Feb 2017 13:17:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id y23sm7338693pfi.66.2017.02.10.13.17.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 13:17:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <20170209034657.qbkzbbzuvjpxl422@sigill.intra.peff.net>
        <xmqqy3xgrlvh.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 10 Feb 2017 13:17:56 -0800
In-Reply-To: <xmqqy3xgrlvh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 08 Feb 2017 21:09:22 -0800")
Message-ID: <xmqqh941kanv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Mon, Feb 06, 2017 at 02:34:08PM -0800, Junio C Hamano wrote:
>>
>>> * sk/parse-remote-cleanup (2017-02-06) 1 commit
>>>   (merged to 'next' on 2017-02-06 at 6ec89f72d5)
>>>  + parse-remote: remove reference to unused op_prep
>>> 
>>>  Code clean-up.
>>> 
>>>  Will merge to 'master'.
>>
>> Hrm. Are the functions in git-parse-remote.sh part of the public API?
>> That is, do we expect third-party scripts to do:
>>
>>   . "$(git rev-parse --exec)/git-parse-remote.sh
>>   error_on_missing_default_upstream "$a" "$b" "$c" "$d"
>>
>> ? If so, then they may be surprised by the change in function signature.
>>
>> I generally think of git-sh-setup as the one that external scripts would
>> use. There _is_ a manpage for git-parse-remote, but it doesn't list any
>> functions. So maybe they're all fair game for changing?
>>
>> I just didn't see any discussion of this in the original patch thread,
>> so I wanted to make sure we were making that decision consciously, and
>> not accidentally. :)
>
> Ummm, yes, I admit that this was accidental.  I didn't really think
> of parse-remote as an externally visible and supported interface,
> but users have tendency to break our expectations, so, I dunno.

After sleeping on this, I doubt that the value of this "code
clean-up" is worth the trouble of waiting to see if a third-party
who dot sources parse-remote steps up, which may never materialize
while the topic is cooking in 'next' and more importantly risking
breakage on such a third-party.

Let's drop the topic and excise it from 'next' at the next version
boundary.
