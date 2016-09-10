Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D511C1F856
	for <e@80x24.org>; Sat, 10 Sep 2016 07:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbcIJHFx (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 03:05:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:58585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbcIJHFx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 03:05:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LiDHj-1bCoA91gKx-00nUN1; Sat, 10 Sep 2016 09:05:34
 +0200
Date:   Sat, 10 Sep 2016 09:05:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: respect commit.gpgsign again
In-Reply-To: <xmqqr38tapv0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609100903010.129229@virtualbox>
References: <550e7de5e08e53b5893e1ce021bffee468adfc9d.1473424091.git.johannes.schindelin@gmx.de> <xmqqr38tapv0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GxKFukifYN711osA2Sa44+2Ex5nLGDi2kugx4d72BayyDm56B1T
 4BkXD5jYY25ftBthZTgxBtTT7QjsvHuhbtJb3HXAl7nGcZwoI7Z59onU/YG936y6FczMB7r
 SOh9IjyUr93ybejesUOr4tdEDYF+o3NwHntfxZsGlY9qVUSnnam1Q5U6+mOu0g2XvD3Q3XR
 YBc+1ZO2dQ3YNp9Skqdpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QkeSCA1iygE=:fmU/NTDJcXOex0Lt0ZE6tv
 jeNgxfP3KeXdYlAYWwCW4lXUnNWx3TGnOG0X8lSgRCustsBu4PcWEjoQDg2MFGBuXJpyyXvLc
 W5BgTWLq6IWs9SSBlygCNHlula7j6Vc6aTBa1+t7BOZbYbcY691xBzjWWKBKA5t2LqjnmfOah
 9sLaSOTALrsxmauKIfq4cGACJGl4+p0YvveR8ewlPNwVh/tLTJQt2NWOHgIu4a5zyrdOHo0Rc
 Fy0vJzrF4Dwa6ITYCVRwtieQQgdQSW+MpE7RscQwPbTXmGpYO7zNB0nLg2dgdyLrqB4dZBZIh
 Ck29P4OyMTwqw9u0LoEbdDpke+ZLq/lp4MfQSCGdsImmaWqfLRULxr0kctKEnTFYyBUdC3QET
 jXGft0PCdVHDW2A957mQ5WhbtGrHm0/j342+6gMB2bmqOxQdeNo842A276OxzK9jS++CuZQ41
 Y0EGzJLiIcGZqxX/V/IGGvmePwGnvnunAcc0nVBmknp7Y2dLQWDD6brOGA2tzSOPl36nwq/67
 4jyLtt1I/0WwP6yJ7Ij/+uNrl72AmOqmRk+lCJs1eHic7ktotYJD/VAUFVfEWusgEUa6CUDaT
 lk65/4PvQHaotR77fPDWCFrBVRCYcvR4CagNxpYQ30D73EUK9SOOHSPq+rMjhzTPdfg4Ww0iV
 zNCdaQdJCVtKPvpXSEt+ulF1tClEzChcc7jgkkvoTDeUJR7bWJ0Y5HOxlwJDR8a4K1sJZFEQb
 gepnPKTwj2YYejbqj8Nux9ZRUL+TI4SKGhLeXgno9Tr/a7P+L5eyxDYTS37BmtcChAue9C02w
 GYLeAZ3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 9 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > As of v2.9.0, `git commit-tree` no longer heeds the `commit.gpgsign`
> > config setting. This broke committing in Git GUI.
> 
> Thanks.  Will shift it up to apply to my copy of git-gui project and
> then pull in the result.

Thanks. There are a couple more git-gui patches waiting for quite a long
time. So you prefer them still as patches to git-gui.git?

Also, I just noticed poor wording. Would you mind fixing it up by

	s/committing/& with GPG signature/

?

Thanks,
Dscho
