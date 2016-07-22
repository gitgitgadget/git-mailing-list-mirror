Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51795203C1
	for <e@80x24.org>; Fri, 22 Jul 2016 08:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbcGVIVj (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 04:21:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:57286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcGVIVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 04:21:37 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LuwiT-1bHGMp0QYz-0105y3; Fri, 22 Jul 2016 10:21:34
 +0200
Date:	Fri, 22 Jul 2016 10:21:19 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Johannes Sixt <j6t@kdbg.org>
cc:	Git Mailing List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>
Subject: Re: [PATCH ew/daemon-socket-keepalive] Windows: add missing definition
 of ENOTSOCK
In-Reply-To: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
Message-ID: <alpine.DEB.2.20.1607221020520.14111@virtualbox>
References: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UUrRij64+QfugkVzOIKTdfYBkNxyi5qMqlqg7eTGN95hY+0uffs
 tawhvYWx/KQaYBPZDfTE37kv1ZB5Eu+pC4Bvjr3lB/5WqE+h8pBimfkYWrf4A/kN+FKuI9U
 wjwTGi/ui/mV0VJxKAUdzR5yTFZ/A2VKWrNVfpxCCf0Lqh+NQVuekDaP3TPQSTL4cU12MyB
 kfxHU7B00E7vtS2LCdeWQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YKsh+373WrA=:HR/wo8zSVXMXynGuIWVjRf
 gliOQtNnJLZcLJwQlsuqALUxHttNf7EuEGF4k4cORN5tt8Es1oq46Mx0IqN2m3FtRyWsX5Y5y
 tOYNvaw280xfHI/xQMV71OQJHv5CNUcS/Q8aCbL+ZRHPnYH9fAXkA5lTuGIiS8ssdCp6AP+0o
 TtnrZo5TePY4IUzxsKWDZINQH1J4yFWtoPwas9HjFDB2/RXdhE6+i9g7hTzip+QpYLgH3cG2B
 kXKR5nZxpfFgTxHawl0lNdnNyflTLUKj3DM/u04CGag5TlTKA3C+btUFdO5HKiz7T24KAj7PO
 ECd/QflnrLEm6NrRRUDBu0+T9Uatb5evtpEP2YwoibiM7aA5qjjF4cktNcFdVcBxwP9g/utis
 Zf4TBX/3HZkqBVJTVrQR1jcqKtvytMH8TVNKgfShcBdlq/BdH3NFGPzoEQnxTP8RM2HUSHICf
 /wRfGcR3hkex7scQuuHVAop9E8vKVDw0/2IUs3FT2gZ1Ap3xHgBjv2rlC9DpmCa9iN014oTu+
 AYNY3i8UpDCYZ2I/GqNdDW6F4kU1ui6T99ZVRZDTeldwprAewTdhme8j+ZiLeIlSOHaKVIgKd
 Dk813A/WzKEeTbG90xag5F82I5oyUnOrJmBrAnVhgrfkYUNMfEFboHLJPkvRqyFFTpJaNztof
 pU5AxfRJQvWFAIVp3pa74L86tsmu52/U1K/DyVpAJWMKumJFtNqDVWJ5SoDvawlW1Vox64uhd
 aLhFMA8aUT7ABIEAOM5TWCSiCzl5x1BmYPcJJ1hsyAYAlw6Az6HZUO1U8v4KfCqEUnt5+o1yu
 818NDuH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Hannes,

On Thu, 21 Jul 2016, Johannes Sixt wrote:

> The previous commit introduced the first use of ENOTSOCK. This macro is
> not available on Windows. Define it as WSAENOTSOCK because that is the
> corresponding error value reported by the Windows versions of socket
> functions.

Thanks for catching this early.

Ciao,
Dscho
