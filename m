Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5586C20756
	for <e@80x24.org>; Mon, 16 Jan 2017 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdAPKpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 05:45:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:62505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdAPKpm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 05:45:42 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1cLwzI19jS-008GDY; Mon, 16
 Jan 2017 11:45:26 +0100
Date:   Mon, 16 Jan 2017 11:45:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's
 backend
In-Reply-To: <xmqqinpgdass.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701161129240.3469@virtualbox>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de> <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701141904390.3469@virtualbox> <xmqqinpgdass.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CLRu4jM4NisBvPoTL0AArl+R1oj1Rg8WDW8IT1zuyTY74Gl+vC+
 Kg4ln/vYDRvr0iGGl/S9CycuxjpAHR3vgpNAGSaZsger/1Bpu4gsWeaf5rK2bEelW8mf318
 VavK+ECeU/yX7wyAgEz1t9wbO9+Z+yetbYLhzo7jyBX6QUxjlF0hLgzkeIXUzmvfUCjBrWK
 Y4wN020a2UI5zVLjz43Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6MsMl5ql+Mo=:GDfYNp95xaU3cw1yK2t4gW
 Q2BzGRWzMc9cQ/LVJPxAMiX5zYnhC7tYH3Vrkl6nGCW6gCJVPZty4Uy+1U8UuXIp2Hd/n1vDe
 iH7Kf6y8YlMUCdHLJjSq7i+QhqpFQiZ8d5/Z66lUyeBIo32f6M8xHugB38iXWoqxdRTq5IyxJ
 UGhiVYML6c5OYqUzUA3gUVFoM0wVbqxN38GvgG8qW5isImNKvLfm9TFpz0hpEBWZZuH6zc98e
 cTlfc5blwouVo8gFkNYHOeMzCRR76gkHSoSkRlGOph4ZQwxPInEHsEnQEJKuwn+M2OmYIssVx
 RCfyjmE0wpTyfjwiTWk0mNttpOxM8QCH0sArp/ZorbHbSgGVeljEptfBrbmJgOIB0ZPHa1MMT
 sZQ6s7vrlxXXXIpwmhUwEqSQ+1T0ud2kAO/9J+JFEs2GVFpKCvJSbyo7Zw+ND6Hl6elWo4X4h
 ZICh5oWuaBouxRMKtYLICiTbc9pyVgC7X4Ajpry3pK+oMQOuh1zfWXKaYHe81eRNInNq9/G7W
 Zy3+sqHBuuIV66nJMQBtC9fxT7LuYmMfAVKMWocZ6JSz1qUs3vNvVUCv2aKUlDfJbJwE0NuAD
 5H2QKnAE+Vh1Zvnx3BMkKeXF5RC16aq3sST+8MVBmw7Zqvy2stP1zCMwi9u/ciC8F8xw0Ih00
 oArfz7NwwDeydYp4CbPOpUSQBpLKwICTsY5z8C7/zdIFZ7TbNMG5Gpd/vySsreJLVEGidhNdj
 Q6drkDHjikrFwsGAIeRzN4tpMtrift8o8vM0j7SUx5MgZOjY8NpFZRylb9nnHgfBLdMnGQBo6
 zdUl9Xh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 14 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > You stated elsewhere that converting a script into a builtin should focus
> > on a faithful conversion.
> >
> > The original code is:
> >
> > 	. "$author_script"
> 
> [...]
>
> If the code in the sequencer.c reads things other than the three
> variables we ourselves set, and make them into environment variables
> and propagate to subprocesses (hooks and editors), it would be a
> bug.  The original did not intend to do that (the dot-sourcing is
> overly loose than reading three known variables and nothing else,
> but is OK because we do not support the case where end users muck
> with the file).  Also, writing FOO=BAR alone (not "export FOO=BAR"
> or "FOO=BAR; export FOO") to the file wouldn't have exported FOO to
> subprocesses anyway.

That analysis cannot be completely correct, as the GIT_AUTHOR_* variables
*are* used by the `git commit` subprocess.

In any case, it is clear that we (I include all reviewers here) messed
this patch series up quite a bit. Hence I will be more careful from now on
to only act on suggestions that do, in fact, improve the patch series from
my point of view.

Ciao,
Johannes
