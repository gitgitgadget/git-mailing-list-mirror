Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF281FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 10:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdFGKj7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 06:39:59 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35555 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdFGKj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 06:39:59 -0400
Received: by mail-wm0-f53.google.com with SMTP id x70so54890776wme.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m44ZarVwjQSaJDpa/BZxNAcz2x0exJudiSKmOPAXZAI=;
        b=lJHBsfD1jjgZh8VGRUvx0UFfVis6LlZxIXQbOz4hoXa0r/luylMYAsnTvIqgqSvlX2
         jZ2be6UK5XWr9C3TEbuIoj7FxmsLnAtsSK9j9CBdybyKnBUfCuqYwFNqZlzajqdDtEiE
         FwTRT1JMDI5wnxjEjzpuLaTXaxTEkUbme5WnoetoARt/wgBxhRyk66WXyt9Daeh0C29J
         zj+GsZmkK0Msu/sFik/gewoa+we6auyEac59Z+3OWC5WkDaunKQxjYuqaWVQU0ocUHiy
         WjpACQIZjrdhAKCYsZy8mKBNLcT/45BHBQe1wRcIaPz5mxvHVpTha86QcsPaGBx0IfZH
         Z+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m44ZarVwjQSaJDpa/BZxNAcz2x0exJudiSKmOPAXZAI=;
        b=o1uHsUHfXbC6buLomOCGHioaEr5Jc2eIekBZTZqQrw/vSe5UQYSzDpjVygG3/NoPA6
         NAIFjNw/thTiqdwL2yVJVCrj7SEOXhqjqP3OnAaigF7dI0fMGFQpRuFkTIYbQ6yllqyu
         txIiFh8LwhrWKTh8skQHKWPZ9yDHCe1ws6d7gfO+myXr5Sim0D571zMjVQPGlas6cg3U
         3yOZLt6a3ScUZ4cL23J1FnTvE1hWR3Q8EwTNLBdSaPg/M/Vq/YYfgnT0taSHPLrl5Pcj
         NX4ohjaUhUgR7iomjb6Z/qQDSV1xIlejVfXHSXDRWeUHWUxDmWm+CSulnaqGWY0U5DwR
         vMHw==
X-Gm-Message-State: AKS2vOy6iik4zbCX8EDMDU39izNoxYrtOrrBVs2ik/GOv1wuIwJdvtNw
        /R9zdUbyI4IAQ6yQBQImeDIORQJDx/XjUuI=
X-Received: by 10.28.0.78 with SMTP id 75mr1729484wma.58.1496831997639; Wed,
 07 Jun 2017 03:39:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.105.139 with HTTP; Wed, 7 Jun 2017 03:39:17 -0700 (PDT)
In-Reply-To: <20170607103326.GB27719@alpha.vpn.ikke.info>
References: <CAPMsMoAYpS8QMrfyed5=XPWJLbV6=kMg5gp-2a75kWMpVD3D1A@mail.gmail.com>
 <20170607103326.GB27719@alpha.vpn.ikke.info>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Wed, 7 Jun 2017 11:39:17 +0100
Message-ID: <CAPMsMoCi4JRB7e6DLLOx+i-Gbfeh=EXeytWPn0WruOPJQZ0vow@mail.gmail.com>
Subject: Re: [BUG] Failed to sign commit
To:     Kevin Daudt <me@ikke.info>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the hint!

$ GIT_TRACE=1 git commit --allow-empty -v -m "lol"
11:37:24.594795 git.c:369               trace: built-in: git 'commit'
'--allow-empty' '-v' '-m' 'lol'
11:37:24.605842 run-command.c:369       trace: run_command: 'gpg'
'--status-fd=2' '-bsau' '8AEC0DB537A9FC7E'
error: gpg failed to sign the data
fatal: failed to write commit object

It seems more a gpg problem no? something not well configured after
the update perhaps?

2017-06-07 11:33 GMT+01:00 Kevin Daudt <me@ikke.info>:
> On Wed, Jun 07, 2017 at 10:46:08AM +0100, pedro rijo wrote:
>> Recently I've updated a bunch of stuff, including git and gpg. I'm using
>>
>> - mac OS 10.10.5
>> - git 2.13.1
>> - gpg (GnuPG) 2.1.21 / libgcrypt 1.7.7
>>
>> When I do
>>
>> $ git commit --allow-empty -v -m "lol"
>> error: gpg failed to sign the data
>> fatal: failed to write commit object
>>
>> I tried the verbose flag hoping to have a better insight, but not very
>> useful. Not sure if it's a gpg problem, a git problem, or something
>> else.
>>
>> Any clue on how to debug the problem? Do you need any gpg output to
>> better understand the problem?
>>
>> Thanks,
>> Pedro
>
> GIT_TRACE=1 git commit --allow-empty -v -m "lol" might give some extra
> feedback (ie, what gpg command git runs), and try to see if you can
> replicate it.



-- 
Obrigado,

Pedro Rijo
