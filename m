Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C26620195
	for <e@80x24.org>; Sun, 17 Jul 2016 07:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbcGQHPn (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 03:15:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:61820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbcGQHPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 03:15:42 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lqhaw-1atSHI27Ig-00eJud; Sun, 17 Jul 2016 09:15:38
 +0200
Date:	Sun, 17 Jul 2016 09:15:38 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	mappu <mappu04@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: proposal: allow git clone for http-hosted bundles
In-Reply-To: <2841ce89-9c46-c3f2-53d8-afef6e1e5b01@gmail.com>
Message-ID: <alpine.DEB.2.20.1607170914330.28832@virtualbox>
References: <2841ce89-9c46-c3f2-53d8-afef6e1e5b01@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gEjROb/fOC5wjNR6YN/yebBI3cSTW7CNemnnPUlVVjnDphEiVde
 TAk7egYgO9F75Bvu52u6RyHNdG73Rh3LCv6AgDpovHfze7tFnNyLJaRncfAeJ0iOaCWI2aT
 TkllYUZ1tcPN0rmOBk+B/b0ZAmvJXUcaeWz7jrspwm4XAKPquwm59NHAYJhiNAiKEpa0UI7
 yuzWQjYZVF/wFotrkXwjw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:UBpmLX3PRUc=:3p+SX15kX1skMlO7hyp/FA
 hjfxZYWUk0Fo+fUCNZAypXfp+ns2y+xVUyxGegXK4ngpIySvBjMbaPanrHRJkhFiZUlmxB0gU
 WFC1+KCASc4Lc4vdk2aPK4CU7YieIvYujtS8stB/Ev8M5m1eg/3y+cl8zrX71dhvbRAbDun5V
 Salvf4DYGPoErrHgADObUvBM7VqG5cj+7mA7mzQVhiFMRg40Js9WeIX9126IEQ4Hbq/h8KOSe
 tkRHlU2NeJjMwpXaiKof1YtPHPv3BBmil2fHxPasFXi1ULeHJpw2SlpuGn4s4F794Eol58z42
 MlR6d28Ax6igea5FoUYfG3VIzbWrGJ1hGOjEb3agmTvjWYhUnfp/tvBSD3bc3dnDES89zH8vd
 9FCRXtgne3gz9jHByqItcFx8gVXzAJUTyA2xLJrTHKAQ4Hs4hcuG9MdS9rZJqaqZtGIQEiRcG
 OmhVEuMkDGKcSyXJU5EpXjPIFKoWY+z8/TPfQ5D/LVDazEYYUmaPpOm+aDxJfQk21LRYDrUiE
 JeN4LHkWFgIlBiaq5vF9ifveyI6A9URE6Dxq0iFz0KwONpzhD6dBwAjkUaWoUwo0BOW/sqY3G
 YqtSDLUKlip2xIvc07nSRothCizYu6qw4U+sWgkJii7WfO7R7qN4vufTxRL0P9MkX7oCy6jLm
 CkoidLTtIz2c6vbjNn0RtslUU59VSHBkPpf81q61MajKVOIQ0+/bCWc1HNbYFgy2E372Zt6NE
 Dug/Ad5+Yb2cXpXQjxvbpUs1wugaTXP2ZSc1mgB/NS4Tr6NHH8YisBCDiio8S78wZNhwAmm/F
 odoaPoe
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ho mappu,

On Sun, 17 Jul 2016, mappu wrote:

> Right now it's possible to git clone a repository over http, and git
> clone a bundle from the local filesystem, but it's not possible to git
> clone a bundle hosted on http.
> 
> Would it be possible to allow this in the future? Hopefully it's only a
> minor refactor in `builtin/clone.c`.

Why don't you just give it a whirl? That would answer the question pretty
quickly...

Ciao,
Johannes
