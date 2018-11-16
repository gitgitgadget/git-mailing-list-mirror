Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125901F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 12:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbeKPXBq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 18:01:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:54691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbeKPXBq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 18:01:46 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrvBu-1fK4ox3BK2-013d99; Fri, 16
 Nov 2018 13:49:29 +0100
Date:   Fri, 16 Nov 2018 13:49:29 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mikhail Matrosov <mikhail.matrosov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git pull --rebase=preserve is always rebasing something, even
 on up-to-date branch
In-Reply-To: <CADhDkKwHp0dR7PPLV6UZDmSO9ERW7Opym3FSD64XXTg-QK65bw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811161345580.41@tvgsbejvaqbjf.bet>
References: <CADhDkKwHp0dR7PPLV6UZDmSO9ERW7Opym3FSD64XXTg-QK65bw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3QvkwqiG16nSw+4qxIVhTYXxa+y0eYEDXS30nZmcMrvn+QqrSus
 6lZk5RitJ5y33tOmTAlFmm5HXGu9utRGX4cOGW96TNBg8PNEiirqo5mwReoyiuh+gIRHZ+5
 zeI97+gsAnQqxrbrYjXyWzgCJxMaWzUMsDiV+yOTXezYFJaPJb3jpW2KgiwRpkAkj+itZIE
 Vr5CrsQtFDMPSQCrHU0KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0eAaEPqMSz4=:unebn4x0J+e3nn8nM1taoF
 K00XtsqoLjfr2XKall/wqhmW1oOCvI6BJLK6mZ1MkjHpkDEmvK8TygHU52P0oUQzU2Qtkg9Fl
 CqmXCBL91+/63hJNh6wOLciYvDBS4BXSXZmKCtroBSvOjkdBUzia4O4bpe7lLQH6P2Eu9otI9
 O86rfnuY54nGCk9odDvHpplbR8kmwvJUkp/4Z5k67uaVrryCjhBv+WmtisboiJRlriXTuOnmT
 Y/U0GAyU3JC74rO0rMS7hX0sXY+EjoY9ALEMo6cA5a3RJ8Ww/vdlaAmwsmzUdsSsF0PvCqIAb
 Vb6zEF4anQ8xBOo3clSUkzALey/P1icjPON2NixbWuKJVXyBfBCmAnMLAJ3wW069ZgxYex6+N
 4ViKpNeKInfK+do5Bw8d1qgsMpf3YntHb7jYziX56+6yrJsBFZXXCAfj0IkENqGZGPKOm5x6o
 B31/KlylTo/JK51GD0KKosj2QONylz9BPLoA3C0WjEC9yOZkO9NOOQi78FYMRbFGn7/ORaOvl
 GgpZnG5TLV8c0vCWBaajqaNBjcxw1cRE1KxY01WecaUYoDEYZuYXAZBda7eWORVAX9dWPATpn
 IhJ8VQ5G6eOeyxqkaxufk+84VenhfVFekgKQ/YF7FQKB0heFeK2oaq/pfBTrchajF40a/Bo9a
 Cq9TKhhG2u5o142AxHvs9PWGIfFpBuRViQ6gR9IZaQLsXWo2Ev3LaC8R7qBKe0QPByEnuk+Bp
 l9fmiYB/hkKR9Z7iMO3wECI94yAMLTz7QU4shD4UJqZbwV3FaAvcpwZUz26KLJZZQAybefeMO
 X8eqUogKIdGgAT8ayGeFOJsoozGKWOwy9+1I4gxeVl/zBbdrPz3WkBwQNZozk3RTT5KIeB+ou
 NE6jS/mf7I/rKM4oi/Ch5htImDcu1xOHVcRZBnYRroVTfCd5fCOazsTQu/wXanDbUOO2FqkY2
 cOrZi/ZM+Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mikhail,

On Mon, 17 Sep 2018, Mikhail Matrosov wrote:

> Please try the following:
> 
> mmatrosov@Mikhail-PC:~/test$ git init --bare server
> Initialized empty Git repository in /home/mmatrosov/test/server/
> mmatrosov@Mikhail-PC:~/test$ git clone server local
> Cloning into 'local'...
> warning: You appear to have cloned an empty repository.
> done.
> mmatrosov@Mikhail-PC:~/test$ cd local
> mmatrosov@Mikhail-PC:~/test/local$ echo a > a && git add . && git commit -m A
> [master (root-commit) a34c21f] A
>  1 file changed, 1 insertion(+)
>  create mode 100644 a
> mmatrosov@Mikhail-PC:~/test/local$ git push
> Counting objects: 3, done.
> Writing objects: 100% (3/3), 205 bytes | 0 bytes/s, done.
> Total 3 (delta 0), reused 0 (delta 0)
> To /home/mmatrosov/test/server
>  * [new branch]      master -> master
> mmatrosov@Mikhail-PC:~/test/local$ git pull
> Already up-to-date.
> mmatrosov@Mikhail-PC:~/test/local$ git pull --rebase=preserve
> Rebasing (1/1)
> Successfully rebased and updated refs/heads/master.
> 
> As you can see, running bare "git pull" just tells me everything is up
> to date. However, running "git pull --rebase=preserve" triggers
> rebasing of something.

This is most likely a `noop` command.

> It wont be a problem if it didn't take significant time (especially on
> Windows). Why this rebase happens? It is completely redundant and slows
> down the pull operation. Looks like a bug to me.

It is an implementation detail, and if you want to work on fixing it,
please let me know about your availability and C skill level.

> 
> Note that it is important to me, because I want to set "git config
> --global pull.rebase preserve".

Please note that `preserve` is on its way to deprecation, superseded by
`pull.rebase = merges`. Which may, or may not, share the performance
penalty you reported. Probably not, though.

Ciao,
Johannes

> But because of this issue, pulling on an up-to-date repository takes a
> lot of time. Which is very frustrating.
> 
> Tested with:
> * git version 2.19.0.windows.1 in Windows 10 Version 1803
> * git version 2.7.4 in Ubuntu 16.04.3 LTS (inside WSL)
> 
> -----
> Best regards, Mikhail Matrosov
> 
