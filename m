Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69A81FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762465AbdEWJBa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:01:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:52259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762441AbdEWJB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:01:26 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHso5-1dG71O1tsb-003aQI; Tue, 23
 May 2017 11:01:03 +0200
Date:   Tue, 23 May 2017 11:01:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v3 1/6] Fix build with core.autocrlf=true
In-Reply-To: <xmqqh90cmei6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705231057510.3610@virtualbox>
References: <cover.1493891336.git.johannes.schindelin@gmx.de> <cover.1494334366.git.johannes.schindelin@gmx.de> <6bc890b10de8a59f90005462f8767d6b022b0749.1494334366.git.johannes.schindelin@gmx.de> <20170522175709.GC17710@aiede.svl.corp.google.com>
 <xmqqh90cmei6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Hiq18EKeTHcknRm1viQYovod1fY0oyBFW/PGmXqyJEP7RIAk3ML
 wB2pJu2nKSE4eHCQlhRQoUrcS72cwh9H3iSIfBHwizjwQG5y8GuwOr5RMvzWAHcCETdJTh1
 S0WgOB4DF+h0WkQQWphqFbTuAVEuRoPi84ThIeUM13drJBf0kYQcDQ9/TZvQ9UYYosNi8d8
 Vr7m9dPZYHF8SslG4wUxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7gfhCJ8NsTs=:UYHJEezy9FVnxNrIb0rb2M
 C6AZARUo39fv4Ec/2eySfjF1nqbjpcs/IDwUjDXXlEgAqsEHaoKVyD/o+b6TaeKlOiNLdlcbc
 vbPMXiTTrN95Y+3/3PKQx5dRzJ7E31aGh90Wc4dXb7dTSEhex8/H6NwemRjqW725Ec7eZLDMM
 e/aaPpdDitWDcZuM6nZh0tk0cE5tv7rU8gzKCMVhifepEmorw61MAe5w+HoExsbDu9f1wrGNl
 3Cvj4eEJZvQ+tVRN+jkbf+s4rwaFsnqaDUyqMJiXqaSgEA3hlpg4y0zY5m4gnasHG+zj5Dbng
 gjK6PA/OGMFPOeoIJQpj39dlLNvdtVpiToXU3gmAfMx1hI7/0CAQ4skO96FqStoADOvZnj8X0
 WYjCBZY5DNMu6vb6vGcy+/w93YpaaibKmLCL0XOx3gRUjg13et3DsJipS8lUzUAhjo22cYLTi
 wkW35hNpRr7YKRcHp5FiEuAyysbwtfxshNJyAiBwY7JCvYjigGhhOQpqY2EGkmvV+78bGyb/A
 ur6QZl9a0T5aLWhCk9Zuw6LIpyVRM00wUeTWwzORQsyIfJE7c9o93io2yoByCJCfvWSMpkdGp
 q+sJYGtfB6TEKLpD59vF6tOeB/qGLo1clqL5xiETSUzB3r+hZjXswm9+WETjrXLTCB0V9ZG5q
 1mmax3z50w7jGKDIr+S3EXySKQCds1OzqF/3zYcRKK1XGJHPltZ6l2dZtptExRf0XJr9P2tVK
 87S55N6YWY5drm6wKxFDexJ4Ox8ytdrrlAVc47FlvpanKcQgCMcOEMxAH7f8YcqGI9vahp2Vt
 L9jchAU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 23 May 2017, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Junio, how do you prefer to handle this in git.git?  Would you need to
> > amend the patch to remove the git-gui/.gitattributes change and wait
> > to get it from Pat, or is getting the same change twice okay?
> 
> Yes, getting the same change twice should be fine.  I'll see
> conflicts when I update from Pat when it happens next time, but we
> know what the resolution should be already.

FWIW the reason why I did not open a Pull Request in
https://github.com/patthoyts/git-gui for this change (which I had
originally considered) is that I already have a couple of Pull Requests
open in that repository, and they are rotting for over half a year
already (and will soon compete with certain Icelandic delicacies):

https://github.com/patthoyts/git-gui/pulls/dscho

Ciao,
Dscho
