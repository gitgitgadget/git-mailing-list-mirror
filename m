Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF3720899
	for <e@80x24.org>; Wed, 23 Aug 2017 14:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbdHWOkU (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 10:40:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:49475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753985AbdHWOkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 10:40:19 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4Wwq-1dL9kT2QdI-00ygGr; Wed, 23
 Aug 2017 16:40:17 +0200
Date:   Wed, 23 Aug 2017 16:40:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephan Beyer <s-beyer@gmx.net>
cc:     Git <git@vger.kernel.org>
Subject: Re: [BUG] rebase -i with only empty commits
In-Reply-To: <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
Message-ID: <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com> <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aYnGPVDH/NWTgJOrf/u3E2HCf97+MtraAUKDrhJZ5AGkNqEZXBv
 4RDBGowheZMM0FR69AMizG7CQaizYVwUKc5Ex89hqIfP/Nk77pdPAGYbUTc+FlBOELX7Hvx
 a42d17XShuqW1sneWGXgw1tfJzOtY/iQhKJzMULxfcqrpM53lHVf6ojp8lhG4yiSlu6AmCP
 mtPW335sbrSQeaUyzC4IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GY7aaXAD26c=:Db6KL9Eo1R/QGb7IHeoWoi
 PymCMLq8nS8UfYGfo0pPnQEYB+Fa6YKdnrT7a7moWOFh1iI+V6esBkVyBMyZ4sJIghnL6a+ED
 4DRiRi5lZrpd3eq0JZUXAF09FOgj329+T4/zGaYQCRPixwwuo3SKflW5fGTsbwOvLcScXl+XN
 NZoQtCa1PngqjzYyYfTXyi9EGwoKImGt2Du6m7NdIGt/zmK538rhx/n+eIyibfqzTlVNS3BHc
 xijCIWGZZWk935BA3+Hed7283UCRTC/MPf3CaSAfWrYg5YNboxIFqu19lqxlAULHPRJFNO5UK
 /g/1ceJ9i7gmCPJ+szlPlvzaP6PS4TblgZQwYVT9oYGs/7taYUp0c/98zkki/pLPJurSsCK+6
 8WvNPxB5HBVBjPGSJ48tW/xdamLGcYdigj3IJTA8gytIXTdWP9tKamZxb7FMKMs1O56LTxAID
 JQi+fUO2Xh3f6wLEXYwBF/hzkfp6gT698YnlmAgUbF6i33DmA6UGtEmkElRVF7Z2BMtEEBz35
 /IiKCooLyo7zV7NAxN34pYQ3sCtAd+FGMvtXbXW2tdtvk3nSvLRJ3krnEUpHLkfWKyfk9zHHR
 sD4MOarHD6Q0V1kOF2Xd9sReX4LNSDSAOu3eBD02h022fjVGUrqbqxi88R+Ynr/7P3R/plv4j
 WRHwR7n8iW2Iyesvy5syyYNGq1HKu46d0AhCp1F7an3Amh0cQRMGg+PXP2/kxl2lO0sJIhqDf
 s+o7YDE4OEnfr8d+kyNYDu9Jg9A6hkNi+mUf/MRBzKfGiToAzgWSIbcV8YzAp7iRKbhI5vjHw
 es7TiLIDFpBUmezFrua1jk9s/NhvaDDdpH/BzmzW/EZbCy2Gd0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 23 Aug 2017, Stephan Beyer wrote:

> On 08/23/2017 01:08 AM, Stefan Beller wrote:
> > The editor opened proposing the following instruction sheet,
> > which in my opinion is buggy:
> > 
> >     pick 1234 some commit
> >     exec make
> >     pick 2345 another commit
> >     exec make
> >     pick 3456 third commit
> >     # pick 4567 empty commit
> >     exec make
> >     pick 5678  yet another commit
> >     exec make
> 
> This reminds me of another bug I stumbled over recently regarding empty
> commits.
> 
> Do this:
> 	# repo preparation:
> 	git init
> 	:> file1
> 	git add file1
> 	git commit -m "add file1"
> 	:> file2
> 	git add file2
> 	git commit -m "add file2"
> 
> 	# the bug:
> 	git checkout -b to-be-rebased master^
> 	git commit --allow-empty -m "empty commit"
> 	git rebase -i master
> 
> It says "Nothing to do".
> Unsurprisingly, the problem persists when you apply other empty commits:
> 
> 	git commit --allow-empty -m "another empty commit"
> 	git rebase -i master
> 
> Adding a "real" commit solves the problem:
> 
> 	:>file3
> 	git add file3
> 	git commit -m "add file3"
> 
> Adding further empty commits is no problem:
> 
> 	git commit --allow-empty -m "yet another empty commit"
> 
> So the problem seems to be that rebase -i (like rebase without -i)
> considers "empty commits" as commits to be ignored. However, when using
> rebase -i one expects that you can include the empty commit...
> 
> Also, the behavior is odd. When I only have empty commits, a "git rebase
> master" works as expected like a "git reset --hard master" but "git
> rebase -i" does nothing.
> 
> The expected behavior would be that the editor shows up with a
> git-rebase-todo like:
> 	# pick 3d0f6c49 empty commit
> 	# pick bbbc5941 another empty commit
> 	noop

These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
you want to do that, too?

Ciao,
Dscho
