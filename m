Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8FC20248
	for <e@80x24.org>; Wed, 10 Apr 2019 22:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDJWdC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 18:33:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:48591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDJWdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 18:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554935574;
        bh=GekH2dzRORHpLM/ajmT33oVhSKCWDcllt/oYqf34KzQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YjK04z9ggzaAoTI3eXy1X3A1c8x9BHkCtG+3iPtDZaY4/PIze1tsIqx1ryZmt1AVr
         DlP9mTBtD50WsX+CPWILbBeHi5m2B4AL6vYdPyyk2m5VAA67WJJ1nO1Cm8JhRJl1yO
         OQWFXyl8Osq4muMbAcfCvSlhUaiSRG6mLr1/pBI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1gk7eS3F7O-013gBC; Thu, 11
 Apr 2019 00:32:54 +0200
Date:   Thu, 11 Apr 2019 00:32:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jh/trace2-sid-fix, was Re: What's cooking in git.git (Apr 2019, #02;
 Wed, 10)
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904110016030.41@tvgsbejvaqbjf.bet>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cjM9uXoVZZVuZKWF4MsDNveKj5wBa8HVDhqHqJvzNy7zH4PMxnG
 gm9HTwAerNvtJwVMpINw9G7rKqi6gJ1YEbVFq7fyhgHcZaLNJyGhCfbWSiPBELEVTAVneLT
 /t/ocpMaC/oZShkOxsIz/nG1UOMGVOdJUbcPsVilgTsdt174MIsdW3QIiR3CFUmJDPnE+ce
 yV8mrWlRVc7ltnIbAH8KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WuFANuADyrI=:Sra/m3dptnU3SrFWOGqlde
 NJnbuaWeQ8n1CElOGJpuOg82C6mEOFXXhqnwaHJzC/aY9XjiOymUGd6hiSdhNpt/pIcCqAeT9
 oDsLDnZOwhcv4lMmAoa7KX+u3GdYRwW+bk4ekoDqOJ987Y2kEWOv7E90PlaB7U6+tfEVDx8W+
 FuHdKQ7G88GDqD+N4pw3wKC5JXw9fcxHkhXD9XtrmW6DM+rdu0miFsOUYV6ivmSIrvE6qlSYM
 1lsb+ZpMBUuP+LFAOanvsYXeA3oPgHCclmWNKW7YIJ2jdCJQy7TpSdGjmiCYhD1RfAhjqx9bF
 /fYwiNXja0IFLrRYBhC50KScQZfD5ETNyk2Mut9P0reWeu9rmXrcvdfndgWIeSFHzMSUz52/t
 AsbT4hyLhyTgDzFQLf6R1Rqxc4age9aGc66EZxayf1HuRbZCVBw7CLeVLECK2Pg+F+YoDeO5r
 CiRRbOkthN1QnZptOmD8yf1BYUPsIRA8ANjAUYq32shUnDNwT2ql9ai3AG8deFQIRlDl7T5Zn
 8ybhmQtGNwaNtOi7zPd8CLCa6nHWujXa1aw62yuWb+eu13oMNM0rGLJYinVQWVbFeiGmRRZkM
 sAi9mMlaTqyO+g5hFAIkkAnrA6/DxzfzJZqRBO9yI9Xa6Z6BgaUDDpUO9gtoBfRRQZyUso0+S
 yy/O5IDCtlxPFpDmtNbbiBsZFmi1FOt/4dqqQaBFgEvj9LnBuTo2HFPIGHeWHpXZXG6rzH3fA
 z+f8U5rD4of7WAxO25RicJIRefUXUMzMiUJErf0simVAEB2+9dxX4YkFFRySQRDh2dLfQC58O
 gd4lrvkdB7p0dezId4u2992H+mlOxYI4VqrSHacSZOT1LxtFEhf68q5/wwS4crL8hKTvKuRmm
 eh6F2rFrU9ioUVr+/R6jy6s1N1e4Y8C5sPWpthxBv7CQRX7Onq7g+kJvkPCAGVjEJObNhoXXK
 ChiN5zyzuvQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Apr 2019, Junio C Hamano wrote:

> * jh/trace2-sid-fix (2019-04-01) 7 commits
>  - trace2: make SIDs more unique
>  - trace2: clarify UTC datetime formatting
>  - trace2: report peak memory usage of the process
>  - trace2: use system config for default trace2 settings
>  - trace2: find exec-dir before trace2 initialization
>  - trace2: add absolute elapsed time to start event
>  - trace2: refactor setting process starting time
>
>  Polishing of the new trace2 facility continues.  The system-level
>  configuration can specify site-wide trace2 settings (which would be
>  loved by big-brother types ;-).

While this is all fun and joy to perpetuate the stereotypes, I think that
more people would potentially be interested in using this in their
development teams, if only they knew what the actual purpose of trace2 is
(which this comment does not describe well).

As you probably use this description for the release notes, maybe it would
be a good idea to replace the Orwell reference by something like this:

	This allows trace2 to be enabled in a site-wide configuration. The
	intended audience for this feature are development teams which
	want to analyze and identify performance bottlenecks and other
	problems typical in their common workflows.

If you still need to be convinced that this kind of setting can help
tremendously with improving Git *itself* to become faster, watch the talk
by John Briggs at GitMerge 2019:
https://www.youtube.com/watch?v=3Dvat97a8C0o0

I cannot stress how crucial it is for our in-house use to have this kind
of detailed logging to steer our development efforts.

And obviously you are totally allowed to continue to make these jokes
about surveillance, at least as long as you admit that you know that
nobody wants to enable this outside their own development teams.

It would just be nice to see it ackowledged from time to time that these
analyses that we perform ("we" meaning the team in which I am embedded,
and other teams, e.g. within Google) have a direct benefit to the Git
project, as we no longer have to guess or surmise where our time is best
spent improving Git's performance, but we can focus our attention wisely
based on scientifically-sound statistics.

Ciao,
Dscho

>  Getting closer but still being discussed.
>  cf. <20190403000032.GA190454@google.com>
