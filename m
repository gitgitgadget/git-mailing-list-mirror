Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082872018B
	for <e@80x24.org>; Wed, 20 Jul 2016 11:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbcGTL0k (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 07:26:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:56717 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbcGTL0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 07:26:00 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MQR3s-1bmsol1VGO-00TkQ7; Wed, 20 Jul 2016 13:25:51
 +0200
Date:	Wed, 20 Jul 2016 13:25:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Wong <e@80x24.org>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: set PERL_PATH for FreeBSD 5.0+
In-Reply-To: <20160720025630.GA71874@plume>
Message-ID: <alpine.DEB.2.20.1607201322350.14111@virtualbox>
References: <20160720025630.GA71874@plume>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w2rWZ9MWlHbDcyWSk4hWXwVZ5kVLEy2KTFN6sn5CtTaKyAfvzrQ
 hbcZVQKAYY5BFqU4jv4APFDZL0y3zIY3+71Yva3fOgo0Zy8UpKQ4+H5rqdnokDjM/oKMfF4
 jo7dIVxPA8kKRCyTv7swYdDrYXBMAQ8QegieU+yKKfFnzAesR9azqMoHuBgXuuEoHD/KGnE
 JHqBaD4XiD/0tYG8rMzsw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QqwE6b3fbo4=:g0hTTAgODGKSQysRQl6Uep
 NQevki8ADrtHilNlEw7k+aEhhTu6pczskSNJad2dPCE+UDp76JQSDYZev7FWRQN5uc3olCO92
 l8mqCfdpBstz6Wv01XoQmFVGIYOHW9xqOnfMujTB1hpAGB5u8GB37VL8ESfMcuuBEFEzcopMQ
 9+LWyLacN2n2QJ3r3MKOZ9G97Vfick/5fRzmYn81PcyIl/VhVu8DnxQFV3eOPwY875EJUdL+9
 f9TTC5OwSuzZMw/Wf77mT5HsX6jjHJpQU4sKAXIsFsSW8SJX8TfUQv+lpgUnzQd++WX9ZZ4dv
 1JOzV0ZiK7Sa8l3tS131nF7JVpnLFiJrJbXdBQ8cYh5IXY3hQT/iG7P47S0OoRAk/1fHJd6ka
 kSnwCkc3plkFB02JApbdRzkN+YuDtKs2rRZQ9MQF2IaoZxLdcarOmMjbNSAoRVjmNN2a4IfyL
 asAnR+FLay954fesfRmuZLw3+bHPno25wsZJx0tF3mGO67gVitR+CC7NQdevcSO4GNzc77IMJ
 H0+OZ30q4+wUawUy9SFRHaOoNgDnApvjwTtXOpWCrarSPU2EL/CDatBwF9OnNvRPzkrU5ur1x
 /pw5LcdSmLYle6suAWXaYsyqcE5m+EarjI9zmqjxd4Cm93RqtmESjMNc5qFaQsEmPuG+EuJn9
 AbulcKHPJcl0faI0NxdmWaxZm6P8Vjq95X+7dCSfgYrE6f6gSE3eQAEbbGrsVvFAiimIjvZYi
 Tpf2RLnJ0jfHhqPCd6Fmj+BEu8sKK0Kdb6QOAn+7hpJ+5XDN+Vc3rM01oGUzXTYLtyqSBi0Q6
 V5D3FB0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Wed, 20 Jul 2016, Eric Wong wrote:

> diff --git a/config.mak.uname b/config.mak.uname
> index a88f139..6c29545 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -202,6 +202,11 @@ ifeq ($(uname_S),FreeBSD)
>  		NO_UINTMAX_T = YesPlease
>  		NO_STRTOUMAX = YesPlease
>  	endif
> +	R_MAJOR := $(shell expr "$(uname_R)" : '\([0-9]*\)\.')
> +
> +	ifeq ($(shell test "$(R_MAJOR)" -ge 5 && echo 1),1)
> +		PERL_PATH = /usr/local/bin/perl
> +	endif

In keeping with other uname_R usage, should this not read

	# Since FreeBSD 5.0, Perl is part of the core
	ifneq ($(shell expr "$(uname_R)" : '[1-4]\.'),2)
		PERL_PATH = /usr/local/bin/perl
	endif

instead?

Ciao,
Dscho
