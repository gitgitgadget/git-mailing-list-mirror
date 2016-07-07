Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2061F744
	for <e@80x24.org>; Thu,  7 Jul 2016 11:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbcGGLay (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 07:30:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:51545 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbcGGLax (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 07:30:53 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LxLcc-1bMv131GFW-016tY1; Thu, 07 Jul 2016 13:30:39
 +0200
Date:	Thu, 7 Jul 2016 13:30:36 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/17] am: counteract gender bias
In-Reply-To: <xmqq1t36sbqt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607071323440.6426@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de> <ea23faf258b6e62e770879362869f49eea4db869.1467717730.git.johannes.schindelin@gmx.de> <xmqq1t36sbqt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fljq6FZhcSy0TYqpFDmQNyo/NUsFnxuArvHjQn7036WGZ71mzsC
 Gkv1vjA81VBwQg5CiN9OJjOeGexFE0V1PyLBYNnAMDsztQ4efZWUnbi5o5xjSTehhRIHjQ8
 W+oT2J7gheOi15Zw0E6DFiNE3CRxfwajxIjtmsHsI9qRM3UddxpvHYtbJ2xqkhB6paLekdJ
 zsImnbPkWh154J0Pu1IDw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:R1KgkDUFjtw=:J9fIXdivJ2ROLNnQUet8fi
 rEYSehEdWKhnVLa5aNonKOyXL/8HaoCEU2hDKw06UY5dj/Kt2Gjl3bxsD1kT3JX/vEiyiHA4+
 rHKgo0s1d9XxPC6osPunzDkPPK9RHKfPPF1O08EBmaSXJFMuqsYTGbwSKxrobVzBAd0qcYzG/
 I8pgVK9lzt3Fi6ekiWWT4aj/gGVfykJFUwBC2bWobpCvSlnN54ZUACHrQBdfm2rtNEKpMGDrX
 b47YSOYYIYe39Fxgphg3ShIpiO04v2xV4gT6UO8FEjvMdJgJbyoRbvDpcL4x928yEegq23lsz
 gCK4gjEU0RMcJdJNyOMRvgxHzNsTCRSlbsQUAuLX45aPphyoa/ezJp5iwwe2lt1QFTl0P/xfl
 iH9UuixQPAYWSgBqXDajKP0AVL02OMMDUIDpO1zgFgQByOHxzqKE6D7nadkIa23ZUbtTVKJGW
 eqldFuK2s8UzSPVP92Wht5hGiV3p0kH2FanTds7SQC8JS+ZfsKxnXIyzbAOlQPrW+dA/VSKMS
 yR1ZzGqnXVDPiA32u1dVFCq/PpA+F2HGaPDfR7t00buXItyg9eyy/osEkRQWtJ7a4WYLyn4iu
 WSaNm8k8RdlwNMP8eU39+0VojlnTHv879QZsHYyn70p91npgMxeFfEWvA7NYaaWAr7VQ8/Qg+
 2s7TKcVKFOvE1naYYLvYHp+XedfhIBpsX2va8/O0STe6PqeGOKosuvTkFhJ45XFAU7zE/qMQS
 kQKZr2JZciGU34nnJDjm7ufjeKi1KqidK02QbTWs1x3D9TZDHoKtffZ4E/2UhwNxnPprXGK2F
 O3/IP5x
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
> > almost 11 years already,...
> > ...Let's start changing that by using the variable name "her_tree" for an
> > equal number of years out of fairness, and change to the gender neutral
> > "their_tree" after that.
> 
> I doubt this kind fo distraction is desirable in the middle of a
> seriously heavy series like this one.  As a standalone clean-up to
> turn these directly to "their" that everybody would agree on and can
> be merged down quickly to 'master' that does not have to keep the
> body of the main topic waiting for the dust to settle might be a
> better approach.
> 
> Unless you are trying to discourage the reviewers, that is ;-).

Funny. In other comments, I am asked to patch things that are truly
unrelated to the patch series' intent, and here I am asked to refrain from
cleaning up the code before I touch it.

I am really curious, though. Has it not been our practice to encourage
preparatory patches like white-space or const fixes as part of patch
series that touch a certain part of the code that needed fixing? I deem
this here patch to be much, much more important than a mere white-space or
const fix.

Since you asked so nicely, I will break out this patch from the patch
series, of course, but please note that it will now look as if I willfully
snuck in an unrelated change in the next patch, just because I was not
allowed to prepare the code properly.

Ciao,
Dscho
