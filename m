Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583CF1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 18:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdFHS6q (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 14:58:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:64523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbdFHS6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 14:58:45 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaZrd-1dYE6U2ZJp-00K5Mf; Thu, 08
 Jun 2017 20:58:11 +0200
Date:   Thu, 8 Jun 2017 20:58:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 03/31] config: don't implicitly use gitdir
In-Reply-To: <20170608163739.GM110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706082056560.171564@virtualbox>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-4-bmwill@google.com> <alpine.DEB.2.21.1.1706081235130.171564@virtualbox> <20170608163739.GM110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+y8eSoKGOuOPIVKBs+OMBsAP3+X3IQ0jq/pDu8BKfzjh8KXLHwO
 elhrSgBh8vpUsYTZQJzkUXzYa7z3ZmLhJD1GikS8OsZ520OxKikdrNw+K6locrjRdCRHCrG
 aOmUxhB47DnPrjvyam9geuf1V5riSDbZgx2XcxglbLHOkDjehh939u6luyYJqiTt5B1GGxS
 BhmzufVrweLBo6//YZcKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HsnwpNyzL7s=:IBlBvHUE8MRAC6H2aq/nkJ
 3zWkNf2xtc7oZ+iT6kvKLUwYEAScQoUCJRdEMAbEwMXaJZJl6Yk1iHYo13+kWrNspW31xMOnZ
 B1XUnrYGBfCxwHs3f0ViqZbggWh3BkV4pN4QcdmExvpk5tJny1q+pejZVJ0imve3hKPk6DC3+
 MWO2Wm910DJisMFAGZdpHaE2Eez+H/Y5n/SJMPu+zf2HI8fcKOHvQbn+TxCD9jsDVfJRdEYrR
 mrQJpZ+4xyZ1bL6sJSI8Ki81Ar7WmNDBs73bLY1La/j6w11KtlB7f5qC8+p3XMz/KG15MUNgl
 HOt5tYH4UQ+HT5DTet14FuGd36OAfvKcPil3s9nu8xoXEzn7qiAutoEQGJDFH5A5+tmT65B36
 CbG+M6S8q0Lx2xL/EpzSF+oJGEDUnK0ZLNHMmWvkO01EtdSyeL1VBmdUtEZZMn+MguRIgDvEf
 WfYN/0NZP/Ot7M7gZiZgb37ZXzLqcthnRYI1VJHbTFVAIvPDVGZxVr0C2Vlf6ffk9jdpJ/SOs
 Hrin/15BRLoHsax5tZ5qY/LNNQkkwTMSHkZLmoB4JTwQY/JjHXLa/bLyp8UJYX68b06DLIqtR
 q5dLW7Rgl8CVM+aZ1KhQS7z+uCU986SoG6P1yMG6vpfs9NxzAGwJ2NBm5jSCnAGYH7QMhQC1q
 l4zc2t6UM9HU9nMA7K52LqFM6p4aK5h8DmoJ85ETGjmxOBUWKtMdFR+2GdKdq385r8mv5pmNA
 XPAmFTMjmjN3CelGniJg4jTNuFwjQ5lPKwqGclB6Z7Dw5y5kTyz/geownxjPcJdpd+bN38k6U
 lwAA21Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Thu, 8 Jun 2017, Brandon Williams wrote:

> On 06/08, Johannes Schindelin wrote:
> > 
> > On Wed, 31 May 2017, Brandon Williams wrote:
> > 
> > > Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> > > not set up) added a 'git_dir' field to the config_options struct.  Let's
> > > use this option field explicitly all the time instead of occasionally
> > > falling back to calling 'git_pathdup("config")' to get the path to the
> > > local repository configuration.  This allows 'go_git_config_sequence()'
> > > to not implicitly rely on global repository state.
> > 
> > Oh wow. `git_pathdup()`...
> > 
> > Sadly, I lack the time to review the entire patch series, but this here
> > change definitely looks correct to me.
> 
> Thanks for taking a look.  I understand you don't have time to review
> the series in whole but I should also mention that patch 04/31 may be
> of interest to you as it deals with setup being slightly more robust and
> since you've spent a great deal of time in that bit of code any input
> would be nice.  Last prod I promise ;)

I had a quick look over the patch and I like the direction.

I also briefly scanned the discussion and have to admit that I am not
knee-deep in those exceptional code paths that do strange^Wuncommon
things, so I feel a bit unqualified to comment about those.

Ciao,
Dscho
