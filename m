Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566FC1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbeCBUIK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 15:08:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:59967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932591AbeCBUIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 15:08:09 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDn8s-1evfeu42xC-00H6Lh; Fri, 02
 Mar 2018 21:07:55 +0100
Date:   Fri, 2 Mar 2018 21:07:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 34/35] remote-curl: implement stateless-connect
 command
In-Reply-To: <20180228232252.102167-35-bmwill@google.com>
Message-ID: <nycvar.QRO.7.76.6.1803022106030.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com> <20180228232252.102167-35-bmwill@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w/Zzj/UGlbX6aA37JCK4hRgqUKu2PG9iO8lrUI4NvZpUI1KQQxO
 bpBWTzVfIMwtfQ05mHUVT9QisbkqUchdzHr/MM4thJkbpqO7HnD0hewPVGs8XiQ/Y8PsWzm
 kcRNJAgroQLL0nK7NznVhYd+nafN3vNKUDgcaWDsMzdLrHZhUNN6tWcyUkdNrthwGrDVgbK
 0WTnb6NgpdNH2lXkEjFdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kgYIEsGPBwc=:VqbV1FZVDzTKualNZjTpkg
 LWWOZHIkP/B7stHc3extxqgym7EB2EJFTSYltdD7inc8DPEMZaoSLIYBthnu9a5rBfSVcwzQg
 bmRq8bO1hg1uZEynr9H/7iBfn6bUJPPAjZ/f9I/NE49korEvb4HWze2rVjhn8a29KSsyJN/fS
 gqGLpzsXGRlVnGB49mE7IPG58xBJtiSyQEuEmluKdVwZ/WHM91xqeojydfH+8hKyW9xJUt6Hs
 du+SOBiZy23D6rWfH3rPj9yT/oMoTIEk5bqeCsnRFyk50y+XCRNa4sZ+bYElXrxOno6W6OtOK
 zp6wHXlvwJtmGtKFz8ecs5mvv7JEi/nVHj65bMeS1X9BxUUAIipf0jnKGEcSN2h3eDrqgKFbY
 fu6b0n/TC/0xqN/RRrlnPmQPsGc/xrR5wdcUJEdpoeiwQBS9hae98DXtWsSbblRAFVUn7mffq
 UVIfBAJsqgUT2UGt+tPef6hcHQ/hzSIPNCdZGClPhzgyaAGFWUTuILKVykGtLcAO5vvJ3q+N+
 25IxOjHsDR9IC5CCMUv45wgiEV+MDXlrSuARwF+CUzT9QH0DfrUfNduMYp/4HuJ4EuEWZ63oU
 QiLIuHIfz9j3eBHAI6u1LvQTAZGxVu5Tsw1HDPhSYV6DOKZ3FbFPpmmeEELZbFlX4p7e+QBnQ
 C/khuG52FDxtnxYK2JnbBDMngntTTSWKsdrAEavzGCSXJrA1rep0G6zzhaUnkCS9tUpeUOkdn
 +gYftK9xdFL5wPcZc3kGvD0CSBBhzsKXUQ61j309bIyBcvg1yF8Sys8Z4CW3VLKLI6wwkbQls
 EqaVzeTPY9bNAYoMtrEH5VBVtTOm1vZzmyQ1FCOUKzf1Y7M88nSqbsLfy0NsML9/PH84Bxu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 28 Feb 2018, Brandon Williams wrote:

> diff --git a/remote-curl.c b/remote-curl.c
> index 66a53f74b..3f882d766 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -188,7 +188,12 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
> [...]
> +static size_t proxy_in(char *buffer, size_t eltsize,
> +		       size_t nmemb, void *userdata)
> +{
> +	size_t max;
> +	struct proxy_state *p = userdata;
> +	size_t avail = p->request_buffer.len - p->pos;
> +
> +
> +	if (eltsize != 1)
> +		BUG("curl read callback called with size = %zu != 1", eltsize);

The format specified %z is not actually portable. Please use PRIuMAX and
cast to (uintmax_t) instead.

This breaks the Windows build of `pu` (before that, there was still a test
failure that I did not have the time to chase down).

Ciao,
Dscho
