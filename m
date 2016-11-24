Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191B11FBB0
	for <e@80x24.org>; Thu, 24 Nov 2016 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933490AbcKXKiP (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 05:38:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:55194 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757089AbcKXKiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 05:38:14 -0500
Received: from virtualbox ([95.208.59.199]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfW5D-1cOwG30mEt-00P5vd; Thu, 24
 Nov 2016 11:38:08 +0100
Date:   Thu, 24 Nov 2016 11:38:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 1/1] difftool: add the builtin
In-Reply-To: <xmqqshqhlthu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611241123340.117539@virtualbox>
References: <cover.1479834051.git.johannes.schindelin@gmx.de> <cover.1479938494.git.johannes.schindelin@gmx.de> <3e9a2f31c779476c7524849a2e5307f2d3396fe8.1479938494.git.johannes.schindelin@gmx.de> <xmqqwpftltq9.fsf@gitster.mtv.corp.google.com>
 <xmqqshqhlthu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:obAAPmq4sayI3+FNyD6BDFDvHcrQQLxI/9z+QPWRohSy8AUsb+1
 1PEFJFLrYWBWSi3n6SEKWTDN4eBUuE1XfTWMrgjsOTZy4AXsH/Y3Anbh0+8GEDuKUN+R1wh
 f2p6LAyQ09PDuF51C7MlrXyHeDkSAzu1mOVhGIXavwAuemdb9cv1S8O0tepEvbeRTeYAaEk
 eK+IpXAFooKdxaz/sBeWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dv0FDmGbUUA=:Qt0952N0Be+jkaIeJQBfXU
 TQRzBAoal4/pkBP3/YHe1PlClK0usLbwBUVa2HNa4YBUHM6zA4bTYcFbbTzb8Mc1OaluBFN8z
 1am9PCCAD62uB1Ak68r6/ALg1RQbjiaXzr9O94gialc+4tNSvuBpm3xgAWc6NgDdwUCntaYxt
 tmVmWJ2yldWlmY484BI8mkJ3lGyRxvpUL/X3bGqRaEWdGCGJiu8sJv+6NTyK0Qt/c/RGohfY4
 Ci1RzVQJ3MuYh1Ux0qR4gEloo5Qw+ZBWsHk/avzrXglNwNW0jhFJFZqctuRX4XtahQo1EJUos
 bcsNCTOtDNymgnRrmKCrJZmb9aGK2J8i9Bt135V9RrLZa2pm3Vgke1tBRufki14v2uYbqJBUC
 Di+/tNjOvDs/50xRp/m0PxCjcR63OVsZsHp+egOl2MCjEpWXilDp+aET30aCVKy17mNZ1UuZU
 9n5sjp4quj28FZ8fTLYtOF9uuuJUWwjgBougIDF6wZNqbZhlO+SgTxk9uR7Q5BouXg3MUca4P
 J6p6xqd/mnpAJYiFR7z90HlDQ7N9lXm0yATyDufsDdk27lWSfgCo7Y/sD28a5ssZDQDn3FkkA
 LVT5SEPDL/J9w9WhvTmXcUdNfAuKEbBzpjXpBjBwp5X+L52mYc+sbv/cqvukqLgD7k9RmfBwN
 orEwwQ1n0w8XTfFRHNd77DQJ0GOgd6JhFiCrNFcvO/VYtC/Oih5jCUoqFPkVs8iEWC1V9ySIi
 OjMmiXP88J/2gY8Ge3DZrj/ttaaWezmwOwPRk/wbfxRHGQ53BU3rblNlOu/kV+j4h1JUntlaj
 efIHdLI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Nov 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ... I do not think you can safely add these two bits here until the
> > migration completes.
> 
> I accidentally removed a more useful bit I wrote after the above
> sentence while editing.
> 
> The NEEDSWORK comment in 73c2779f42 ("builtin-am: implement skeletal
> builtin am", 2015-08-04) mentions why it calls setup-git-directory
> and setup-work-tree instead of letting run_builtin() do so; perhaps
> you can do something similar here to fix this.

This is the Catch-22 I mentioned a couple times: if you insist on a config
setting, the config has to be read. For that to work,
setup_git_directory() has to be called.

So no matter what you do, if you want to have conditional code that
depends on the config, and that wants setup_git_directory() *not* to be
called before, you are simply out of luck.

Sadly, I now bought into your comment that using a file in exec-path as a
feature flag is a bad thing, and that we have to use a config setting. So
now I have to spend more time on fixing something that was not a problem
in my original patches.

However, this exchange has something else in it, apart from creating
unneeded work for me.

What you really accidentally did was to identify a fundamental problem
with the builtin difftool: when called from a subdirectory, the RUN_SETUP
flag would make it chdir() to the top-level directory, and the
subsequently spawned Git processes would get the wrong idea about relative
paths.

Thank you for that,
Dscho
