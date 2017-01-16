Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C76D20756
	for <e@80x24.org>; Mon, 16 Jan 2017 11:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbdAPLkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 06:40:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:50826 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAPLkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 06:40:25 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpfas-1cxBsD2rqw-00fNug; Mon, 16
 Jan 2017 12:40:19 +0100
Date:   Mon, 16 Jan 2017 12:40:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
In-Reply-To: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701161231530.3469@virtualbox>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N5CDFVpnEUsfJ9wdfIn6bboNfISA2S/YXnzhJ/bwVrC+ie/ggiU
 Q1GtBv0SsBj8jz6ocTWecIu1ZH+F/2f2kBWS4WZw9bwAcAYPvYds0FUzF/+uin2KCV1clt6
 uUq/DjjZwzP/giyaS2hDO+VP321jsAA9BI2305H7+3K0Sq7yr/1XBHuNbIHmfcnRSng480C
 98qt7c2IoIjuArnWkPheg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1XSY0hCiWoM=:C14yLk7NCPJmrSCKEkytja
 2LW6+aM2xD9tbrTucvymz0QNM3ucXFqGbBxEx+okbFM9jSmCkpuJBu4nwc5YK9NSePI2n9Kd4
 rwtIqep2kBMhy9nrIm7vnPW4umCkoajuvnlmW3HVYesglNhWKEM/Wi65qvjI9lxHL0gLntrv+
 7TL5+YluScv4ZUAgNBb3bOLtwsxRljmo1t0ogkyys6G31brmnLRNQp6/qvKJWnnQ8KOJNaQ4j
 uKxLuqyzWQt/ZN7wUtTaOL1UbB4mpVGo757wdYUWHI/lCeEjO1ZQDFG8Fs5pZx4R3a4ZbkLIR
 mScCHH0/iGUc9wJVeUBjJBlJtGw6bw80nxGnBzbRXh6vwEQaAj5ZgJ+ELobugYw1u9IXoP+G5
 sJoJq6BGUqmd9T41QWPDBBJmV26q5fFszrZrwKrV1i8zmCFOGp+0SnN/5qVkhAj1QVwbT8sUS
 B6T6Wpch02H/ot03gc/AeUgNslDdRrhldlMdcEaXl+3hZo+L30poUpqfMvazCBqLvPAH9+2qo
 mgHh4TaS0boDZfomH6BeyFMEoJgTXABBRXPBuAEKkR/vMmu1Z6qxmmB2W3AP8ByfdhJBKJ/Ma
 9gYonydN6vzFKnMujzYWms75VE4uOUAbz7mlSYMSey5vvkKZkF65CKQY19mXRMqvvjD+umVPu
 JjazJDImQFIYBw/JWdndvLFpUOQvdYinabtYi2UmFM91ehzkTAPVEzOUKerB4xUwRecCpT1AT
 dngwjkgGlrR0LRjq84loNgWfWaQnZRhvjjEEwKOQxOoiCVrOH34uulR96no5Lmg3WeBqjbPGQ
 KqIjJsb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 15 Jan 2017, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

A suggestion: since it is very, very tedious to find the latest
iteration's thread, as well as the corresponding commit in `pu` (or
whatever other branch you use), and since you auto-generate these lists
anyway, it would make things less cumbersome if the commit names of the
tips, as well as the Message-IDs of the cover-letter (or first patch) were
displayed with the topic branches.

It still would not address e.g. the problem that the original authors are
not notified about the current state of their submission by these What's
Cooking mails.

But it would improve the situation.

> * js/difftool-builtin (2017-01-09) 5 commits
>  - t7800: run both builtin and scripted difftool, for now
>  - difftool: implement the functionality in the builtin
>  - difftool: add a skeleton for the upcoming builtin
>  - git_exec_path: do not return the result of getenv()

This patch was not in my patch submission. Sneaking it into this topic
branch is not incorrect.

It does not matter, though, as I will drop the Coverity patches from this
patch series: the conflation of Coverity fixes with the builtin difftool
was a mistake, and I will thereby address that mistake.

Ciao,
Johannes
