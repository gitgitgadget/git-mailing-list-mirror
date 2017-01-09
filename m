Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AB920756
	for <e@80x24.org>; Mon,  9 Jan 2017 11:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759932AbdAILhU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 06:37:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:52720 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754942AbdAILhS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 06:37:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqW8j-1cvC2a1sBN-00e0q0; Mon, 09
 Jan 2017 12:36:58 +0100
Date:   Mon, 9 Jan 2017 12:36:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (preview)
In-Reply-To: <xmqqmvf0yke0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701091228460.3469@virtualbox>
References: <xmqqmvf0yke0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R/YkWcagqjN4ZnjGLIBmYqN+bsjINRoqLe7n+CVaoyCrMVbM8Ay
 eoHfGUvFrtMkvhWbCi4ce2hpLmygcA7INgyDAWI3+Wa0o4Z8HzgjHGuZQBDl0Sha1SAT0yu
 Atfsq80keIcm8swGSOHBlnMhwYKOz13pDOvyVlMAv5v7ZoLoIu3leBLCZo9wx5TeG/t7egw
 xYkG9eD8v+pF1EgN80NfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gMflQb8L0vE=:2JNyqK2zfKTwjsrsIP2U3A
 apIMutPoZfuncSGJthM8PMaENgNTVpfFQaLUrHRFCeLqFO8TziMbZv1YvuRM09Td7CKbVfXS0
 JcD5+UoBTw6rk1j1AH+xa3ZFI9NF78tSxNJ2L4dd7yi1owCJFqHokgqdS9oYH0E9wSUwPAEHe
 JqRSK21TB5o2KQDEqfnNMy+sAw4CCw6rL7j3zwSxHjbC7yuGfiW+zlKrP595dXLcXymzav5Lg
 L+T2jpCCZQ/8SnAmERJgqmehmw+ZXYP4z/BLuXstjPVDM8/3h25NesXH6IJ2uF0np8StpM5cp
 YXtN8OGk8ZWXRkvpGFgUS14PRSzdKJV1fMee3hvEtzWXKIinIcR22UsqW3+x/MVpXov8J3BUN
 bROlLbUGT5xthpPo/8cJPnM+8dquNk/2Iq0Y/kwAwBw4mMZZMvkv4BC5lt9dlwK2REobXKICU
 G2wWJAMFs5ZU7ALlXW5pW411clydY2Pi0UErqSGcYRjyjxxxxKJDXbKcIGzfbYaBS22Lz3lpt
 K3t+NjMsUhiinj9wHe9/qPHDAis8elePlArO8fXMiAgQze01wZqvyKq+BXI2pnhP2NUHdlUJH
 5qNfFVz2hHOz1UgiQuEJDsGiX9+FMooNalzoCcnG+kb2Q25GC3C26QTosva3KigwvYm9x3uXn
 V21/QESXbDJ7HoJ4RxNHviDk7BeEb2i/2pIbznOifncN3Trqt01J5vjdHPCx5r5J62JbJOO3t
 jSxg6o8kXkyIkVZ0bqd7H1M2BZBBvDmo/eykN2nSO+QhxRpKxCPw69sioI+6zfMw9J0Qvr1Uq
 T6hnLvd6iapju00iv+qs7ntZMnxJbnhhf+EAui3TeiN3+G5aWOevyZ4oVNhZ7Kr5rjaTcpGBs
 XI54613kbX3wOJE+Zpe9b053V1fMsDfl4SNuxTpGqucn1HOzby19P3K7Gs4OU5sZQqudIIhRI
 lYJjrsrAxUrbjQaBCfOZuwSe5duxrUa5rZAUxlq9vdRZ4J+1hXjPE2tRqFoTmltG3uVq3Tw0g
 SjKVuhIhGIPhAnAGijMc7a1dEV3Ef+igbKYAPUwZxxaw1XWRMNohyjA8PdeocWt5cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Jan 2017, Junio C Hamano wrote:

> * js/difftool-builtin (2017-01-08) 4 commits
>  - t7800: run both builtin and scripted difftool, for now
>  - difftool: implement the functionality in the builtin
>  - difftool: add a skeleton for the upcoming builtin
>  - git_exec_path: avoid Coverity warning about unfree()d result
> 
>  Rewrite a scripted porcelain "git difftool" in C.
> 
>  What's the doneness of this topic?

There was only one bug report since the first iteration, and it has been
fixed as of v4.

The git_exec_path patch is a bit unrelated and should probably be split
out.

The "t7800: run both" patch should not be merged to `next` (or beyond).

I will prepare a proper v5 soon that replaces the t7800 patch by a patch
retiring the Perl script to contrib/.

Ciao,
Dscho
