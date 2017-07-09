Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BABF202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdGIQ2Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 12:28:16 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34719 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbdGIQ2P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 12:28:15 -0400
Received: by mail-pg0-f48.google.com with SMTP id t186so38120611pgb.1
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FLKvEK3tlKXG7lE+3rjrEZ1VeEOp6zYn8j269vlB6kQ=;
        b=az35Kbd+OcD8ZeF/1+P+Ov3R5N5qGNNCJ5B+TIvX/9r8n9BpWRIbetQehACnV1GbJp
         od2B+M5AyLmHw/oCEsNTMVn2AqsKVi/XbCm2c45EI2Z/DJnrSe1nHzyu61uV7aDbDeP0
         CuEkN+S69OQIc2U0piygNQx5h25lUYj6dZ3SzWORs4n5jNHD7lKRxLaD0pP47ODT1Ma8
         TSJGyZ2C8lIuSVCRDYpR3jkoOPg1c89OouQ0Zlutcpr1neTAd0xooAycQkZPLAc9N2bj
         sz2ZH1q1FJs4D/kczzNI5L5SxG/cMuXpm5RxUr65kIA7U+Rb27iO7DoY6hzk9hwkgHDd
         aKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FLKvEK3tlKXG7lE+3rjrEZ1VeEOp6zYn8j269vlB6kQ=;
        b=QjiN+yTMaDFuFn/PtyR3T+iiHptO8+Jb30MZC2+mCDs+ozRqyDjiVvU0E6eaJB/b9p
         0ne+qv/tm9xDdFnIe1Oz2uo4j4D5g/+PPCF3Tfz3HKTK0ipTyUabG3a5iZSNuEGiomkv
         6x3ni2RmAoP8vpynOit0KeSdAenfRQSeLYrgd7GcK4AAzjNGbdGtbQ4YIsdrDnP8Dfuh
         VREjh8E29PfhCvkBpwHqtyAyOviUDnLgHnpJtkqNE1qV35vZ1Zhx/74vRIbvWxZc+VZf
         u7Goy4O1lFZMYsgS1/ZQ9LPnSfblXgD7U8HUQTrrPgfOGcYcK4L3LFR6qOaIKlXMQWx2
         yKvQ==
X-Gm-Message-State: AIVw111OxMy2mlaM3FTIAqxZij53nwVnpE8k2MpbOJynkrEFVElt+QRz
        g00yjnLkQRHJ3A==
X-Received: by 10.99.66.193 with SMTP id p184mr10688680pga.253.1499617694191;
        Sun, 09 Jul 2017 09:28:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id 189sm17621086pfe.26.2017.07.09.09.28.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 09:28:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leo Razoumov <slonik.az@gmail.com>
Cc:     Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.2: color.branch.local problem
References: <CADsUFkTgw5AGUafuBDEqRAUgzJeMZnQ1RL-_mz-QfiB=SV-xfA@mail.gmail.com>
Date:   Sun, 09 Jul 2017 09:28:11 -0700
In-Reply-To: <CADsUFkTgw5AGUafuBDEqRAUgzJeMZnQ1RL-_mz-QfiB=SV-xfA@mail.gmail.com>
        (Leo Razoumov's message of "Sun, 9 Jul 2017 11:57:34 -0400")
Message-ID: <xmqq37a5a82s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leo Razoumov <slonik.az@gmail.com> writes:

> On Sun, Jul 9, 2017 at 5:57 AM, Jeff King <peff@peff.net> wrote:
>> On Sun, Jul 09, 2017 at 05:28:34AM -0400, Jeff King wrote:
>>
>>> On Sat, Jul 08, 2017 at 03:13:04PM -0400, Leo Razoumov wrote:
>>>
>>> > When I updated from git-2.10.2 to git-2.13.2 my 'color.branch.local'
>>> > config setting gets ignored. Corresponding 'remote' or 'current'
>>> > settings are honored and work as expected
>>>
>>> Looks like this is a regression from the switch to ref-filter in
>>> v2.13.0; it bisects to 949af0684 (branch: use ref-filter printing APIs,
>>> 2017-01-10). It looks like we don't ever use BRANCH_COLOR_LOCAL. The fix
>>> is a little tricky because of another nearby issue. I'll send out a
>>> patch in a moment.
>>
>> Here it is. This is intended for the maint branch.
>>
>>   [1/3]: branch: only perform HEAD check for local branches
>>   [2/3]: branch: use BRANCH_COLOR_LOCAL in ref-filter format
>>   [3/3]: branch: set remote color in ref-filter branch immediately
>>
>>  builtin/branch.c        | 15 +++++++++------
>>  t/t3205-branch-color.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+), 6 deletions(-)
>>  create mode 100755 t/t3205-branch-color.sh
>>
>> -Peff
>
> Jeff,
> thanks for a quick fix!
> --Leo

Thanks, both.  Will queue.
