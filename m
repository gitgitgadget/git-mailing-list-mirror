Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE302018D
	for <e@80x24.org>; Thu, 11 May 2017 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbdEKNIz (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:08:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:61319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbdEKNIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:08:53 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ls7MZ-1eAN1H1IVj-013zYt; Thu, 11
 May 2017 15:08:36 +0200
Date:   Thu, 11 May 2017 15:08:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
In-Reply-To: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705111506030.146734@virtualbox>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O0lULDzjGKp5+5Nkhgfdow4KbcuDdU1Ast671N6WIWXFM91444V
 Kzr+hBfIcpWrZj4mB7LbmqRcpCDSzP1Ann+lGV8kC65rrYYMCbfSdVV28gMUQFNyyL4NfEl
 5lmKustXmGxqDfMq6DS3dKzhD1ZWbQX95k8tXupyKx7iWc85upOTCc8eZ5tP15JUcOQxLdG
 9RbSlDLUKvczFlArBPf0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d5nJSY65ytg=:2uXrxo8tb8iLuY95P5GpJ5
 5BjWa6fW6dl1f+66hYJs0IV4HOwyz+Shm0GgYIjyJFMK9bYukO2W07a6PN0b550K9L71KO+OO
 WMq2z8iA5TahVlpP1GE0+GoLJPaAmMXTg+zeqmsKiFpLkRNe2uCfC++MOl0yI2VPgwvJXyV4N
 EPgndt+uDjXFiRamqHbg5lAoFB5jSkUjm9S948NXVLErT2w1kRyHmuYE7Bxet32K67TN1LWde
 2At9awjMd8H7vqH+1F9JLlcmihaQyI5Q/ZcabU6haAx5SODgCd11BH89ptkJN9Yo5hS2pddp9
 mt99OkCtPprWsrR5zCDK/tapKVOCCX1PpIWTMs2eH4Tqp3Jw+g10WSRu6U9J4zMRNtr8KaweO
 ABjS9jGY/ZuQNxvtK2OGdMIHskeABQ2DSctnRBHyAvAC6FdZNvrd576if1UrXu1Kr6EMnadqQ
 1j0roSxibJFx0nsmOyjVHiEv/Ub0QenFU15jQRNSuGJ+7VQvmQbxYoOjDEL+rr9Rar3UvcjSw
 Fp/l1PlNXT4+1/fO2VYAsMhmXdWh9DyCV/HdemczmfUzZUTwEMv6GRbqqrSrmo9i2jgd0JROM
 gwrf6Cg+llMXCk2jQDbcEqEoACQx8YwRNlK0X8OTqprhu6k7QbCpdEcBJzJIZNTt+hyVpTua6
 Yr45d03TH+jQuYAs54RxH32k/oqqmTPF9pvoJHSXl0ZRiI8nbPHytggNwQsSYUIO9c0r4Hc2O
 Z0Xs8kE/MpdcaleJHh8+tkRDeH+S22izMwr61wYgAHXh0BMSRzukdMR2u3EIeeUbhIKnrz3QL
 JptXSTD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 May 2017, Junio C Hamano wrote:

> * jc/bundle (2016-03-03) 6 commits
>  - index-pack: --clone-bundle option
>  - Merge branch 'jc/index-pack' into jc/bundle
>  - bundle v3: the beginning
>  - bundle: keep a copy of bundle file name in the in-core bundle header
>  - bundle: plug resource leak
>  - bundle doc: 'verify' is not about verifying the bundle
> 
>  The beginning of "split bundle", which could be one of the
>  ingredients to allow "git clone" traffic off of the core server
>  network to CDN.
> 
>  This was surrected from a "to be discarded" pile, as from time to
>  time people wonder about resumable clone that can be primed without
>  bothering Git servers with dynamic packfile creation, and some
>  people seem to think that the topic could serve as a useful
>  building block for that goal.  But nothing seem to have happend.
>  Unless people really want it, I am inclined to discard this topic.
>  Opinions?

The primary concern that wants to be solved by these patches is the
resumable clone, right?

If so, I think that we may want to rethink that approach. If your
bandwidth is flakey and your repository is large, the upcoming work to
support fetching objects incrementally (there are three competing
proposals about this IIUC, hopefully they will settle into a single
approach soon) may actually be the better way forward.

Ciao,
Dscho
