Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8C4207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755316AbcI2NBt (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 09:01:49 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33498 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbcI2NBs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 09:01:48 -0400
Received: by mail-pf0-f172.google.com with SMTP id 21so29040753pfy.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=wQ/aJCpbF5HeCmo0sUsFKsOFK46I6r9ADHI8Z4tyTgo=;
        b=PW802N3oJUi/a5G+avX8cE4mjPae5u+PW8xfCaLEtsVrS7lx2Tck3AFU7uTZhlJa/O
         AjZhqxgfYdeNShUhoGgjm2cORngcnG+ts3fb8MrrJzyvUU0Bv4y+LHUBVCZkEHtKFqK+
         p+jkloKrdkoAjq1YD/Z1YdmTdUVyd8vSJyq2/7zZmNRAS5aEkQCvQUIgbBqEz7xDGgQU
         ZBr0WVgj7867xQgyz/lLnXFSKojX4JbXevhX3/379eHE1WVFtcGB782qyvQ231PSN65m
         XsDROIwUc8S/rhgRfICX9PCqrc1J6XlzE6515yBH0KaCx9ILCYV7HwiLvQfSdHsZvHLK
         fSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=wQ/aJCpbF5HeCmo0sUsFKsOFK46I6r9ADHI8Z4tyTgo=;
        b=Z1H4mteO3RwbuMycVLY3bmTS0QAKibJH39cKlAUIZqqsIcY4gzoLb2yezGtTeXUwYv
         Nt2yeTPInfcGCwpnW0gaK12+XDKGa2OYi7kpSLXNFk+xNawXDO2HVFetIUgLn5Vmkakb
         a+jFtdiwuUJgzM1A/LTusJjQuQr+GMi7d9LgBt83Ozrez9UGn4OfmtphcTBuikrhMeKJ
         5CyYiSefEyzLU8ympodfNHpkTAbtTLW4vQnJvl1iL8mo0HEO8O/v5kZ5zfHplY7S6F9L
         4LlNzo9iMQijHdsq6m4gV0/VBAPC4lZisyyTqSagecglDlM+Ga7CIZzh/1yl35ibTbAQ
         NUXQ==
X-Gm-Message-State: AA6/9RlAarHixgzb36LgnA2oMRiYZTW7Q+d19xYopNjCPikG4lfI3Om0v7CgR4gLGLXZZg==
X-Received: by 10.98.22.21 with SMTP id 21mr2325886pfw.4.1475154107351;
        Thu, 29 Sep 2016 06:01:47 -0700 (PDT)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id i8sm20342821paw.25.2016.09.29.06.01.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 06:01:46 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
Subject: Re: Changing the default for "core.abbrev"?
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com> <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
Message-Id: <80D70A8B-0EB6-4118-8193-8D113621C57D@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Thu, 29 Sep 2016 06:01:44 -0700
Cc:     Git Mailing List <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 25, 2016, at 18:39, Linus Torvalds wrote:

> The kernel, these days, is at roughly 5 million objects, and while the
> seven hex digits are still often enough for uniqueness (and git will
> always add digits *until* it is unique), it's long been at the point
> where I tell people to do
>
>    git config --global core.abbrev 12
>
> because even though git will extend the seven hex digits until the
> object name is unique, that only reflects the *current* situation in
> the repository. With 5 million objects and a very healthy growth rate,
> a 7-8 hex digit number that is unique today is not necessarily unique
> a month or two from now, and then it gets annoying when a commit
> message has a short git ID that is no longer unique when you go back
> and try to figure out what went wrong in that commit.

On Sep 25, 2016, at 20:46, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I can just keep reminding kernel maintainers and developers to update
>> their git config, but maybe it would be a good idea to just admit  
>> that
>> the defaults picked in 2005 weren't necessarily the best ones
>> possible, and those could be bumped up a bit?
>
> I am not quite sure how good any new default would be, though.  Just
> like any timeout is not long enough for somebody, growing projects
> will eventually hit whatever abbreviation length they start with.

This made me curious what the situation is really like.  So I crunched  
some data.

Using a recent clone of $korg/torvalds/linux:

$ git rev-parse --verify d597639e203
error: short SHA1 d597639e203 is ambiguous.
fatal: Needed a single revision

So the kernel already has 11-character "short" SHA1s that are  
ambiguous.  Is a core.abbrev setting of 12 really good enough?

Here are the stats on the kernel's repository:

Ambiguous length 11 (but not at length 12) info:
   prefixes:       2
                   0 (with 1 or more commit disambiguations)

Ambiguous length 10 (but not at length 11) info:
   prefixes:      12
                   3 (with 1 or more commit disambiguations)
                   0 (with 2 or more commit disambiguations)

Ambiguous length 9 (but not at length 10) info:
   prefixes:     186
                  43 (with 1 or more commit disambiguations)
                   1 (with 2 or more commit disambiguations)
                   0 (with 3 or more disambiguations)

Ambiguous length 8 (but not at length 9) info:
   prefixes:    2723
                 651 (with 1 or more commit disambiguations)
                  40 (with 2 or more commit disambiguations)
                   1 (with 3 or more disambiguations)
   maxambig:       3 (there is 1 of them)

Ambiguous length 7 (but not at length 8) info:
   prefixes:   41864
                9842 (with 1 or more commit disambiguations)
                 680 (with 2 or more commit disambiguations)
                 299 (with 3 or more disambiguations)
   maxambig:       3 (there are 299 of them)

The "maxambig" value is the maximum number of disambiguations for any  
single prefix at that prefix length.  So for prefixes of length 7  
there are 299 that disambiguate into 3 objects.

Just out of curiosity, generating stats on the Git repository gives:

Ambiguous length 8 (but not at length 9) info:
   prefixes:       7
                   3 (with 1 or more commit disambiguations)
                   2 (with 2 or more commit disambiguations)
                   0 (with 3 or more disambiguations)

Ambiguous length 7 (but not at length 8) info:
   prefixes:      87
                  36 (with 1 or more commit disambiguations)
                   3 (with 2 or more commit disambiguations)
                   0 (with 3 or more disambiguations)

Running the stats on $github/gitster/git produces some ambiguous  
length 9 prefixes (one of which contains a commit disambiguation).

--Kyle
