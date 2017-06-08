Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE9A1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 15:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbdFHPbC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 11:31:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:55694 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752000AbdFHPbB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 11:31:01 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjqLx-1dpq6a3h85-00boUS; Thu, 08
 Jun 2017 17:30:49 +0200
Date:   Thu, 8 Jun 2017 17:30:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the worktree's
 top-level directory
In-Reply-To: <20170608144628.GH110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081729450.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de> <20170607181333.GD110638@google.com> <alpine.DEB.2.21.1.1706081204330.171564@virtualbox>
 <20170608144628.GH110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lhb83S4RtyeMS7NqpalUEd/YpyGU4j33jEKjOiO0g60RwB3RAqZ
 5rBLD38bN24urtdQSv2RJYejy9MiNE6Wuz/BixFkw5jlwCm19X22GoeYaq+Dil+Ba8Z3oB2
 XPC50bO4/4oHDZo9cyyY4bzqiajsSOO69gWhk/HXxlojjHWdOAi97HZwIma54zt06U08KS9
 EgQbgxqm1YTOEAUMaO/4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wvu7aQhC8NY=:bI3+qJBbczXsoh6SvoLNj3
 +dLBY6q9+n11PlDFl1OzYP5jxz4OHJaJxQY/Zfi9IjOlrjXhT71N4I6tZOzvg6yTHPDiGCdtK
 N+INMKYbJPr1yiUPV1a+t+ykPv8Rv8NzRovI6tHYdeUz0sZ6zhVv/QyNpglg8yof66EcFqnKr
 6B6eQJAM8DQOe//Vy+4WIgJGGeuL9uJcNCPiQWUqHDeLJQp8cx0ors0SL7JNuw+eFlY7fy9/J
 VfyhBCwD5FhhhIFZ3eOF8cpOWjr8xPNlrM/zduYhm0B/xblgnZPMPe2OSKI58t6gWXD1ECf4I
 AdBBpJ8S/SNl/b5s5kyb4n09BQBkQ5DhkILUGt/PpRsTaEVefSYfys1vkaqN3orEgHnRYpsn5
 c3x7dj5szQcIqwST/NvBmMxSPaQIdEDrDJBCr24dGvkoKcL4llkyQ0S9CZCJUnOhvD9bdswpr
 rQdFedBnVMSV8WCmpcwsYs9+XqojzmBg/858nLoPfSeQrBHJuMFvZCfMB8oNfQn/9wK4TfQGU
 9KmnXBpN9TjROV5jv4/9Iccmks2EjriyaIH4A6FZd18BoWraVxOcSXIpQbW4apTcrqi7AcsIE
 MQU8U5F90yfSB8acpy72/wjI3FJz/ISiFIzeGTUDHB9226SX0OYBMx+ltOrPeN6hSqAdSoiyN
 ZihIwYssXrufaUE7ui4fMJIuGFe+75lyc5GcovuJRu8dTpjIdUXN1HCtQhoRI2S59106hsUyT
 9nJxT5EZ00tDFXpSPWp7lFySXPk40kISO0dsNHeBMS7YjfR7ujaCwU5eppOGmjVE0RNMR6dc3
 P8YKUo6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Thu, 8 Jun 2017, Brandon Williams wrote:

> On 06/08, Johannes Schindelin wrote:
> 
> > Back to the worktree_dir variable.
> > 
> > I think part of the confusion here is that it may be left alone even
> > when there is a worktree. For example, if we are already in the
> > top-level directory. Or if the worktree somehow points to a different
> > directory than the one containing the .git/ directory.
> > 
> > Therefore, I renamed this variable to `cdup_dir` to reflect the fact
> > that it is only touched if Git determines that it is in a subdirectory
> > of the directory containing the .git/ directory.
> 
> Ok, maybe I'm just not following but just from reading the variable name
> I can't really understand what 'cdup_dir' means.

My idea would be that this is in line with the

	git rev-parse --show-cdup

incantation.

Ciao,
Dscho
