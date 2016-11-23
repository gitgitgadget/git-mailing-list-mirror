Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059861FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 19:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934007AbcKWT4l (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 14:56:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:56479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932754AbcKWT4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 14:56:40 -0500
Received: from virtualbox ([89.204.155.1]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5GD-1cbndu0dbN-00kfeT; Wed, 23
 Nov 2016 20:55:27 +0100
Date:   Wed, 23 Nov 2016 20:55:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs
 scripted version
In-Reply-To: <xmqqd1hmm54f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611232051420.3746@virtualbox>
References: <cover.1479834051.git.johannes.schindelin@gmx.de> <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de> <1479912693.5181.27.camel@kaarsemaker.net> <alpine.DEB.2.20.1611231824530.3746@virtualbox>
 <xmqqh96ym6x6.fsf@gitster.mtv.corp.google.com> <xmqqd1hmm54f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6O605zHrwUS5OIxAbDMcKrgNUXkLNQC4FHClWICLHu4aTYLsvkg
 culvXlzuU/HLFGjmzmzNC22PP2/Bqkl44VmpKI8+3aG4hce9EZ5Yadn9ANI29318JFqEV3X
 WmtRsAinR9bZ+sS74dXGn+Pa1Tnt4cLKotXk5/Q4nhczUcuvhqF8ZGaoSEA5l4qzZsARBX8
 DiN/vpY8v9BSvvB9PzglQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+Kg1LXJwi48=:uwF+troKv7RKSManMk/KRD
 cK8tn06vkRoNJEDW6pcRyfmWgrzRT5QH6fo7bQ16BbgXzMKSGyPQ3iym4vQjpWFV25KBe7pbQ
 TJMeHrqfPkpGPxzJI9q8G6s0U/ZB3UGhJSUXU3jsHwcy6voCjZLIXbXMhloaCq2cndx4rydZh
 jlmyZCvo5PF8+W4E/Qq08I1y3QQRAmTOctWeMZMnVgdK6evA5rW6R+ZohimDkqwHLTOSLSXPl
 FgvTZ1P7uFDAfeKPA5oe/BwzbrvzRRDQLk5YTK7LlZzEtZ39a1M/TqCmGZQJOzqb3GW8avT1/
 dXDMlq2KLYBKGJgReYAIRNLC4fAqRd5Ewu0tq/CRg+AM5Nkjk3LCdh4oljp+iNI/E6rEBGG1o
 0Z7IZCzRpvcy6CcnFVIUUD3090nCzscnhymrqJKJReXOVAZHQqwKe0gIeifDDycd8Rst+K8n9
 8MjCJvvgrIdEbz/1Ne7JS5hzK5QgnWyML6KUgOjyTtfvaISh2XeRHbHh8CFHkKUT1Wr7a9mP1
 phtnCmPx+3HlQfN2Nu9vr+dwBe0L9uKtehjL4xKw5A0LzfoVI8x2pbeAhLdDjTWS4smYsAIUd
 loZt3OxxlrOjvMh6fKPcnzk2VUqnCio9P3K9hBRYjCvHzIWMS3BZ1Vgz8c7Fdqrw0OKq948q1
 FOgzUNVrtD3tJvWVxfO0xaXzrZNbx5fvAZTcTzOg+CcKpxKJxRDsZanQfAM5UFbyJ1tDi2X/M
 zHgYCDAWqW13x6lOK/b1BNMZxAkZ+xsU1qXEYbM0Ca+23ZrHCKK6jtW7/pqBP6uNMvMe3c5nq
 /CrtWXR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Nov 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Can't you route the control upon seeing "git difftool" to your
> > experimental "C" difftool and check the configuration there?  Then
> > you can decide to run_command() a non-builtin one depending what the
> > configuration says---that way, you would incur cost of spawning Perl
> > only when you need it, no?
> 
> FWIW, the approach taken by 73c2779f42 ("builtin-am: implement
> skeletal builtin am", 2015-08-04) is what I had in mind when I wrote
> the above.

Maybe that worked back then. But I doubt it, because checking out that
revision, I get this "warning":

Makefile:1732: warning: overriding recipe for target 'git-am'
Makefile:1696: warning: ignoring old recipe for target 'git-am'

Seems like a matter of luck whether the `make` executable you happen to
use guesses what we want: to munge git-am.sh into git-am, as opposed to
hard-linking git to git-am.

Ciao,
Dscho
