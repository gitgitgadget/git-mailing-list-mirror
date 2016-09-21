Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C5A1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 13:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbcIUNng (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 09:43:36 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37322 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbcIUNnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 09:43:35 -0400
Received: by mail-wm0-f53.google.com with SMTP id b130so92725979wmc.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=f653ilADFN5L5tDsFzEIzhOpIAN0Q26GAve3CGN2pMo=;
        b=yKT4Ff+Al4ilNM+b/dDbl4sl8KJsi6XyKV7e9ZYtPSB9FAL7dRfyTJzbDuzfXZvWUW
         pCtQlXXS1lfmvBY3EGombRf+Bq8w9ZA13Zl/idYWCtvEyoSXaiAaDPgenh8YQz1tiexO
         HSlp+RyBWzh2EvEtD34njeGijtWc2hqv6tUCFyy7IR1/QLrootLJvdaJvzAH44j1scNe
         s7L7psr/JxgzES9s2sQSfZdkR2fMt+rgX+Hl/eeJztFA++7e8DLCuDPJNmx2P+W25nkd
         lLF0sUr0lde+yRT6GCqE5UpLWRxO6se+ruTv1XS+p/ruf45r28N9OpI0QX9cNUWyO9Tc
         iSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=f653ilADFN5L5tDsFzEIzhOpIAN0Q26GAve3CGN2pMo=;
        b=lfSZAr/YIr+Z9MWPsuIs6zpp8NgxsALTz1hmtSCPZhqDip2v6KbWsCjIekyPgNRUmc
         aHMYKW+j7REgG+smSeXVJ8DRIZW9d9AQqPLZmMOP3983K2vJ0+pWqZQPOk6ZhahLbj4f
         RIfQVi/kpWg2+i/Ggn8tmheZ0BN+nFeyc8Ba3x1HhRHw9AJzUK4Rd7rxahlrgfNpvH2C
         Rv026g25viMJyzac76lL806vvkROTUSKc8XW0pix1vHtLfSCsJTSkOdkzZJNwJ/2XjHt
         6qtwGDAFBo7X/uXMrKg5wABxgovNmNVO0q23MEqGg5eZzM/Okg0RL+MyzMPXwkkY0MuA
         7p8A==
X-Gm-Message-State: AE9vXwMY9dCleG5mhrMs3KI/2J8nQRf6c2tngNrZvjp7VSAq1lPG4okO0c56Y1VebX8pfA==
X-Received: by 10.28.203.196 with SMTP id b187mr3157873wmg.120.1474465413471;
        Wed, 21 Sep 2016 06:43:33 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id yt4sm33642322wjc.48.2016.09.21.06.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 06:43:32 -0700 (PDT)
Subject: Re: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch name
To:     Bryan Turner <bturner@atlassian.com>,
        Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
 <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
Cc:     Git Users <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b1d35732-4b4c-e0c1-59da-44d3e3b28799@gmail.com>
Date:   Wed, 21 Sep 2016 15:43:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 20:54, Bryan Turner pisze:
> On Tue, Sep 20, 2016 at 9:23 AM, Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
>> Hello again,
>>
>> yah, sorry, i'm back again..
>> I try to find a way to find the name of the current branch in an
>> automated way, because i need to ensure that a commit happens on
>> it and no other branch.  Now the problem arises that the commit
>> ref at the time of that commit maybe shared in between several
>> different branches, but no more thereafter, of course:
>>
>>   ?0[steffen@wales ]$ git branch|grep '^*'
>>   * stable/v14.9

Not good, 'git branch' is a porcelain (user facing) command, so it
output may change; e.g. '*' could be replaced with '•'. For example
output for detached HEAD had changed!

>>   ?0[steffen@wales ]$ git name-rev --name-only HEAD
>>   stable/v14.8
>>
>> Is there another way except looking into .git/HEAD or using sed(1)
>> on the output of `branch' to find the right name?
> 
> Have you tried "git symbolic-ref HEAD"?
> 
> $ git symbolic-ref HEAD
> refs/heads/master
> 
> If you don't want the fully-qualified ref, you can add --short:
> 
> $ git symbolic-ref --short HEAD
> master

This does not work for detached HEAD, but perhaps you don't need
to worry about this.

  $ git rev-parse --symbolic-full-name HEAD
  refs/heads/master

But

  $ git checkout HEAD^0
  Note: checking out 'HEAD^0'.

  You are in 'detached HEAD' state. [...]
 
  $ git rev-parse --symbolic-full-name HEAD
  HEAD

  $ git symbolic-ref HEAD
  fatal: ref HEAD is not a symbolic ref

  $ git branch
  * (HEAD detached at 3e2ebf9)
    master

-- 
Jakub Narębski

