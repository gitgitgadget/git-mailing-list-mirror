Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E9E1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJXQjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:39:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:39897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbeJXQjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:39:15 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfCX2-1fmk9O06Aq-00okUK; Wed, 24
 Oct 2018 10:12:06 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfCX2-1fmk9O06Aq-00okUK; Wed, 24
 Oct 2018 10:12:06 +0200
Date:   Wed, 24 Oct 2018 10:12:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] repack: point out a bug handling stale shallow
 info
In-Reply-To: <xmqqr2ggovxk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810241004440.4546@tvgsbejvaqbjf.bet>
References: <pull.9.v2.git.gitgitgadget@gmail.com> <pull.9.v3.git.gitgitgadget@gmail.com> <ed8559b91b7a3b51a5950d62e78fc726ed5b44c2.1540245934.git.gitgitgadget@gmail.com> <xmqqr2ggovxk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:egaZuPo9lc4PcTquThtY+0Cd1a2dv4M+qJUMmWfoDepLeFRbwdP
 JkTEE0ZDak1pE4qmwJaoVtXqs7hdXeDKAWoc5n3TSw7EL1FpeJ3jEhwTcHLJjs5L9bHSZSG
 vdEPtFhtK33DPxGfFQUTvc60eLHspl3n4FX8K569R+0LI5FN2ygm0xnU+7n3sCOh8wC9Y4v
 J6w8BcjgKirnQnYtzGMQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n0EOqnA0kkc=:8dD/8Rh2e6PvIbjwmI2VV8
 g66z5gBQ5mAM1RKwr0Ed9HtaSVDexuDjDDT8K9cUKE2rBaCnrf9ii/sW7nhPA9l39yWUmVO6n
 NCxofrcPhODH/aBM/fYYxFXZYlsyJy6+DAShzZqGFDT184MepzeUF/0PBdemQgFjf5CVTQVTL
 7tga4aTQDExspnwffPGqO3DV+mXzH/WNfh8j/VUUyW5dufGIEsIbH9DkYsqB+d+8F4XJrghRH
 ePoPxpJdTgx7XgCxnRjvr37pY8xRMgwu1CX4W/isiSjuQLgEVE0AO8X5jpltpXGPR1b5ds8Rs
 13WXIWjXGWLE7G2buVnhlqyEJZ+0uFjPLzObXN15aYXhxzHNvtyWokIQv4eh8G8VZbUaBvfAk
 t2HE6h8F0bQJIUcYGjmp8ku6t41AFh4c+pdRoTn0/WMaeWP14WQUftiz7MbY+9Fa9wZOjDpCk
 JvA+NbgrGPr8LXpOkIhX66zgCLldbqLYKgBQG1CBB+rJHLol3Bnej1TqGEyWjNNDRws+gjh/k
 fHChJxGTZGWEPQf8uAQ025Nfn/2RcwdbRSeAgBuLAagPqNcCdHJIt/tprwsIqLjr5Dd8b0Q0L
 O4Z2kJE/ZOvtdH/Wyy6mnEDvj4Oj+zM2qPesi+vDVeruUCcpxJ6uvmJBsjUCPgdGlIEj9ftex
 AcA8hpumTluWTGbo3GeeMnqDnCTajAPaTSGJpkmZhzYEVDFtRBTUmkMvmYncT2APwGnprNvtW
 Ex4j69obeIcJZbnD/CxBWo8NOlCbOVc01D2zAV3WdFx1IOrvX19jLud5sSeo8pke2h7anrOZW
 yygAv79LFKxwTPaXYBFU8ACxpFKKcXDTt9S534mVbdA/s2Ni1o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > +...
> > +	d="$(git -C shallow-server rev-parse --verify D)" &&
> > +	git -C shallow-server checkout master &&
> > +
> > +...
> > +	! grep $d shallow-client/.git/shallow &&
> 
> We know D (and $d) is not a tag,


Actually, it is... the `test_commit D` creates that tag, and that is what
I use here.

> but perhaps the place that assigns to $d (way above) can do the
> rev-parse of D^0, not D, to make it more clear what is going on,
> especially given that...

... that the `grep` really wants to test for the absence of the *commit*,
not the *tag* in .git/shallow?

Yes, you are right ;-)

So why did my test do the right thing, if it looked at a tag, but did not
dereference it via ^0? The answer is: the `test_commit` function creates
light-weight tags, i.e. no tag objects. And therefore, the $d^0 you found
below, that's just confusing.

I will change it so that the `rev-parse` call uses ^0 (even if it is
technically not necessary), to avoid said confusion.

Thanks,
Dscho

> 
> > +	git -C shallow-server branch branch-orig D^0 &&
> 
> ... this does that D^0 thing here to makes us wonder if D needs
> unwrapping before using it as a commit (not commit-ish). 
> 
> If we did so, we could use $d here instead of D^0.
> 
> > +	git -C shallow-client fetch --prune --depth=2 \
> > +		origin "+refs/heads/*:refs/remotes/origin/*"
> > +'
> > +
> >  . "$TEST_DIRECTORY"/lib-httpd.sh
> >  start_httpd
> 
> 
