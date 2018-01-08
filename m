Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2171FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755913AbeAHUew (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:34:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:49867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755899AbeAHUev (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:34:51 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LynHb-1euj7B1yrv-0166Lo; Mon, 08
 Jan 2018 21:34:46 +0100
Date:   Mon, 8 Jan 2018 21:34:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Colin Walters <walters@verbum.org>
cc:     git@vger.kernel.org
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
In-Reply-To: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
Message-ID: <nycvar.QRO.7.76.6.1801082132510.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Lvku2x4CGUMbUYBHgEWPaglhWqMy8tWc+7qGb2fjnTs/RORQchh
 N0c0YDjjTQQ4DeO/VHgSeJ8JEuCq46QBtRQcSrlpFCrrT4ojjeh3dgb7DFHuAFgJdUsYLh8
 twroKJe0dtqdMH8jewKKHMpYzXz/yJ9wXLKncDbHHwSuZaV4PCTLWjv82bT+yrVbxwjy40/
 +clHlZC+o4GOg4VrZqRFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fzzHRGhCPc0=:q0qtjeVblVLxqDHg9rqyjy
 CAUCUSN9HbjMcZOw54MCkgLT1fMQhxRrKmBIDIS3fop6xvwhsWQuhaxowQN601rR+UfXJ1fWg
 KK+8E8mTGYgCMRXNU51lmCfk/CigE9Y3fwXskG1QL//U1HKLclkxGyNLQkvQqZI89MDbyFlTI
 wbUwGc4RJDMqBex9riTCp0ledKZS3EH9eCXhcBX5vOQd5RCtcpG7U9eFptaBiahJ5VyRRwjv5
 Fj1D9qEJe0Jsskn2tGcP7fOVSOnmn4lzaaKPRV7Gom5vIH8nIodvPLbKgR88xrnP5n33iXYmr
 0pNLEbTyt2sDyySJf+PX3E4n0p6H2YISbAa9+eeMqp7jvhKB9wrLGbwEiu2E739sNzNYA5iCF
 ljwFh7fSoLFY9l9NmJsy5j+nFof4NpckV6Z863yu989WhFkliVtP24D4w8DmOwZQXVfhc8NxH
 XEWYQ9zJHtephwuzYKDhn9JmheoGjoEb4EJ517w+8NRqNONtUIpaBEOC496twzHhC7nGyqqEE
 utgSS8iG9COS0HeNtRk2CO7nzUnRvFV+RnySn6KISP5/d0UpOoTGHv+Thvoryx/HRLiFkqvxN
 T/1AZxgITGsArBXomg5GAVcFX1mlXqZbVwUzGgd9XgkbJPRwzZ+XVuweQXmI0NQVlaLV9yWzN
 OlFTAbAVeVWHOpGpczt4q8WHfWAGXzFUNxI9nbKoflB5wtbAr530p+6/Cwy9bMCT6coIEsaq8
 kZ7oMTB8DVzkFn4Z4EYbHZw+3YVjASOBiGm8DQQ5P7wIuj4XodTNBD7CHcZLsLTIrkwPxEgL6
 BG0CYGaanc8UjJuKtbCvoVj+k/jZxDdyFKMr0Vqh7lrg7WU9fFH/GS2BWK+iPsgnTCgGpC5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Jan 2018, Colin Walters wrote:

> Hi, so quite a while ago I wrote this:
> https://github.com/cgwalters/git-evtag

For the benefit of readers who prefer to stay in their mail readers:

	git-evtag

	git-evtag can be used as a replacement for git-tag -s. It will
	generate a strong checksum (called Git-EVTag-v0-SHA512) over the
	commit, tree, and blobs it references (and recursively over
	submodules). A primary rationale for this is that the underlying SHA1
	algorithm of git is under increasing threat. Further, a goal here
	is to create a checksum that covers the entire source of a single
	revision as a replacement for tarballs + checksums.

> Since I last posted about this on the list here, of course
> shattered.io happened.  It also looks
> like there was a node.js implementation written.
> 
> Any interest in having this in core git?  

I have no opinion, I was just curious what this otherwise undescribed
thing was about.

Ciao,
Johannes
