Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B986F1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 04:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeIZK5g (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 06:57:36 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41456 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZK5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 06:57:36 -0400
Received: by mail-pg1-f176.google.com with SMTP id z3-v6so8212468pgv.8
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 21:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=Tmz4g20XSkc+IIw9ecSYrU5XWgGCOvH1wvj597FezpI=;
        b=uXibjajQAjzyY5Up7MQ5PYS9RQMS+p3nyPLOxoqsQQPqBmpi1LuqEfnh6RidA1z+QD
         EMum8O1NPEHbhvZ8SQuIrGRjyDqQPwHQtDG7iDvZYQoVE8UIkK4JakkcfXSy0a52HDUo
         aRiRxPCUNyMxCAg4CoMOcc/eaxgHLnKHg8VJcxrzzAsx+9dip1QA1VB+khrp/abDCWYu
         dCzETPVXC+ZQX9nD/8FF80x3gaG/u51hytnm0Y5KAR7y6TuWVDpHWIzSv1rEkgcrpoEx
         fR2v8K59ltjT3ZIP5zPlUWbKGFquReBal9wzYRLWtK1UmqYkgq36DUQo8fFnRQVJdQKK
         N3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=Tmz4g20XSkc+IIw9ecSYrU5XWgGCOvH1wvj597FezpI=;
        b=Mxfozxdu4oqQxfs2wKLHW4dekl03EOH8xn9+BhZxdl35DMGis7aHKfQWMwOuAkAkfg
         rJyNucqcvTel3V5JsdpWXtq27ZaTmtxP6U56GAH2O2tCyzLvNm+Njdqz9y1uyZyP70YY
         BhgZnUNff8qCLNzflxSYxwF22YBWrEM/54WpfbicTix/dlxF471Ig5YJFgfjQZVtG8eJ
         KJQPrVpHicdCY8UERZu6+7xFTWikOuKXWBcQIqYwjUjnQEnJJVeXDCurIbtXSDUWutLC
         vZtbXS2ymv7xoxzV+/IwdZo6+1QjMZIZeVUTQzJ6+Z2AIydTCco/0Vox5pjWs1CQJLnZ
         BddA==
X-Gm-Message-State: ABuFfojZR4kMpVoTEsTgJXGGvP4qqFd1hKhmu2pHP57mhD8mj4ztHEqX
        r3ZQ6BvcbwngtAMp+HYljp9AdCNolGw=
X-Google-Smtp-Source: ACcGV63ffnNYTRXsKmq8s2/DhbajyeO015dZUW8ExCkLsCIsdvyWMgbOskh/w+o5H9AcQJLB9gLSEg==
X-Received: by 2002:a63:9809:: with SMTP id q9-v6mr3845651pgd.58.1537937194494;
        Tue, 25 Sep 2018 21:46:34 -0700 (PDT)
Received: from [100.80.53.125] ([27.62.128.44])
        by smtp.gmail.com with ESMTPSA id w23-v6sm5640627pgi.18.2018.09.25.21.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:46:33 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:16:20 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
To:     Git Users <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <39F9931A-B297-4525-A131-736B900F37AF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just wanted make a point a little more clear=2E See comment inline=2E


On 24 September 2018 01:39:26 GMT+05:30, Kaartic Sivaraam <kaartic=2Esivar=
aam@gmail=2Ecom> wrote:
> To add to that
>confusion when I run
>
>   $ cat $MAIN_WORKTREE/=2Egit/worktrees/$BUILD_WORKTREE/FETCH_HEAD
>
>it seems to be printing the info about the remote refs once and then if
>I run it again immediately nothing is printed=2E If I repeat it again,
>info about remote refs is printed but this time the info about the
>remote refs is printed thrice=2E This happens randomly=2E Sample output:
>
>   01:23 $ cat =2E=2E/git/=2Egit/worktrees/$BUILD_WORKTREE/FETCH_HEAD=20
>53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint'
>of https://github=2Ecom/git/git
>150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master'
>of https://github=2Ecom/git/git
>01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of
>https://github=2Ecom/git/git
>7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of
>https://github=2Ecom/git/git
>722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of
>https://github=2Ecom/git/git
>   01:23 $ cat =2E=2E/git/=2Egit/worktrees/$BUILD_WORKTREE/FETCH_HEAD=20
>   01:23 $ cat =2E=2E/git/=2Egit/worktrees/$BUILD_WORKTREE/FETCH_HEAD=20
>   01:23 $ cat =2E=2E/git/=2Egit/worktrees/$BUILD_WORKTREE/FETCH_HEAD=20
>53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint'
>of https://github=2Ecom/git/git
>150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master'
>of https://github=2Ecom/git/git
>01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of
>https://github=2Ecom/git/git
>7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of
>https://github=2Ecom/git/git
>722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of
>https://github=2Ecom/git/git
>53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint'
>of https://github=2Ecom/git/git
>150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master'
>of https://github=2Ecom/git/git
>01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of
>https://github=2Ecom/git/git
>7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of
>https://github=2Ecom/git/git
>722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of
>https://github=2Ecom/git/git
>53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint'
>of https://github=2Ecom/git/git
>150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master'
>of https://github=2Ecom/git/git
>01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of
>https://github=2Ecom/git/git
>7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of
>https://github=2Ecom/git/git
>722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of
>https://github=2Ecom/git/git
>   01:23 $ cat =2E=2E/git/=2Egit/worktrees/$BUILD_WORKTREE/FETCH_HEAD=20
>53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint'
>of https://github=2Ecom/git/git
>150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master'
>of https://github=2Ecom/git/git
>01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of
>https://github=2Ecom/git/git
>7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of
>https://github=2Ecom/git/git
>722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of
>https://github=2Ecom/git/git
>

This is the most interesting part of the issue=2E I **did not** run 'git f=
etch =2E=2E=2E' in between those cat commands=2E I was surprised by how the=
 contents of FETCH_HEAD are changing without me spawning any git processes =
that might change it=2E Am I missing something here? As far as i could reme=
mber, there wasn't any IDE running that might automatically spawn git comma=
nds especially in that work tree=2E Weird=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
