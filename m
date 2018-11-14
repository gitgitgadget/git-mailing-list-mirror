Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9AD11F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 06:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeKNQiS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 11:38:18 -0500
Received: from mut-mta1-se01b-zose1-rescue-fr.yulpa.io ([185.49.22.249]:44382
        "EHLO mut-mta1-se01a-zose1-rescue-fr.yulpa.io" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730764AbeKNQiR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 11:38:17 -0500
Received: from mut-zose1-mta-hub-out01-fr.yulpa.io ([185.49.20.54] helo=mut-zose1-mta-hub-outweb01a-fr.yulpa.io)
        by mut-mta1-se01c-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1gMomj-0008PF-5Z; Wed, 14 Nov 2018 07:36:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id A2B3CC1F53;
        Wed, 14 Nov 2018 07:36:19 +0100 (CET)
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 23fwB-i0Ro0x; Wed, 14 Nov 2018 07:36:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 39F3BC1FDB;
        Wed, 14 Nov 2018 07:36:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0oMSnXE_Khv9; Wed, 14 Nov 2018 07:36:19 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 1BDB7C1F53;
        Wed, 14 Nov 2018 07:36:19 +0100 (CET)
Date:   Wed, 14 Nov 2018 07:36:18 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <850526490.3010891.1542177378884.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <xmqqva50p9c6.fsf@gitster-ct.c.googlers.com>
References: <20181113203909.30740-1-avarab@gmail.com> <1615698920.2718456.1542145071499.JavaMail.zimbra@matthieu-moy.fr> <87wopg1w2z.fsf@evledraar.gmail.com> <xmqqva50p9c6.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH] push: change needlessly ambiguous example in error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF63 (Linux)/8.8.9_GA_3019)
Thread-Topic: push: change needlessly ambiguous example in error
Thread-Index: ZXo/g4QVs/XX+JcxSodsd0YafF7LwA==
X-Originating-IP: 185.49.20.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.49.20.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.24)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5lO3ENjeQVXjK4gdfcNQ//5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOwrYoqzMxT6gMCeBPAUkqyQ0CJhnYiKdGsKpOYs5RJfzz2brY6bg3EwRxcvmrkhcFRqU
 4slMuZzrs+tT2mKwxPmzFTRqUk3xj4GX+CqJAgxTzh/LaJIPlXlnWIF3GigTwPe/lsWrWRXkObV5
 ltnrj/nJNh4cbN+j0ziuJSTEMQEJbiBAiRpQvvEyGKT6gD4+tacKjNmpo1SUV0zpTG0/bHgEUheq
 be+1yYjs8UolW47MCu6yDRBWW7ujT/6/KDj8Hc8sSv8WFqyyJPAytU97larySh4QbkqpPYvE4vGw
 ygi67JG2Znmc0y9WExHXx7tawlB62eJn0Sz4SJbLwvOkOssQK7bgC87UhCp48RrejMPUpSxP04VS
 mMgWMN25CInpWEzeIhE7Er1q+6E3cmcuBLfeCWe9K/uftV9HEwrt2JhWrtsGyMx2KNl7IMTcQKAv
 fcBZ6/A94Jg5ba0WptFBUpBOcX8WyXsibcwzJ/2LJZookKqwi0NwvAsomyEdQk+VgvVdyPOcJwZf
 +mGEJuzRRI/4aSYayPrZZbV66ClVZKYB/DBRRugIMHgMFXxYn1zyxx6g9BXIOvQKJzGL8PzTLKL6
 Gew4jH22624bXqDj0nE6U/NaaiGPzf1EC9d8UhI/ETZ272iDqkgqqMFvytf7a1QRFZ4oobg8BBg3
 Jq+ntzj0uS+K2CFcXFtb6z0pYlmyx/oPhxKyxdjOdWtDFx3CJK1FsXKgfrmL5iaZ2FdSEP1Ozfoi
 YjyreLIULcnGHcPLxv/zm5i+QdkbSGuCF/kD1qOZMFvKVU65EJYn6zSIo0mW5v/oDYJzw7SN6382
 WdSLOOuO5TcDeKjrEmYPn2IVWRsZxl99sxIRMxgmB46KfQEz1npdCVhMBE1WGBmBqOKL7c1+pGLv
 AFAR60JGLtkKnj81lfwBlzoNEpB9QCKXQ/ZstVEDN46y+ABXlCiak/GuRyN/kTWc7zz872d2mnf6
 DpRhJK0lz80UvuY/i6vlgmhmMp/+hVlklmQSI+ffVaZM69YNisEeNVs6ZVLKIeiuSHI=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano" <gitster@pobox.com> wrote:

> > Where 'topic' is a tracking branch of 'origin/master' (I use
> > push.default=upstream). I only recently discovered that I could push to
> > 'HEAD" to do the same thing. So one ulterior motive is to make that more
> > prominent.
[...]
> Do we consider the current behaviour useful? Is it documented

Yes, since 1750783 (Documentation: more git push examples, 2009-01-26).

It may be an accident that the doc says "to the same name on the
remote." since it predates the introduction of push.default, but it
does say so and it's the actual behavior.

> already and widely known?

https://stackoverflow.com/questions/14031970/git-push-current-branch-shortcut

458 votes for the answer suggesting it.

-- 
Matthieu Moy
https://matthieu-moy.fr/
