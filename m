Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F35B208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 12:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbeHGOQI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 10:16:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:47181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeHGOQI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 10:16:08 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaV3V-1fSzvX3dNp-00K83A; Tue, 07
 Aug 2018 14:02:02 +0200
Date:   Tue, 7 Aug 2018 14:02:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] pull --rebase=<type>: allow single-letter abbreviations
 for the type
In-Reply-To: <xmqqh8k7nu4l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808071401540.71@tvgsbejvaqbjf.bet>
References: <pull.14.git.gitgitgadget@gmail.com> <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com> <xmqqh8k7nu4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TCvwp8KQ1fSd9XHl5XtDlhO+oD6faxs5lU3cXFiYN3KCuqhBY1x
 QXgmGV+k0S+TsuuRJT7neg+Adopd4itpJbcto0HckAoaTn3kzXPvhGNukUZT4WNJQtm4lSR
 E/NkkDdsFL36nM7Av5EihA0/Dia8djuW/QUF3eL9dto3LbuMSjfBtMjipRk7vcgI84FXZgO
 CNcUq3p56x9MzzYalyXdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PigtTqK7l6Y=:cteQ6aai9Hmmpg96aASQH5
 xa6npzk7juqwy+qEq0fPF+Ir3MWTqgPRLx3pW0FV5n1NAZfixhboqOYadSvigLrhc+UN8tmfZ
 x+gAzeEo8828XVcQNiTN4BpGkMEm+6JiPAzotuZFGqZJ6ZZBtOvdKLQVik1K2nhThDx2ptNxN
 yptcLQnnHNNeGHSIQyrJ8Vca8pHB1/cCirr653Kruy9rDrbesoDBQ0EbClVCsG5ONykh6B3ri
 8AhhvTpHV0e/dpoNtboUkjv+Y5gohikKkSDUDoKE22Pqvf8ZhZqnGlpdKgS+ZbNe404BAtzlr
 qwQIPRZe7zvKeNtaZwKe/1SRbkEkt1Spk+8rUhfz572oPE+OVungD6srtHsR++acCfG6N69VY
 0ydFBd72T+paQ98EE9ukqiyVO+CjS3xObdxSeHNhhqgWrKIwDg1qBpWFVZXB7R/yUxkKNXNwc
 lNIbpiJlaa2LjrPPp/AyZqyJWtg+qKKh8aDKUlEXbPa5laOm6qfxmvfee01mPB6724rTWKcQT
 UKY0jL8gwxKcMwmQq08E7DnjfEuACshihShTkixU+QE1miCw5nuhf+bt1FmREFKPgPmSJChIs
 +7NnZe9qm/u5hszIZBbSegDnqMtjiQAW1EBGuppUoR9ycf9B61tBz822aWQJvS2p02BDEDpcY
 8eBfkmxgAqr00z+WOuhyLTKIu1INt37vkUwmm6ZfOKNOZQ1SOTZob6hTw85pXT/FynOpVHn8m
 hoDLovEkPtxNP470lEIJw/2Puf5wz93extua9yiRO4Vfm3LMYKFpptNvhr/BxKbU4Du9LvCaH
 /jK95BC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Git for Windows' original 4aa8b8c8283 (Teach 'git pull' to handle
> > --rebase=interactive, 2011-10-21) had support for the very convenient
> > abbreviation
> >
> > 	git pull --rebase=i
> >
> > which was later lost when it was ported to the builtin `git pull`, and
> > it was not introduced before the patch eventually made it into Git as
> > f5eb87b98dd (pull: allow interactive rebase with --rebase=interactive,
> > 2016-01-13).
> >
> > However, it is *really* a useful short hand for the occasional rebasing
> > pull on branches that do not usually want to be rebased.
> >
> > So let's reintroduce this convenience, at long last.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Makes sense, whether this patch is adding back what in the past
> existed only in the Windows port but lost, and whether the lossage
> was long time ago or in just a few releases go, or it is adding a
> complete new feature for that matter.  This looks like a good
> short-hand.
> 
> Will queue.

Thanks!
Dscho
