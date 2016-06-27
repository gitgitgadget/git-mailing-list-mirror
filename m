Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C342018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbcF0P7F (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:59:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:64286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcF0P7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:59:04 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ll0tl-1briYw412b-00apwG; Mon, 27 Jun 2016 17:58:36
 +0200
Date:	Mon, 27 Jun 2016 17:49:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Alex Riesen <alexander.riesen@cetitec.com>
cc:	git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for $FILENAMES in tool definitions
In-Reply-To: <20160627132137.GC4194@pflmari>
Message-ID: <alpine.DEB.2.20.1606271748250.12947@virtualbox>
References: <20160627132137.GC4194@pflmari>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gx0cuV/JI0Mg42uEJlDNIUFiSJDHfg1X++axyoFigF3EUlj1E75
 +I5ZG9xmhc0S/JuBD/kk/mRnK2Q/w1xK6rSnzkRiu6aBdFqwZ4ZBlJmjG4Wdy5AckQ2MQlj
 +CKsTQwqLiX9AurDQMv8TVreO8x+I/LD8h3O7/V4OAfO4Zc6V5IIEGylFV+Nig/TVMx5JgD
 8Un4IwvD9fDseaOdsSCvg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:yo3gFegLr5c=:TLSwjHVe4rFrAnlVq7sjH8
 jEZRyP64ejCdpMG+1+Cps87Pyx+S9y8ruyj35XE5FSGO5vCk0PiqTayJk9Z1n3DzoDAIXnQfd
 oSr73G9QVoVQpfUCYs62oktE3QxtOcWTrO0WgrUHvhPKfM5Szc6W0YIMYsTnhSI5cfpVoFWAQ
 A83APCtbEu8QfPHFRQTS1mK6jodyeyFjZDEXEJh82PvFP+0ntZd93uh9gaSD3dOsUH0yJQ/CD
 lG/GywZqY2qZbZQDH4yK28W2b761CJRA70l6oXQKV1yfOzfBDzVwSrdnycFqvCOSW8INI7gCE
 HKBfJ4P53CcqOOBBo9ChRRsdn/ylmjtBwSxiAk/6Ni3iiP9qQlpDmTDU7eEcM8zQm02F065S1
 QVLqd1vjlCSbTCWQJht4m985kd2yQ6miZthYgQkxljWc/F7TKlHjEcBg7ERP351gQptiGOH01
 KTNKm5lRSnQ9n5V/X9oh9BRM93INBvOQyoDyU0vvZXjjmwhbah67sO6o93ST1LTr2tss0xXH6
 Sx4MN8BgSCZ1QJKOHHtNMKC/WP1LYSzHecN+3djLbJkNq3ApVseDgCS6bq7NYkJI5vEg4mPtV
 jIzQunMl6wK/ds1O3d6NXShkePVGAlCDTfWxeQH0rgHIcFVHHB8GRMcQeHAN7crTXc8MCGvTU
 XguKOTP2qiH+8dNTdb6wobUjxIJlPtDmrwneH7ev7Eplo/eKMJ894lK3pwhYjlMgxulWL2Vr7
 K/heIRYfyie3Q5C25LAK/9wKwUSulVR9/DXmgqGqMI1sBDhJ8MItuvX0gmyt4PLhkeGAd+xZT
 8XZkRDB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Alex,

On Mon, 27 Jun 2016, Alex Riesen wrote:

> This adds a FILENAMES environment variable, which contains the repository
> pathnames of all selected files the list.
> The variable contains the names separated by spaces.
> 
> Similar to the FILENAME it is broken yet, if the names contain spaces.
> 
> Note that the file marked and diffed immediately after starting the GUI up,
> is not actually selected. One must click on it once to really select it.
> 
> Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>

Maybe prefix the subject with `git-gui: ` to indicate that this is for the
git-gui.git repository?

Also, please muster some patience, Pat seems to be super busy these days.

Ciao,
Dscho
