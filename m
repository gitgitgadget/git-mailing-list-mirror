Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF751F424
	for <e@80x24.org>; Wed, 11 Apr 2018 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeDKLhP (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 07:37:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:46607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbeDKLhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 07:37:14 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbZb-1eXA9q1Isl-00aDD3; Wed, 11
 Apr 2018 13:37:05 +0200
Date:   Wed, 11 Apr 2018 13:36:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 04/15] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <878t9u5ksw.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1804111329270.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de> <878t9u5ksw.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fLV/Tep4zlF+URX18WqNIpGTXaiOpPP2FikHoYkKZ+OyZ/DQSUj
 C66f3ACqan1O98tvwv/80DZXv05CxoUHekdVd36ZRwBxwiSmnfueXebdYu9YdrqZkAvYyMM
 yxdJElKn72+QLP729Ki6/q8EsY4NQ7VCACAKWaMjmoSWBSVKYHY+ev56mMe+7/hemp6h++c
 xTf4CgdmgxaR6PwYqOadQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e6Lnpn0omEQ=:isjC4qclwrjg1kmrRFW/pG
 c/86MKEAb4cbow4mjFsxjd24Ga/uPIeh3shQ2VVyfcqTXei++gI3RBWRwCHvJ3CjsY4MiwX6s
 zCO/rKamyVo1gubGrhhgSR5jBLiqHQqYQ8dtq0KB1PRaThn63GOqB6dSaAN2ldUca3hP6frWa
 zRwq1Gr7KaCzzYl3wQys/qiLPvMaHyc2qydQNFvSjQe2n52roFgOpMK5UI7QMG1q+3S0B6aEG
 dgWpdJbb1rtUaOVYWjU9GlJisjx64olvEwxSDRzHXR0kXvfmVofeIJJXrHsTNVz7PymS0q3L1
 8+OVBzNkx6mtgF2tpc3CQOSTP7yI7G9C4FJ3KWbZbx7dll2he4Xh1lH2J7OpeBYX1gPUrKIQe
 OTUOPig+2lbhbYArbKqS468eWuMh2Q6Ufflf9RRW9s4RORYzfiQx3QrJiP2PFlxeoQrg7vuI4
 OOAfJrzOoHdbsI2+dglSblpRcIaYBdDJ90sxgGPoF6RJCgW1oDEK1CXHaHHZcysnMzAQ6Bcnk
 TmPwAFxDutrD9JQTFKQTN9PGGnYwW2w4CrNf1HiF8Nq1ZlgDMxA9718Rg8r8XizIHYK1D2tW5
 Z5bM4AJzOh4PndPYdbwu53DZacJeF1AB+3ZAi57fbB59uyZ7fKnPfvtadt7FCgw8G1WOamJoa
 bwUC9kbNdAwl/0T4bBgTPEcajBVrE81pFPf2UIzoVk84OY8uqVYFnF5x+s1Yh3gxC+ywUQilC
 NSCs3Ws9wfFh87HiNgzDymdVe5RAobMuRY47GRRTx2a4FIGA4nKQJFBuzMxJa7c5LPWIVJp2e
 bMmYoioRgF8dEeJL/vEz6qFMWTu4M16MQUXJuLfA2R6F+gpPjk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 11 Apr 2018, Sergey Organov wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> [...]
> 
> > We disallow '#' as label because that character will be used as
> > separator in the upcoming `merge` command.
> 
> Please consider to use # not only in `merge` and `reset`, but in the
> rest of the commands as well, to unify this new syntax. I.e., right now
> it seems to be:
> 
> pick  abcd A commit message
> merge beaf # B commit message
> 
> I suggest to turn it to:
> 
> pick  abcd # A commit message
> merge beaf # B commit message

First of all, that alignment of pick's and merge's first arguments? That
does not exist. If you want aligned arguments, you have to use the
rebase.abbreviateCommands feature.

Second: this change would break backwards-compatibility. For almost eleven
years, we generated `pick abcdef0123 A commit message`. Even if there are
no scripts that rely on this form, power users have gotten used to it, and
I can tell you from experience how unsettling even minor visual changes
are in everyday operations.

In short: no, we cannot do that. Just like your proposal to conflate the
`merge` and `pick` commands for some perception of consistency: The user
experience is more important than individual persons' sense of elegance
(that might not even be shared with the majority).

Ciao,
Johannes
