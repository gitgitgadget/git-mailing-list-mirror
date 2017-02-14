Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201DB1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbdBNUzk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:55:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:58447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752667AbdBNUzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:55:38 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lugbo-1cDNWk273Q-00zpOR; Tue, 14
 Feb 2017 21:55:30 +0100
Date:   Tue, 14 Feb 2017 21:55:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
In-Reply-To: <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702142150220.3496@virtualbox>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox> <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vzB7dDr0C+ABaHznYGaiA4hHcTPcG57RCzB+HrSQKIYK/Q2t8n+
 t4bpOjdVkajxmfxC+Gl1GkDWRQm3f1O88X8G+Bzd94vpXSBySbA/8YQ/ft02DokYYGUWcZ7
 lQqD+XUQxk7JQsSsCygwL/iwpzs2r9THmqFdH1ZhiiPOrJz4AduCOItYLbizSzsw5ZlfRId
 vQ7WB6rWRkUB33oGpDslg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/2dM911TmWo=:oVYwx7Xesq2jZKDcrD6Aeq
 hNq1EY+BL+HeAHVkZ5/+AVcxj4YT7sp3Wv/PEmQYSUENnkk5+AF2kGqyjkVWLOFcW5KyA1pDD
 E795hdlL688DJeKb4tPJTIldGAQiuv+heZubp/bklXupWgeEnkpLYOQp7Zp2amjMGjKXgFBhT
 PYEFXvrp5FL8LXzJcOQMTqfhE5B8wpPMk8o9E2aFO5ock23w6WJ8PIgGmk/U8WRvXIYVMBqYJ
 7bML12PqAwh+TIPmCmCwsi+mb3SnIn8uZeaIRQyBIH6DAPT1HXnxpwdtHfCK6IDxDIUz6mUV/
 EOwVR31atTt5IAztkhFdQ7N1hETXlqVpUQPm0kYQAI+0M0nT7UCggC76DyPJ5Zx8f45xlMd/G
 v1ze0uaodczxwKBVpkWttx3In57IAGBohqHPMy1MofNwc2aEms0whg141CT/z4sozlY1s+/bF
 DeQy4DE5y46kmGIGUHWrDgY32y2Bb9NMsuT5IoauSYrIsRVDFQC2+olsCB+cSBvsRVyCIbIkb
 S4PtsE91ZQkVRjFdDJab7kl9Iekl9oOnTfHpuA/WfXoXHjB7mUEW7PR3jUCO/2MTpOgW4C1AY
 5GzboVGwC/jEr4Djpwlk/B/QoEpCvNMYTS3HXkclfJQuUFQV/ahQiGYN87TZmI2Sl58jPH1bh
 JTE9B6sQftG/yNL2JT3d13Rk4zcf4XMdxS7swpR2pfkjLASTO+JKcotOlJSUubXv9yucZB9zk
 zbsHVpzUWMqWQxRhVwXuRdezkgYOh8mzNX5DlB3aMDXfcbMaKeA+UNDLj03xr42mhvKp1dPdK
 ViYUCx3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 13 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That is why I taught the Git for Windows CI job that tests the four
> > upstream Git integration branches to *also* bisect test breakages and
> > then upload comments to the identified commit on GitHub
> 
> Good.  I do not think it is useful to try 'pu' as an aggregate and
> expect it to always build and work [*1*], but your "bisect and
> pinpoint" approach makes it useful to identify individual topic that
> brings in a breakage.

Sadly the many different merge bases[*1*] between `next` and `pu` (which
are the obvious good/bad points for bisecting automatically) bring my
build agents to its knees. I may have to disable the bisecting feature as
a consequence.

Ciao,
Johannes

Footnote *1*: There are currently 21, some of which stemming back from a
year ago. For bisecting, they all have to be tested individually, putting
a major dent into bisect's otherwise speedy process.
