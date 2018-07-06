Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FFAF1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGFJAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 05:00:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:34237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753304AbeGFJAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 05:00:21 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlE86-1g92et2lio-00b7Dj; Fri, 06
 Jul 2018 11:00:17 +0200
Date:   Fri, 6 Jul 2018 11:00:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Smith <paul@mad-scientist.net>
cc:     Git mailing list <git@vger.kernel.org>,
        Dan Jacques <dnj@google.com>
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
Message-ID: <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>         <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SZ99lmx31Arwc2wPVptAUzrynac8B3HkSQ5NtYw834E0guiNnvh
 UMtQK/OByMkIfgv4XdXe/T7xUhnzGQwFHmT3jdJTYg/KEEdEm0mzF3uifbI734xJkY9dKSU
 e3sLIL9rPWBtXKSKLlJjeCgCjJDIVnX4WPZJmZXH2si5kspC0fcCKyihza/us2T6e7euB7x
 zMpVvnHxn/i4kPKzjuXMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZXMCWLyidzo=:lBtyXu73kYRQGcYdXpsqHw
 ea13iaFq/TZxMAMCGRpRpAPl5SAV27mkTp4Tas2SnpIbo5WTjEy4cAZV9zNrbkor/LJjqs6Vt
 KjzBVYZUSFvEo6xAihzcclmRZxkhyx7FyBXpkcK4oT/PJMkY4Q7md+zUnnC0z2SRvHfxZWPE+
 wkPLkbTBi5tbXADS2I/z/pdmpDaRRiWXTgfVt3Dq7bg4u/KJaahaVog6ddAY7OU8DJjhTrii+
 r4AxWNuT8djTWewfK7qnsZByNqQifIuNNMDJaKjQIJoN6DMG4GO51T+ue/O2qDypt4YdRdHU7
 bTl9KJfYVV4o7ulnqCictgtWi3fNj/MGScRlY8d67bypnSe9X9mDNYToGKRFY/NaD4VZBuzjH
 04y05KUg+9TecBejKKyg5XMEwqVDIexm88nkYgrhONeTbZmaux5lIcR6N7BYqQX+HhyGpCdIx
 uAUUIXRggW2axYHJoBFGEM51fqZNQn9Iru7FhMJHgMN7jf56yIzD7YyFGP68sBNQXz/hrUnyE
 80fWg4VqB/+oH1sqZgGCD80SDj1R+ncTRp7bOhhpPUm6eVvro6sQ1GeX5nDXHAJbxgktfSXEQ
 6VDuIpoylj8frK2wXtmBSSE2ocFLVu5u8pTnfE/UpUrpepcn7Grs6qPVpXTxBJ/qQYO8tB8OU
 LNQLh3t7u6646Hamze2L2s0PV83oMdi0hScUhRtedAHtzkM9Ev49R0R4ZkueO1AkZ2zu0dnw6
 wd0hRUTtUDAjgze1DZ7oDp/UE1IcPG2VO2H/BTFQ02oTp9Y0G9WobiK0liIEguXTXVp28t/UI
 2x8bi++
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Thu, 5 Jul 2018, Paul Smith wrote:

> On Wed, 2018-07-04 at 13:22 +0200, Johannes Schindelin wrote:
> > > Basically what happens is that I run configure with
> > > --prefix=/my/install/path --with-gitconfig=etc/gitconfig
> > > --with-gitattributes=etc/gitattributes.
> > > 
> > > Then I run make with RUNTIME_PREFIX=YesPlease.
> > 
> > Ah. In Git for Windows, we do not use configure. I *think* this
> > points to an incompatibility of the RUNTIME_PREFIX feature with our
> > autoconf support, and this is a grand opportunity for you to step in
> > and help.
> > 
> > Essentially, what you will want to do is to implement a new configure
> > option --with-runtime-prefix that then prevents the autoconf script
> > from munging the relative paths in the way it does.
> 
> FYI I was able to get this to work by overriding variables on the make
> command line, like this:
> 
>   make ... RUNTIME_PREFIX=YesPlease \
>       gitexecdir=libexec/git-core \
>       template_dir=share/git-core/templates \
>       sysconfdir=etc
> 
> I agree a new autoconf option would be much simpler to use.  I'll think
> about it as I happen to have some some experience in these areas ;) ...

I look forward to reviewing this...

> but time is limited of course :).

Yep. Same here ;-)

Ciao,
Johannes
