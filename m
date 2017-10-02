Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ED820281
	for <e@80x24.org>; Mon,  2 Oct 2017 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdJBQ7p (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 12:59:45 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:55734 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdJBQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 12:59:45 -0400
Received: by mail-qk0-f182.google.com with SMTP id q8so5812777qkl.12
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YQgXX8gV74QXDJgpxqEHmylYWu+C4Tbxre2WX8UAE5o=;
        b=XLK+oAEHnRGoTGslyHWZWhaPn7AhH/mKG6J+jd1ziJWAqhWkRQ7sfmu//LUVyFypOs
         g12TdM4Mgo7D3bFiE0De6kPoYbedcH91LMTArtGVzCjeaRsrKLPZe0tAc36CMNXQJmcP
         wckTF75WEz3WA6ciiJzuAcMIqyGdeqA6LtDJsurKXIL1glxoK5WzX+1/53l8bKPLpz9X
         Ex4/1RPgX0WWLO5RdLePgUAUm/LSGYs5dmWvpIFiWMHswu9yFYEDNHS+SClnfjjUDuIQ
         vOt0rqEx7PllaVbdekL+lg1LnB6ZkoGyDmPEzr4WyxiwJvWbROmcQqenYYVS9Tf2UzAk
         GOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YQgXX8gV74QXDJgpxqEHmylYWu+C4Tbxre2WX8UAE5o=;
        b=gKZy8H5wpBV6/N0hojekYlRZNLjXsmrI+Nn0XghVXBlZKHlMzDXjl2d4hEWnnpO0/a
         KTGhdtduIWvkHNpT50XZOAaEVSM1tViiwWTGYtqymisAuCSrHN9RnKBB93OB4qzFrNse
         ByUeJ/o7f5bpF2fhmrH9W+dshhb6z9uU2YU8xLan/Pa5gUajYmLf5hDWoTRLkBVgr4zn
         jzrdEM5jkZbKxun5SjMMq3QV7oUDqthwlwDyZ0DGQ0oiYaC4w55LoMNUnYgQBQc2xTTE
         +hRWFOqk4Ih7PU4pXC4SBV+6vjy92QA9fZPc9SLKgtUxykFi5tLRViE4jS9WPmon+M8s
         SoeQ==
X-Gm-Message-State: AMCzsaWJVhznr68NCglrrTL34N5lIpLSTCvSD7A3b/4OVOCXkd2RT5ki
        dB8ZFANrDrnnLqG4pBv25e11Zd93f7eqGFaLxcIrhw==
X-Google-Smtp-Source: AOwi7QD2I/4tAKt/DF/RaXKG9UnTNAzxAMYusten1m0qz9bZEIPORbUxaAN7ag8/0UIlHv+NxjBy+gYUlduWg42B3Ro=
X-Received: by 10.233.239.82 with SMTP id d79mr5512446qkg.308.1506963584111;
 Mon, 02 Oct 2017 09:59:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 09:59:43 -0700 (PDT)
In-Reply-To: <xmqqfub2p014.fsf@gitster.mtv.corp.google.com>
References: <cover.1506081120.git.git@grubix.eu> <xmqqfub2p014.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 09:59:43 -0700
Message-ID: <CAGZ79kaf9Me+zR+ij4h=0tzULU1qmB+rbjVkK3naXyvn+WTq8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] pre-merge hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2017 at 10:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@grubix.eu> writes:
>
>> Now that f8b863598c ("builtin/merge: honor commit-msg hook for merges",
>> 2017-09-07) has landed, merge is getting closer to behaving like commit,
>> which is important because both are used to complete merges (automatic
>> vs. non-automatic).
>
> Just a gentle ping to the thread to see if it is still alive.
>
> I think people agree that this is a good thing to do, but it seems
> that the execution leaves a few loose ends, judging from the review
> comments that have yet to be answered.
>
> Thanks.

I agree. IIRC the series was ok in design and goal, just minor comments
for coding.

Thanks,
Stefan
