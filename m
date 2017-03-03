Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD5720133
	for <e@80x24.org>; Fri,  3 Mar 2017 12:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdCCMHt (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 07:07:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:56593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbdCCMHs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 07:07:48 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M70Td-1cOfMc2nCv-00wmrw; Fri, 03
 Mar 2017 12:11:07 +0100
Date:   Fri, 3 Mar 2017 12:10:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/9] t7006: replace dubious test
In-Reply-To: <20170303033623.lfi7jhul6psbdde6@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031208430.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <8f79df34e63a37c052437dd022269b4a6c495108.1488506615.git.johannes.schindelin@gmx.de> <20170303033623.lfi7jhul6psbdde6@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/1WIY9PApVsw+Gi+GgY9gHK5aqiqBiseakAAihRdHlrouWuFsSB
 q7FYzL7aUVyAXkEHcTHcXc+bjirL5TiE+JtNS9m6ZbGRXUuC7/oRdX0jJO8Ol0h+3YgDXvY
 i6f/obUsvRVw01HE86oeeYWDyZ1AVXYEXWEV1HG8EMqMg5ppB+UJvnjqazJ4ZF8cXYnPYuZ
 3RAAqlngjD14kz9c1qzsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xwkCtnptDbA=:Q66S4vmL/5GpuYIsCS9lGj
 6bci9iVx7esJWmMrXMVt96IDqE82eZVd7EWAdhAH5xlootG6in51l0F7dsyjTfWnXr2LKa8NZ
 +lnSln7ojfUGUsYvSogK5FFiOVKKytd6vfG3mSaN2HrhAn1mN1lJmCzWUubnBZptuhIoje2rK
 wkuXTgTgWK23od2FAC99RnrjIv+jnP33zs3418fotni52UXEJiHfkvGaIQ5lfmR7LyVn9qZQP
 nR88Icuixils+V56ZAIInk7U5NzGL07Ko7Q1AnDbRzXTX0YEA2m+Q6Bij9SpqLfJQv609/v/H
 Nf0+U2wJsGoIqoxd3bqsZlwbIr5OZh7AWHsFfA/rjSHM8ZRB/LgWDqk+hx6EUYfH2iKU5P42Y
 iOOSCmENbxOsD878BvvS+4U6dC3Uf/OUKBEEfD3VAnUD/KV1JNnHp3UVreOnjAZj9Ba0pl1rU
 VKhfyp1I5fgt/E9RVG/zPHS29fa+0X1EB3PpDn/yr9QANB3SEHAJnYIcwj9hSczw3yVn4Oeio
 ad4M7rPAZMvYX/dSCTUyrA4gYPp3ALC9T1oq0/9Cd2p6c/Nfebwk5abY6tSYqyBCmyJmcMkrh
 kdt1dLS55LROnWk7jQHn/NxrwNYpON2s40f2LKp8izyXUqx5DmYNUEg69akbDm6HGr5OYXjsI
 VCsuADn9AAtf31Qz9Ztu8fvmglmCSiY8qnVTiu9hxolqOvA9VUCsY065lBErtUFTOOXiq8/4A
 8+NCvB8uQLEV6+536YAa1ObKw2ulba4IvVeccEdKxNX65Vc3c2Q1w4zwkJnbfcgB+eZcpxaEQ
 8MS9vgJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 2 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:02AM +0100, Johannes Schindelin wrote:
> 
> > The intention of that test case, however, was to verify that the
> > setup_git_directory() function has not run, because it changes global
> > state such as the current working directory.
> > 
> > To keep that spirit, but fix the incorrect assumption, this patch
> > replaces that test case by a new one that verifies that the pager is
> > run in the subdirectory, i.e. that the current working directory has
> > not been changed at the time the pager is configured and launched,
> > even if the `rev-parse` command requires a .git/ directory and *will*
> > change the working directory.
> 
> This is a great solution to the question I had in v1 ("how do we know
> when setup_git_directory() is run?"). It not only checks the
> internal-code case that we care about, but it also shows how real users
> would get bit if we do the wrong thing.

Thanks!

> > +test_expect_failure TTY 'core.pager in repo config works and retains cwd' '
> > +	sane_unset GIT_PAGER &&
> > +	test_config core.pager "cat >cwd-retained" &&
> > +	(
> > +		cd sub &&
> > +		rm -f cwd-retained &&
> > +		test_terminal git -p rev-parse HEAD &&
> > +		test -e cwd-retained
> > +	)
> > +'
> 
> Does this actually need TTY and test_terminal?

Sadly, yes. If git.c sees a --paginate or -p, it sets use_pager to 1 which
is later used as indicator that setup_pager() should be run. And the first
line of that function reads:

	const char *pager = git_pager(isatty(1));

i.e. it does *not* turn on the pager unconditionally.

> (Also a minor nit: we usually prefer test_path_is_file to "test -e"
> these days).

Thanks, fixed.

Ciao,
Dscho
