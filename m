Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7541FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 18:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdFHSw6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 14:52:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:57999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdFHSw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 14:52:57 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMEG-1d6xBb1vca-00EQUG; Thu, 08
 Jun 2017 20:52:31 +0200
Date:   Thu, 8 Jun 2017 20:52:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the worktree's
 top-level directory
In-Reply-To: <20170608163230.GK110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706082052040.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de> <20170607181333.GD110638@google.com> <alpine.DEB.2.21.1.1706081204330.171564@virtualbox> <20170608144628.GH110638@google.com>
 <alpine.DEB.2.21.1.1706081729450.171564@virtualbox> <20170608163230.GK110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Roz/tNIrbPz476U2srWccl9KrBWmtNVun3tTjrL7J8C++wyX2bp
 GmGxsTGvutJAQuFmQlA8OrRx//ocCNTxeypbrYYKI31bjCerJ7YBbnWfd54rywtV1zINnsT
 OXm0QHk+ZN2fTnzs0MW9wWsRXTrpQgSv7qfp5y7/rTYAn8ywDDLNhb2MzMWdFaZZKnnW458
 w7BOo7EGVSCBNwh3/um0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RkTjJeV4SgA=:1E/eX+bOEwpU70zW1ZK8cb
 U/ASF50y6frhPLn4w2H9kFbtT27BLCkFwkWxfpKTlDuTMvG6iFf2/x4ftj1XlLM8IYc1owDCg
 G+H0eIbpW41kCq047zxzG1TqXUyL2FO5B3zrtsbRRGSUDwb00iFOYM1NilsEBDZxz7HukcnEf
 uhwdSdGVV1PgPcynWWtpPhqmHHThguGwhgWaBjZZhwwq1O/V6VmeRJSF732uK/p7ZiW+VBGnr
 nI8UYL/gpNakudM1iez1lzGVzqgbmIEj2/2EeH3vXzy6H28LSzfbLCguOtgWE54zybD0papnj
 KUMzoz0TAANs4Rq9jxsC4kVomvSmm2FC5M/zjbxlONkVEFki41onvvOYKAY/CB43EneCih6TD
 /+SNSbXloEBUXiF2Z9oZL+n1QhChk2cOroVfANIZRdXyFSUrMvX3Ac7hBee9EIFe58eOY4pO5
 mc7UWFYTnSgY7czZcVd5e5hQtt8kUn3wOf87pWBFIbPwZWykFbYb01Pz72toFooW6Iyne03i+
 m1P55UJi1e7rGyDH/W/B1yr31PfFvg8PcFy1XfgonlJDSg26j/wMwx7dx0yON5zV8eefpdTtJ
 JDotl2tz/A785eV/7hiQAjX/pGxAw71ubeESKzv2ajRNtqG77si10c0EQlk6JUDQoQOPfxgTT
 F09Ub6lpy3lD3QPR5Fy6isF5ea+5Yvdwnv5b+MpnA4gCDOhvJYRmlE83/IYBd3QfHvQPu2U7l
 D9URo6JQcen2memWZw6Fu4npB5CHCJtNv9NHKAtT9gukwaYOA4DQNAd9M18hSfMxT+n3K73K4
 Rdn8BC8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Thu, 8 Jun 2017, Brandon Williams wrote:

> On 06/08, Johannes Schindelin wrote:
> > 
> > On Thu, 8 Jun 2017, Brandon Williams wrote:
> > 
> > > On 06/08, Johannes Schindelin wrote:
> > > 
> > > > Back to the worktree_dir variable.
> > > > 
> > > > I think part of the confusion here is that it may be left alone even
> > > > when there is a worktree. For example, if we are already in the
> > > > top-level directory. Or if the worktree somehow points to a different
> > > > directory than the one containing the .git/ directory.
> > > > 
> > > > Therefore, I renamed this variable to `cdup_dir` to reflect the fact
> > > > that it is only touched if Git determines that it is in a subdirectory
> > > > of the directory containing the .git/ directory.
> > > 
> > > Ok, maybe I'm just not following but just from reading the variable name
> > > I can't really understand what 'cdup_dir' means.
> > 
> > My idea would be that this is in line with the
> > 
> > 	git rev-parse --show-cdup
> > 
> > incantation.
> 
> Ah ok, 'cdup' just doesn't really mean much to me.  Is it supposed to
> stand for something?

Yes, it stands for "change directory up", as in `cd ../../`. ;-)

Ciao,
Dscho
