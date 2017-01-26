Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9331F437
	for <e@80x24.org>; Thu, 26 Jan 2017 11:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbdAZLuZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 06:50:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:53111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752721AbdAZLuY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 06:50:24 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYOkT-1d19cQ1LLF-00V9y4; Thu, 26
 Jan 2017 12:43:07 +0100
Date:   Thu, 26 Jan 2017 12:43:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>
Subject: Re: [PATCH] Documentation: implement linkgit macro for Asciidoctor
In-Reply-To: <20170126001344.445534-1-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1701261242430.3469@virtualbox>
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net> <20170126001344.445534-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o3B66w4yM3fjL6uiAFpUl8RVQ0A4mVN1qwdJS88uCP+QKn2tUTq
 Ttr4Wk50f1Y4o9crnMbozBcptCIXjxOd0oLYj+i8J+FPU7xZxJhd+AnoGHe6aFai3D4J04K
 fRg80cl795XmhDYgoqmT7rcYQr+WsdBgrcIQ7yiXrfPN/g9PGVOaQmfK5GEvfwgPBG1IsSc
 wclieSktR+Y0pKsErtpWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j/C6WlFPZ7c=:OAORsIH0cdi/3zbEQl6P04
 /NQ4RA11yMoSv/kF4ZJ6MUn+3WX6wmLVUYfDrrvEq8TTu+VmnWTHeXWBYZj8nfoFY07y8t2H2
 eGN1h2S0DjjbHEgGMoH5HAGJNnfiN7hEiRDD0HntQKuVHVWmz8bydIx2WtCyHjcLlZ5o/oaUw
 XSrrVaD3Qgul4hINT6lh1eMq/3rFoHUDKp1jC3lldmN4NuUyZQ6pANSTt4BRQFKGeXZgXngbv
 6vkBmv6QtvafI19+H5MXYIepwsG/E1ozIcvWM2gMHHUU4smI7avZHwkIfb/UGT9alqWpWEoza
 50FKh55zrnLfC/XRFmHiUHR4nGWmS3tuq1mIucpcilz1tRXufSWGSOu2fqWU8+/9sUdUQ3lcX
 fyw39ygFPTkobdykPlqjGt7zciimxkL2ZwQX+WbAj+ioZV2GQPZKqQQYLUyFq/2DVQT1K20lJ
 D9s+sqAHi+Lox4kvjBrYgYNtAlzMEIlFLKIZ1QiLBBcWXhT+IsZmr1ucxCSXh9M8l+KrWoW6M
 oyw9rIdlPszE7h+ZplVQfj4slIobqlYvrBmGEVBwYVoMlc8kp91OQ6ysk5pty4Hk6cVZxRVY4
 mWZjICY1k/qJwXfvFKUMPw5nVxAGZYwSXGreD5sTQWZCJVGoj85kcuSD+/8NWToIxyohGaRWY
 vuvO2CB65/l0w9764eG7ONJXiZdK5YyhxmhYJgrCO/SCSoduf/GrImSD/RCnk8W7wGe0zCQEt
 qwe8sfeSQQF1PGoFeF07DsbhLLV9RBun0VgVZNUncuMy7/JjVul2etXlgge7I2+Iw5cPxkrLe
 YyB2RCT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Thu, 26 Jan 2017, brian m. carlson wrote:

> AsciiDoc uses a configuration file to implement macros like linkgit,
> while Asciidoctor uses Ruby extensions.  Implement a Ruby extension that
> implements the linkgit macro for Asciidoctor in the same way that
> asciidoc.conf does for AsciiDoc.  Adjust the Makefile to use it by
> default.

I like it.

Thank you,
Johannes
