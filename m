Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FC8202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 12:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbdCHMHt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 07:07:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:61232 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751720AbdCHMHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 07:07:30 -0500
Received: from virtualbox ([37.201.194.15]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnfuZ-1c3ieC0LHj-00hu25; Wed, 08
 Mar 2017 12:59:07 +0100
Date:   Wed, 8 Mar 2017 12:59:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     valtron <valtron2000@gmail.com>, git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
In-Reply-To: <20170308020918.GA1650@google.com>
Message-ID: <alpine.DEB.2.20.1703081254480.3767@virtualbox>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com> <alpine.DEB.2.20.1703072345530.3767@virtualbox> <alpine.DEB.2.20.1703080104580.3767@virtualbox> <20170308020918.GA1650@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jr615Ilp6B7Ps5rw4VLdJC5hYLki+aikmfc/tohMb4YyHDSCPwj
 rWzBCfOzdl2nvo0wvSDNsRgaTE4b69YQWVVaPREy3p3rlPX89mnOcQtqjRp4x0sO//81Rzp
 t1ZtRFek1pNcGN4ug1xmE4zucpBQSKMNt8O7hAfZn29DzqIegSd3143JGhdYwHjNejh9IUL
 qcAbBA5lgFwChf88A7X2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PG2CExv5EJU=:tC5NWg762lke9PTYMPSbET
 8u/ua3IbW8RoXN9lG+c0Hf3aNUISt/5V6KEu3CQIJ8N8+B0FgedA2OPgWH+VW0LIaWs7+emd3
 s1niO8pA73fi3hOPA0nr77uJcBmVTwd5cnErReMonX91J+vzW43QgaAqUPVzRlxmLIT7gYYDJ
 mUmC+aQDawutWotgZhJ++O+3gzRwUsBkkc20WjJi8OKGlqwk93739j11zZHL/8RADd/VExqFJ
 epfW5yX/aCTh8p++4uEcbYENJcKl/JlQG+eAU9Vsp+zojCKg4GjvV8XPPJpZvJjP4GhtT1SkL
 xHRFpB/kwitzCyH6VRuJNTIsk+TpOVxn/ttObUAz3b0mumOfzNqggbxAdINkV0T1fsqFoLfAF
 BIXk6r/c7wRPEB6oPP7GoESwjkjxOtyHOGA9nz5UBsJTvEqFL1Sg5t/mXoHY+IM5YZBSLNQEj
 BdN8ytuxfYNp0q+O4VOog5byzf5Pg/uhftT9DfYcSNQ12ZNYVprc8MK3CJN7vLC+R7PKVbxdT
 eyY6fexzji/y1cqFg/+8SShrL2KIRQO4eagIR8mbi14DXYEzcpbHPRc+1qQV17a9KeYDBCDL/
 n+Labz5WMW9Xx90Lpped8dMLdKGvbcGLEIhZls3XLfiZ7L+hBb/wRFY4P3YclWuYt4EGIpnnk
 KOk8q0CAvHBVeNhvYT2ybFYcgdXsC9jyqltGP2DJm8oo+ADiTe5+2Hg/nw7bJjIkzM0S2/kS2
 MPzCwsHIY2hhoKF/7mxgDbOIt4cAQYqW/4C+bM8AJqAV2E8YKY8sipw5yYgKMkFhHRq9pmsXz
 BDpWpGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Tue, 7 Mar 2017, Brandon Williams wrote:

> On 03/08, Johannes Schindelin wrote:
> > 
> > [...] On *Linux*, this happens:
> > 
> > 	$ GIT_WORK_TREE=c:/invalid git rev-parse HEAD
> > 	Segmentation fault (core dumped)
> > 
> > The reason is this: when set_git_work_tree() was converted from using
> > xstrdup(real_path()) to real_pathdup(), we completely missed the fact
> > that the former passed die_on_error = 1 to strbuf_realpath(), while
> > the latter passed die_on_error = 0. As a consequence, work_tree can be
> > NULL now, and the current code does not expect set_git_work_tree() to
> > return successfully after setting work_tree to NULL.
> > 
> > I Cc:ed Brandon, the author of 4ac9006f832 (real_path: have callers
> > use real_pathdup and strbuf_realpath, 2016-12-12).
> > 
> > Brandon, I have a hunch that pretty much all of the
> > xstrdup(real_path()) -> real_pathdup() sites have a problem now. The
> > previous contract was that real_path() would die() if the passed path
> > is invalid. The new contract is that real_pathdup() returns NULL in
> > such a case. I believe that the following call sites are problematic
> > in particular:
> 
> Welp, looks like I missed that when I made the conversion.  You're
> right, the semantics of getting the real_path were changed which would
> cause a NULL to be returned instead of the program exiting with a call
> to die().  
> 
> After a cursory look at your patch, I think all of your changes look
> sane.  I would have to take a closer look at the call sites to see if
> each caller would need to die or not.  I'm assuming you took a quick
> glace to make your decision about each call site?

I did take a quick glance, but did you have a look at the time of day I
sent this patch? You do not want to trust my judgement after that.

Another thing: may I ask you to delete the quoted parts of the mail that
you are actually not responding to? Junio also often simply keeps the rest
of the mail quoted, and I always have to scroll all the way to the end
just to verify that nothing more has been said, which can be slightly
annoying when you are tired. I do plan to read your mails in the future,
so culling the quoted-yet-unanswered part would save me trouble.

Thanks,
Dscho
