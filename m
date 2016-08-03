Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1982079F
	for <e@80x24.org>; Wed,  3 Aug 2016 15:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbcHCPTv (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:19:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:57707 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbcHCPTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:19:49 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lxu7U-1bAKTm2qsW-015Lgz; Wed, 03 Aug 2016 17:19:46
 +0200
Date:	Wed, 3 Aug 2016 17:19:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Chris Packham <judge.packham@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
In-Reply-To: <alpine.DEB.2.20.1608031621590.107993@virtualbox>
Message-ID: <alpine.DEB.2.20.1608031714410.107993@virtualbox>
References: <20160803084743.3299-1-judge.packham@gmail.com> <alpine.DEB.2.20.1608031621590.107993@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QxxhRPwc3683JnKW1gLMkAg2oDTKEXs2nBocF62/bhpLLm5qpbq
 lt9B3CYb0b9m16X6IN9NDH3vcC5JYz7WBDD2ojrtqoXigzbsarDVOPVwiVaexoilvMh5+AX
 JwxmY09w2ioEGQRQ3KDHNQdtbHgC2YW9h4pxBwm8S4gC15U9JTNvGQXD0OE1LUP7tQZCuqO
 MDX3fvhpysHIQMi6IPCXw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:SWGmUWNhDog=:pF3aVZoEP/EYsDiJ0DDqj9
 LnSlyD3TjaxxZ/03RzqHl8G4uZQ8joUTzR/kKtyouCPhWIfjzQxZJzgMn3wKcPe7ufuiCOIw3
 8g3bzX2v50kNWvSsWMuRzmTC4lycOkVKRh825sp0D+I5gUcc/23PxZmFYpjMeUe4klAQPjd6Z
 b5uRhuQcD+UDE/OSuN8kukt6XllUAtZhOERDGQfWcf0f7yhExUxLBDAQz4CSSAfsBiHnkx6oU
 Lw4cwR1ftW8MeK+YVsURUvyI+WgY17TGBrQhA2pft+vKzANi1lziT/oAdykcNFG5NI6ks5+Eu
 OIAhYnxUNTrUB222YjSUe6O8z7mbnRaboA6SF5szGDnd66qfoucnGaKmmdxTwgu4nUAGRekT0
 Et5NYvkNfMT4oAT6yW7fNq0gLcEm4Z4dw5PbcJS0VNcO+v0wvWMPx4Fw8xmq6o2LuCsHzszg1
 7DYk1rCvKL1e4xX79nqbt3HL88ZQwu9e+Y0oWWqseGY0KtoxL2dRhXMzHfgfkkfCG0NTjCJNa
 9TStyL49EePJODKjpyueaGio85SrDyH8P9lznfK3BlLHpfYlSchJlOb/5pLivUV3hxsu/Hd7S
 dCSDwx5DQ4E3Z9lA8RIlRTwvNEX6YuGtOO9MyGBawV3D4VjwpoP89cEJBhXKVQm1phuj8HG9I
 tYn7I9qT6QrHnNzkr0unnd7s0f7Pt/vk+QF5uDETaEj6y29zcFZ9Gmo1nJPdBwQFlkxm0Imid
 0u6Lioxi7LH7L6W5iEgl1EsGMSocoCm17JQ7TxgX3PGbe+BiXKKFVisVwNHfB8jUhbsHAyias
 u1GGUWX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Chris,

On Wed, 3 Aug 2016, Johannes Schindelin wrote:

> I can understand how this "sign" command helps you. I myself wished for
> new commands when working on my Git garden shears [*1*] (essentially, what
> git rebase --interactive --preserve-merges *should* have been).

And of course I forgot to provide the footnote. Sigh. So here they are,
the Git garden shears, intended to rebase a thicket of branches:

https://github.com/git-for-windows/build-extra/blob/master/shears.sh

The edit script will look somewhat like this:

	mark onto

	# branch "something"
	bud
	pick abcdef first commit
	pick abcde0 second commit
	mark something

	# branch "another-one"
	bud
	pick cafebabe yep, that's a different branch
	mark another-one

	bud
	merge -C 0123456 something
	merge -C 6543210 another-one

	cleanup something another-one

So you see, I needed to introduce new commands: bud, mark, merge and
cleanup (I actually also added a "reset" one).

The fake editor I talked about is really the script itself, which detects
that it was run as the fake editor, and which converts all those commands
into the form "exec git .r <command> <parameters>...". The alias..r
setting also points to the same script, so that I really only need one
script. It's one big hack, but it works.

Needless to say, my idea to support new rebase -i commands via config
settings would be something I would use myself in the Git garden shears.

Ciao,
Johannes
