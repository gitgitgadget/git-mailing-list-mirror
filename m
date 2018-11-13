Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FF61F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 22:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbeKNIDu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 14 Nov 2018 03:03:50 -0500
Received: from mut-mta1-se01b-zose1-rescue-fr.yulpa.io ([185.49.22.249]:45484
        "EHLO mut-mta1-se01b-zose1-rescue-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbeKNIDu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 03:03:50 -0500
X-Greylist: delayed 1548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2018 03:03:49 EST
Received: from mut-zose1-mta-hub-out01-fr.yulpa.io ([185.49.20.54] helo=mut-zose1-mta-hub-outweb01b-fr.yulpa.io)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1gMgNd-000KYt-Sf; Tue, 13 Nov 2018 22:37:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01b-fr.yulpa.io (Postfix) with ESMTP id B39CF101F7E;
        Tue, 13 Nov 2018 22:37:52 +0100 (CET)
Received: from mut-zose1-mta-hub-outweb01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2-UFCyaePWF3; Tue, 13 Nov 2018 22:37:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01b-fr.yulpa.io (Postfix) with ESMTP id 31A4210202B;
        Tue, 13 Nov 2018 22:37:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outweb01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7ob0LZYnB1L7; Tue, 13 Nov 2018 22:37:52 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by mut-zose1-mta-hub-outweb01b-fr.yulpa.io (Postfix) with ESMTP id 0DA7A101F7E;
        Tue, 13 Nov 2018 22:37:52 +0100 (CET)
Date:   Tue, 13 Nov 2018 22:37:51 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <1615698920.2718456.1542145071499.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <20181113203909.30740-1-avarab@gmail.com>
References: <20181113203909.30740-1-avarab@gmail.com>
Subject: Re: [PATCH] push: change needlessly ambiguous example in error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF63 (Linux)/8.8.9_GA_3019)
Thread-Topic: push: change needlessly ambiguous example in error
Thread-Index: GclIZg7n5ko6xrJ1hdC6bLnCohTNSQ==
X-Originating-IP: 185.49.20.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.49.20.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5maHP7P6hAXJIwlT8WX6A+N602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOwrYoqzMxT6gMCeBPAUkqyQ0CJhnYiKdGsKpOYs5RJfzz2brY6bg3EwRxcvmrkhcFRqU
 4slMuZzrs+tT2mKwxPmzFTRqUk3xj4GX+CqJAgxTzrmvGL2Zv9PMQguvQMyWMfe/lsWrWRXkObV5
 ltnrj/nJNh4cbN+j0ziuJSTEMQEJLgnPXBqLzTG5ro+v4QItqacKjNmpo1SUV0zpTG0/bHgEUheq
 be+1yYjs8UolW47MCu6yDRBWW7ujT/6/KDj8Hc8sSv8WFqyyJPAytU97larySh4QbkqpPYvE4vGw
 ygi67JG2Znmc0y9WExHXx7tawlB62eJn0Sz4SJbLwvOkOssQK7bgC87UhCp48RrejMPUpSxP04VS
 mMgWMN25CInpWEzeIhE7Er1q+6E3cmcuBLfeCWe9K/uftV9HEwrt2JhWrtsGyMx2KNl7IMTcQKAv
 fcBZ6/A94Jg5ba0WptFBUpBOcX8WyXsibcwzJ/2LJZookKqwi0NwvAsomyEdQk+VgvVdyPOcJwZf
 +mGEJuzRRI9W7tcm6VbJ/KBDRoQaEcIUoDJoNYDAZdxahBvYmU+WWBh73KzxfMmYsjdadErJAWX6
 Gew4jH22624bXqDj0nE6U/NaaiGPzf1EC9d8UhI/ETZ272iDqkgqqMFvytf7a1QRFZ4oobg8BBg3
 Jq+ntzj0uS+K2CFcXFtb6z0pYlmyx/oPhxKyxdjOdWtDFx3CJK1FsXKgfrmL5iaZ2FdSEP1OmJeq
 0J/kp4FlVaN86+Q3Gxo/D6gMJpIjpeagEFypdtKZMFvKVU65EJYn6zSIo0mW5v/oDYJzw7SN6382
 WdSLOOuO5TcDeKjrEmYPn2IVWRsZxl99sxIRMxgmB46KfQEza+8+irGDX0S+L12Qrk5na81+pGLv
 AFAR60JGLtkKnj81lfwBlzoNEpB9QCKXQ/ZstVEDN46y+ABXlCiak/GuRyN/kTWc7zz872d2mnf6
 DpRhJK0lz80UvuY/i6vlgmhmMp/+hVlklmQSI+ffVaZM69YNisEeNVs6ZVLKIeiuSHI=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason" <avarab@gmail.com> wrote:

> Let's use "git push <remote> HEAD" which always means push the current
> branch name to that remote, instead of "git push <remote>
> <current-branch-name>" which will do that under "simple", but is not
> guaranteed to do under "upstream".

Probably a good idea indeed.

One potential objection though: I think many people know

  git push origin master

(not that they necessarily understand it, but I've seen many people talking
or asking questions about what "origin master" is)

This "git push origin HEAD" is IMHO less common. It may confuse users.
Or users may learn it and be happy thanks to your message. I don't know.

-- 
Matthieu Moy
https://matthieu-moy.fr/
