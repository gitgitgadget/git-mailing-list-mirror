Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247B31F744
	for <e@80x24.org>; Mon, 11 Jul 2016 12:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbcGKM6P (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 08:58:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:58642 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbcGKM6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 08:58:14 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LufbI-1bDl2308W0-00zoqT; Mon, 11 Jul 2016 14:58:11
 +0200
Date:	Mon, 11 Jul 2016 14:58:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	KES <kes-kes@yandex.ru>
cc:	git <git@vger.kernel.org>
Subject: Re: Unexpected diff is shown with -w -b options in effect
In-Reply-To: <275091468237350@web16g.yandex.ru>
Message-ID: <alpine.DEB.2.20.1607111430190.6426@virtualbox>
References: <275091468237350@web16g.yandex.ru>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g7yLD53H7u0DTQKzKZFWlpagTjD6kuSEOh4oIE5vBMCC2muABok
 UN6qu412HXitvA1D5g+E30eusPSanTcCodiFig+MNX8F+bUAN9VCxhVTCeNLmhnwgPqLnXu
 /gZkmqzF0mWCpPPL3+JSn8TuJBMQkuLoOPraFwVnBFog94cEaHll8WdWnb4Fjnp8pVk27OU
 hMNAGDW5cSvJKNfeyHGwg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BiVTQ3drIug=:3RBcb2ao+dX22oIMYOilLi
 RSNG3KcB2H1fi21agzONPdEW4zGtMmMbiGwklzxVTxj9VcipXUQWNbVxI3XehuonZ7baXEi3c
 3ICcuQOXQ/aDSRGorni1Kd7m0Youhp7bQNH3yWhNuEPx7MCtoLOSb+oPjcJzefepTbiqoM4tq
 lnuBZL8H6cxb2gybwrJfVGaGS5fnafgZVquy4ZEc6Q6ZzejVFVuFEmDjPJkOQi6ig1Vuml1O6
 ALFzy1CeZNXZc/E7+MbUS8Lf5SK94SuMRjqiil8we512jzxUwIKQ4BQEOAp4N6itr0zlckmrV
 2aRr4FVJ1pC5pcaUlrim2lqFYBv12Qa33zC6Pfs9jisFo43biuUb5495xBmqHJLhqheSMdDsI
 9bMG6IghgQsA39V5t4RR4L1RjKuJC8ALMRzRW2ea6Vju0BJh4L/aT1dpkwcfF0SCUJ9vWSM/+
 bwEWa/1+wRNJbJd9wtOtl7qHf9U7b2anG/25GReWdlXML0dDcsLJr7UR6Icf2qdLkjfp3+ubm
 ZI+tqZdba5YnpeGcQjuhSsf1YiAJiMiCjiRaVUI6rj0zsvAruTsRuPybVpL2jAiC/E4avvKHy
 lGbPLEw6Qaw+wJ9ZmlIox2g+mAjogFEhUOCZrDcdELWan2N2Gq7ZN/I0KDGGVYi9bhFiCzYLz
 uMTmKb4kcyzum6BPoOpfMTN/Z1irO26gbicIQ6xtweRvWgvKoqEAdSmHepm+TT/6vmv8PJ/3r
 z9RqExAujYDeEx45dil8scW88FEgiWysadnQyIqEpzd4M3UVvvmNYkMVSmPTciLtfx1a2iG8C
 WUej3I7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi KES,

On Mon, 11 Jul 2016, KES wrote:

> For this diff
> diff --git a/app/public/v2/index.html b/app/public/v2/index.html
> index f73ba73..3af0c64 100644
> --- a/app/public/v2/index.html
> +++ b/app/public/v2/index.html
> @@ -21,11 +21,15 @@
>  </head>
>  <body>
>  <div id="media-width-detection-element"></div>
> -<div id="rowTools" class="eRowTools btn-group btn-group-sm">
> -	<div    type="button"              class="eBtnMov btn btn-default">MOV</div>
> -	<button type="button" class="eBtnAdd btn btn-default" onclick="rowTools_add_click( this )">ADD</button>
> -	<button type="button" class="eBtnDel btn btn-default" onclick="rowTools_del_click( this )">DEL</button>
> -	<img src="img/add.png"/>
> +<div id="rowTools" class="eRowTools">
> +	<div class="eRow_Separator btn-group btn-group-sm">
> +		<div    type="button" class="eBtnMov btn btn-default">MOV</div>
> +		<button type="button" class="eBtnAdd btn btn-default" onclick="rowTools_add_click( this )">ADD</button>
> +		<button type="button" class="eBtnDel btn btn-default" onclick="rowTools_del_click( this )">DEL</button>
> +	</div>
> +	<div class="eRow_ColAdd">
> +		<img src="img/add.png"/>
> +	</div>
>  </div>
>  <div id="colTools" class="eColTools"></div>
>  <div class="container-fluid">

First of all, I ask you to realize that this diff makes it really, really
tedious to see your problem (too much going on there that is completely
unrelated to the bug: long lines, unnecessarily complex HTML code, too big
of a diff to compare two versions of the diff).

It takes but a little time to clean it up, and then it is so much easier
to make a case.

As to:

> [...]
>          <img src="img/add.png"/>
>      </div>
> +</div>                         <<<<<<<<<<<<<<<<<<<<<<<< IS NOT EXPECTED
>  <div id="colTools" class="eColTools"></div>

vs:

> [...]
>          <img src="img/add.png"/>
> +     </div>                         <<<<<<<<<<<<<<<<<<<<<< EXPECT THIS
>  </div>
>  <div id="colTools" class="eColTools"></div>

You asked for -w *and* for -b, i.e. ignore all white space *and* ignore
white space change. The combination is bogus, of course, as "ignore all
white space" includes "ignore white space change".

If you use only -b, you will see the expected change.

If you use -w, what you saw is actually expected, as git-diff was asked
not to see a difference between the indented vs the unindented </div>: it
really *ignores* all white space in that case. It is not like: ignore all
white space except when there are ambiguous matches.

Ciao,
Johannes
