Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB6220756
	for <e@80x24.org>; Thu, 12 Jan 2017 09:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdALJ6I (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 04:58:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:49375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbdALJ6G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 04:58:06 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1cosfb0bXg-00psO6; Thu, 12
 Jan 2017 10:57:59 +0100
Date:   Thu, 12 Jan 2017 10:57:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/5] name-rev: add support to discard refs by pattern
 match
In-Reply-To: <20170112001721.2534-4-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.20.1701121056470.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com> <20170112001721.2534-4-jacob.e.keller@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WgiNHUr/on+Z/gr42gKajf8zgeIQd6/+8TRi7Hd3sGg6shrIa43
 fkk222UI/8RhvEul16/H1N8hl5QtS9myn97ntjs8QcRWLg32jHg9fYS+egHNtRYqkMB6ls7
 4D4KZ0Nfhwy7o+FvzHm0dndiFGeCvGuurXYwj+UVwq9naKHnQIS8rfnurDRL00ciupep08Z
 yWGmYzxnpsvTDi/tkYgZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ErFhlRRHjHc=:X1GOJjCg/EZOPDldFD3qMy
 yT3R+DDtDqi5LlelBzAK/uVJjySDo3f8mR+h1uA5MRfeic//+VO7jPPqrcDzHXU8QcNGI1BOT
 zV/B/Cww2+UkhVy2HUR0t0T7YXGx/pP0bAutEm2o79E+tuEhmYEeZAuZLNbW5Tp1hq5P5yP+T
 l8A26GdSzbyRQKHBHK9dcWTs4TbfAb1fFXbtACe2x73WT2J3eqhhodK1AfzNb7OQRVXjt7Ucm
 XymSR+Ehk6fb9aJWz9r0aWrI70ASzy443cvkTqS6N55xDQZ+/XV6O2MuoTz5evDisDzwNCLYD
 nXAzc7ZRy9/+DnZimIdzH2UGjJ2cLSP7vnSv4drNwzx/8eMVMvCMDn0eoqEdWPHQjFZX2Ghk8
 tF5Q77gY+GaFU6nuhPemWFszvWZTSNKdr1GhmvxRPCzCWuSuUTkcQq28/7JNF5zm849Evpm1c
 TYJoQ8thnK9cArnWC8aifU/2FYl8w3ZaeHSbgmGy33L92785TcD7FPKD5k0me2n8PZ9jcl3vF
 KPZneC4K7uM9mZQPifbY1TWCwdws5VKTY2HIa2xKNLsmJ/ybAeN9JgpxKcoy7n6hwqTnHkh1m
 +J0qdIZAHB3WHfk8e60WfO6hdJjVyogz7ntldH7VFcK8dzwiH+mr2XjA69o06o5Vf6l6s84OP
 rV3vkPYRJD6FOxraWXnsyTINg5/EowFSDrevUPTd5Dbj8fmEWCkyQrAtuGZCQskl7qHlqBMJ9
 UfXNB15JOtTlTCTTJ6t7ep81vANkRZAaiBslruWLJ0lfVQ1ped17MYWh8UVm5dpV6fM/nn/TB
 n/ZCfQLcl5hCDiaX4skkmgKp0UBeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 11 Jan 2017, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Extend name-rev further to support matching refs by adding `--discard`
> patterns.

Same comment applies as for 5/5: `--exclude-refs` may be a better name
than `--discard`.

Ciao,
Dscho
