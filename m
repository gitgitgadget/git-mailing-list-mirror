Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B5F1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 13:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeHaRYn (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 13:24:43 -0400
Received: from mout.web.de ([212.227.17.12]:56949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeHaRYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 13:24:42 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYNzx-1gQGi80Wf3-00V5oU; Fri, 31
 Aug 2018 15:17:05 +0200
Date:   Fri, 31 Aug 2018 15:17:03 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Jonathan Nieder' <jrnieder@gmail.com>,
        'Robert Dailey' <rcdailey.lists@gmail.com>,
        'Git' <git@vger.kernel.org>
Subject: Re: Automatic core.autocrlf?
Message-ID: <20180831131703.GA20800@tor.lan>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180830045407.GB140348@aiede.svl.corp.google.com>
 <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com>
 <20180830185648.GA10427@tor.lan>
 <20180831032917.GC98946@aiede.svl.corp.google.com>
 <000c01d44121$bf563090$3e0291b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000c01d44121$bf563090$3e0291b0$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:WUiTNCIf+YKhjfRiUIr5q2mn726lK6Le1mhbNb56fWoxkxv63WS
 JXIQTgZVYtYQLBxAO9n8+x/IYIv/XH0gXFP4QRTsyIDKmo8tYR+9wpX0O8l1szV1qH9pG3Y
 g13Et3TzzDhwsFKw2mWx/1/ydV2Cz6NF+aOwe3hQvcikFVUH7uvh7F6Dib7fn+7HLXpJFjG
 +Gimmi1gP4FQOdVZAcajQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vKCRyCuYprM=:fr5skcmtT/KMSop4TLa7yV
 loSM3moDFBiwtCDXTfYG9DojrI0FUMlsN1ewP28AMxdTVUdc4gr8lwuRxbrpnDbpAULYqRw6x
 bjsFNLOEjmUyVTHQ+aFLjhglnkhSo90imggAL3nzWLMNGyvUt6allLejF/fpr51KyZ1rZHsGM
 AmPnq2wL3j7adNFAPRfwBVC2tOh3EaVubs9rVt5uCxkBtf4KbRiViF+8Og1+sloYgNck6kQCv
 eAUadEnSQqVicvAgBXq65soykx6N9m/Ofbsss+ob2ae3as7V/Qc9xQTDhtQhpCPkl/lrl5Lv6
 gv5Tuhm02Fy88IGdSW/YE+GOpS54B1vMv7/aRxrFNTsuIjGhICj3x+s9fs+Bscp5+MQVR/ANN
 cbgLm4xghF/qYZqvMcV+xo7kfyJIRxVdFulw3m37MS1ULvZexLFGvgBlEgORytUtS5htgGh0u
 pvRXQY9wGbqBqDTFQL3+E4itvhaJpbLP4qnRaDIE+68ZoCr1lkz7flrhDT9bRZLaRPTNJi9Dh
 ahRSVQ5d1tWLPv4+bwNuv/4jrKWf6Fvc35nLhn5jvmfsFnZ3dprNGm62/twVoSOunIJLFJAdP
 q0PE+r2DiVvprkJaZsqgzCNeiRNSJtLgM9FQcuGHT0MBcZBnUpsd8gXFRbnng6yhzIg7DN0NB
 N1qDiOO5gwiKClnQGXQPP2KVpDIZLoeeNz57AzluuhHg7bsur8VA8Wtw/tnuE/1OVK3FqClZL
 Z6xecKNidB8iXZ6CXKhVynjQz6jYyso02bDjONI1ycStzS/b4yKW6gyQxh4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 07:57:04AM -0400, Randall S. Becker wrote:
> 
> On August 30, 2018 11:29 PM, Jonathan Nieder wrote:
> > Torsten Bögershausen wrote:
> > 
> > > My original plan was to try to "make obsolete"/retire and phase out
> > > core.autocrlf completely.
> > > However, since e.g. egit/jgit uses it
> > > (they don't have support for .gitattributes at all) I am not sure if
> > > this is a good idea either.
> > 
> > Interesting.  [1] appears to have intended to add this feature.
> > Do you remember when it is that you tested?
> > 
> > Feel free to file bugs using [2] for any missing features.
> > 
> > [1] https://git.eclipse.org/r/c/60635
> > [2] https://www.eclipse.org/jgit/support/

Oh, (I thought that I digged into the source recently...)
Thanks for the clarification

> 
> My testing was done on EGit 5.0.1 yesterday, which does not provide a default to core.autocrlf.
> 
> Cheers,
> Randall
> 

OK, then I assume that jgit supports .gitattributes now.
Just to ask a possibly stupid question: did anybody test it ?

