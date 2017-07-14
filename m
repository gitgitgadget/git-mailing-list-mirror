Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821A720357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbdGNO7T (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:59:19 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33247 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753968AbdGNO7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:59:18 -0400
Received: by mail-io0-f172.google.com with SMTP id h64so15703253iod.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BK9xrMNc6DMouTCBgWJVUv5cDa73KvvEG45t3Vh9eMg=;
        b=r1HHNZQRvLAt3S66eOjJ0HPlExTBhufmReKIEdP1Ey+hNfwgj+v9iqpQOQ0wV6ARZh
         fCqny2TR9GtIdbBAAbpN8C/NMNfPqMKcvidGyXDm70feOQ2IsErnFxpB6Jyn0mbyaQmh
         zeS4gAVMNOHtOR4QYZ33kgzeZYEiRMv+AJU8wcTugWuba3P71rCxNkxrFMKVegwJhMXI
         jI5N/3aBOyMn6309DfTllRJOC3ZttTnKMzHmVcHuehSEJymO72E+ff0KhBRvR59ubpZR
         c/XATtdVq7oULNx5U1ctNpYWptDrGr1l9jEVyKMMxV7JcociigbUu+knbjM3C7n1LvSO
         qwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BK9xrMNc6DMouTCBgWJVUv5cDa73KvvEG45t3Vh9eMg=;
        b=DsHkEQEpQA1USdZy2H+aeRLpFoeS9z/RvjV5iJr9bnFF9myRO/WNmzla3nx1qemTZA
         tYvPGbo6KS9ulVErYBcAxA/ubo4OUL678rbyyqcfeCPEddVxv5544FGI/OSP07bfDs6V
         GVcYLLNzwQ6Fyv4FJp7LQMfNxgndIDU5vzqmruLTbHkn69SNSN1sigeWadR2I1+gMpZD
         +6LTLM6TFZeXjR1XF48vNbR8qs9dkEwTK6GAb/IoVQmYmjxxO2fGZ+bQxL697L8KEuaH
         +BsXSKeBgsVu/35kc/aY4fg403hSEDuv7c+s9ud8+yB3DxgLFor+qq+9Dy8rGbk1vqOy
         ZPaA==
X-Gm-Message-State: AIVw113z6XUrbdNyMxpcILYgUjTGcZMkBp0DEF8QdgPL+B86NUoS4ley
        ZvkCQKa+VcF3GeOhXATyHYmgxjtJslHs
X-Received: by 10.107.16.9 with SMTP id y9mr8796992ioi.134.1500044357462; Fri,
 14 Jul 2017 07:59:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.34.16 with HTTP; Fri, 14 Jul 2017 07:59:16 -0700 (PDT)
In-Reply-To: <1500043024.25789.105.camel@mad-scientist.net>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707141625150.4193@virtualbox> <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>
 <1500043024.25789.105.camel@mad-scientist.net>
From:   Kavita Desai <kvdesai2@illinois.edu>
Date:   Fri, 14 Jul 2017 09:59:16 -0500
Message-ID: <CAAu0pLdjvcxda0rip8JOzt1q0HNuu4dBNHvEzJbeey6yRSyCCQ@mail.gmail.com>
Subject: Re: Git Bash Bug
To:     paul@mad-scientist.net
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the results.

What does "echo $PATH" show?
/c/Users/Kavita/

What does "type -a ls" show?
ls is aliased to `ls -F --color=auto --show-control-chars'



On Fri, Jul 14, 2017 at 9:37 AM, Paul Smith <paul@mad-scientist.net> wrote:
> On Fri, 2017-07-14 at 09:34 -0500, Kavita Desai wrote:
>> Sorry for not being specific. What I meant by not working was that the
>> bash commands are not found.
>> Here is an example
>>
>> $ ls
>> bash: ls: command not found
>
> The most obvious issue is your PATH is wrong.
>
> What does "echo $PATH" show?
>
> What does "type -a ls" show?



-- 
Kavita Desai
UIUC Engineering Physics 2018
Engineering Outreach Society Engineering Open House Chair
UIUC Housing Ike. South Front Desk Clerk
