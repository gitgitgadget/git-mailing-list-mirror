Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6971F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbeGJMIv (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:08:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:44005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbeGJMIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:08:50 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZEm-1gE84U0AxM-00ba1v; Tue, 10
 Jul 2018 14:08:46 +0200
Date:   Tue, 10 Jul 2018 14:08:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philipp Gortan <philipp@gortan.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: git-gui ignores core.hooksPath
In-Reply-To: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
Message-ID: <nycvar.QRO.7.76.6.1807101405570.75@tvgsbejvaqbjf.bet>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org> <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com> <alpine.DEB.2.21.1.1706141457500.171564@virtualbox> <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wtKpRVZtIqQhJUKmC23qXeCu8Cchwq9dCqimz8Llc5obh0jCB+c
 tvHl6rP7U4F1gBMvbFcnv/xTSJG6BbBfuTU7IByfngHavIBr27S4Mt+xHTe54HkVfw1/Xyy
 KHxBS+hz0MuRJrmM7Cn12lPb5gbBPQqz1gYyiQy8XKUDwANgH5yIA2QxXkubfL2UCxK/vKF
 M9K8KWM35AUGBsw9+Utzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mqcV4Km2uvA=:bBuTTXAb8xOO9l0b7zm7KR
 1VEoZLTKcNYpsgNK90nt1tU5cpwut/praDOA2RLkRE/kfbkzc4i4/6cFu12wse4Gg5Xa5WLyO
 AhJuDzX+eF8nH/SBchu2hlgFzeMK7B14S1NOIFQT1B8x20MiHYvMOJTDWyHpTZuMc9V8wS8La
 IJi2OzyxH9/3LDoPB/58xWQ2kF2nLfKYMMysj0Sy+xSCoZTF+nQjWraJMjwnJJkErHeebRaP+
 kLDRc7eGjOTa0+uSI0qEkymRmNr3JlzPo01BhLo4xEe2PSzLbRW4Mbn7C1s3DQRij85ea8cWO
 tRfJzC2HKqnb8gnI8RB1vFLoWkvKNIqxpYXngTJDzfCNA7VgEdSQCAcWWNNwEqvc0GmVsXtHg
 /799VpRPBwiTGFUjaM7/ZYbpiAbc+RvNDqJ0mHa+hw517QFImLaesMdvf8MrLtXqPPJtJiv1a
 rR3V9JRJ2vN0z4sVSxRnb9ZbEJe9ew+Zz9kAxYgXInZg4ccYoHuDo6vd2HzZHN+Hkz92FXgGg
 CFpsT5TmlUOhZNUK6cKYS2K346LMr3POwidVv9opsRmoVUPNZMq/iSGHpUGI+SFsEk6Yhsj64
 902jNA9+AIEflkMRIm3x4hcjoq2BTlW3qF72lLE+CUmF9N55lh6eotnjaLOc2MGVlZOp/RCRl
 FcSjfuI8LNMCGzw4AVWakOWQAGC5gmPAQ3uuy1saJpzMmFIc1vRQCyOevr8daN4dAQXK28je2
 8o+GBCIU23HsGaL1d0c/ILJ2XDsGZZsJ+tMEDBDQe0v90yGRHj/mb/L/w2WNOm9LVyiTipTrX
 iTUco5E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 14 Jun 2017, Philipp Gortan wrote:

> thanks for following up,
> 
> > Indeed. Why don't you give it a try?
> 
> Actually, I already did: https://github.com/patthoyts/git-gui/pull/12
> 
> You might want to post your analysis and patch there as well...

I wonder what good posting my analysis did, if nothing changed as a
consequence.

FWIW I opened this PR with Git for Windows to fix it properly:

	https://github.com/git-for-windows/git/pull/1757

I plan on consolidating all of the PRs at
https://github.com/patthoyts/git-gui, too, and to try to get them into
git.git. I guess that means that I just volunteered as interim maintainer
of the git-gui repository. However, I will really act as maintainer, not
as "cleaner upper".

Ciao,
Johannes
