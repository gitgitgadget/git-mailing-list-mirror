Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FB91FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 15:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbdA3Pfi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 10:35:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:54829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932465AbdA3Pf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 10:35:29 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbsV8-1co6RQ3hJO-00JL9r; Mon, 30
 Jan 2017 16:35:07 +0100
Date:   Mon, 30 Jan 2017 16:35:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <xmqq4m0kz65d.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701301627260.3469@virtualbox>
References: <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de> <0563f07117e828c072ba542c1a57441e2e8efb81.1485537593.git.johannes.schindelin@gmx.de> <xmqq4m0kz65d.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+nuVtHEVyNmx+ANt7W8wRj8MlhzjIkF5JHm8FPt3ccwocKM+qUU
 Riyn5IT2SbDQZoVgqUzm7gd1R5uUMON/laDcxCL/CARjRnb1ySulEkSehDhIeFM2k0Tpf1o
 jJBocxCwUHXjt/EPlXH1NbBKD8eLDymnqBPHerFpDgXOOVMimcaJyyEf0v9vBdKqw6G98BI
 ZD9vBrsghbRckvsAnIpBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y3Hl5fNM8lk=:eJX9L92lTKeR3wb0uvRQ7v
 WfcCwbJu9L7U38vseNudEpf/DN/YI90vjEKjs10Mp1xQFyCuZsWZVnrYj7sd7VDZZA5SdNMVS
 6GtAqa1ZdTfnPAVQNtgAlzii/2pg6oz+QwlgT7CGlyk3aZ94T9qB7+bGlVVVrRbXS8PWFA/+u
 ZyPK/DYApAD2II2TfcUpLpeBKOvC0vpfcRfJw27zUFd0oBj/B3IYm3N8C80BPRJIFjs6FP8II
 xSjhi9xCy2Gh3pMFbgaaU2nGuoll/h02VB8cyfSZ4kxyAUfe9z+N22+3hQXE5R+Etpl5jzSYx
 T62peSiZYcUCy+YMtqKuwkjMITBG5ZFjGNsnK/Cy9S9eh3DB2wFUuxPaXmq+EPwswIAZdk5wf
 dLIRZkps2ac26c1uycicF2AbHiRxWb8hnF7DAicDwFyflK65Te9OyaEuImatxMK6dQiQCMJ76
 jC7QupGxGSa5qZk9ZEOUBa+mQztK9LWphVLmRmodIeK6t3cm/0vY/aLYo9B0LIMOBJN1MVW8O
 q6hHsC3B/ZDhmZVcZkFDIEX5vWEwm1h9072gS6IAsCFKBkmWrDeAMgS7uOnmv1Hoi8T30USrl
 T0u0Zru5ynDzVNA2U+gY0xTi95r2HIOSRL4Jr+Pm0hx3uO+lhEYHectwo3Qim/e3fe3xe5Mcv
 RWalCNSvE+Obvq4ZqZBukOqMpW2JLCkGKBjXnZTtYam6ZMMdiQnjrx3/P0k+pGAbImSzIV6L0
 XVFTUG3nXxufy5ZkYgPHrZiR7b/lQvTT2kzD8wtM5xwj5IH1LWebnljAtGRoHAPgzEBQz50v0
 C+6xeatbIl3ENcaBi1wY0y8UHL4epwn7l9rZz48KIiaPWrUZOskVQHvm8/J5z8AANQzrh+2fk
 NKEM3Wwq717Dm3OiBw+JYcyUzUQAtL287iTD8CQyxGWQizPSfPUsAiQHNWXHZSKZHE5B0sZXc
 +wBni8hHC2BcNctDbLCGhVAO5c/f2gt5SAaBwnXTcJtIzXYrD4EV60/i+oAISumimye96lK0e
 LAJ/wrnZvd6TqqjfJfI5oe/CBWlsI+Z1jCQjK2UrEQg1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 27 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This patch automates the process of determining which tests failed
> > previously and re-running them.
> > ...
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I stored both versions in files and compared them, and it seems the
> single word change in the proposed commit log message is the only
> difference.  I would have written "Automate the process...", though.

Yes, we have different styles. Thanks for letting my commit keep my commit
message this time ;-)

> If you are resending, touching up to cover all points raised by a
> reviewer and doing nothing else, having "Reviewed-by: Jeff King
> <peff@peff.net>" would have been nicer.

TBH I am not at all sure that I know when to add those footers and when
not. After having been asked to remove such a footer, I decided to *not*
include them by default.

Having gray zones about the footers strikes me as similar to having gray
zones in the coding style guidelines: it sure gives the contributors more
freedom, but it also creates uncertainty and as a consequence takes up a
lot of reviewing space and time (hence taking away space and time from
reviewing the code for bugs).

In other words: while I appreciate the idea of giving contributors such as
myself a lot of leeway, I would love even more to be able to automate away
tedious and boring tasks (such as adding Tested-by: or Reviewed-by:
footers, or for that matter, addressing code style issues before any
reviewer has to shed bikes so that they can focus on the parts of the
review that no machine can do for them).

Ciao,
Johannes
