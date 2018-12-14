Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40C220A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 10:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeLNKhN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 05:37:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:44159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeLNKhN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 05:37:13 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9NIY-1gjLAa1u1O-00Cjld; Fri, 14
 Dec 2018 11:37:06 +0100
Date:   Fri, 14 Dec 2018 11:36:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] worktree refs: fix case sensitivity for 'head'
In-Reply-To: <pull.100.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812141135250.43@tvgsbejvaqbjf.bet>
References: <pull.100.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/GMOGrK2oNzZEY5w3vDX9ZrIjfZ4PfPLD2SpmdIfKWBO0Vog9/I
 K3nrMYtJZn8y3P+6DR5JlnBysUTDvgFSKWrAXsBjgjqouXLzt7pVlQ92hUoft6HZj4OYzpi
 dFSwbjnakHm+xSDY1m1Yu+B9AhW1Xqw0/VfibAaY5Krh5HpnD4D3TnxAn3sFskr11pz5EGg
 eOHcdO5sbxwg/EM9/Rj2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MDAYtXhk0tM=:NRtJ2ZtnUXxWf11w1opodK
 NyNGYLOi2OySF9dMbgeau1B8qAACw8wE3IkGoOYzpSjS6XFC+Z4OE1s+VHbZd36WRsvJuydv9
 B1dlxJJRF2psdZDtSaixWH8FUeuYybwQkNS1n9Tfbha5zOb7lvu6MKn0rYOYZzZkl3jmwXVFo
 LRZMOWmBtn60NwN4sUxyQ5To7GLtn6sIar+WvNPcpwAsBWMnzxcFlOvs7SZ3w10xbg+3yvi91
 gzRVEJhajoIjWtvzS4zG429+Hqglchgavpic2Zz8C/wWH/43efhUHhKe8AZzTb1yc70QrU5is
 ggTdWD38ow9582/o2EC+w2qQcThEwtj8qzcn58bspfQv82uAuXpig1ab7cLGN6n67LdEp/eJd
 xW2TyY0KCsNB/IqndO+dLi4VJwJ1hE2K/tyfqwcWfyfiSOP9svj9rOOe3PvXEML6Wf633UTVa
 d7Ai1yinjTSTOOEVmTRpB+8Y2Lkp4wShQ1ESXRXods0h+7bW7aZy2gD9caG6/zhfUJNWimcWk
 YRIKeSUV6pkiKfUltdF4aF+LOeUkR/44NQ0sN+M47Au7hCaRFrountVS4PlSrfwyH/TLwltIh
 M5efT0W8Lzp0iY70x8QP3Hr4Viz2CoYXK6ySE8LSpnIO0JaIlC27jJi8of/MXuBCUQGHqOUNj
 dPfw+SPD8iIejIJHO1hZJnYGUv5skyzc0laLQg+A0pi0lbw9IhcpJE0WPI6BJqifwbWRwaRLB
 e5QBC/oNInQX3Lriw6U9ZXLms+VT0rNpRQQJ41r3f/Pnw3iGTVP7G7gfmkAMBYfKU+Tc1lMq+
 odTXFvDRqQDkOsNow+h6hzW9/d9knzvhIqxWBJ+6+nfXsd94RklzJtEvgtzF8nLxtX2YYA3A2
 GdQgvOond+x+mCdr1PcX+crkRrRpFCZxXvbrZfHcCSCI93a2tCu2AOC21wVh2HYT7MODQTN5Z
 NGLWyqmVMKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 13 Dec 2018, Michael Rappazzo via GitGitGadget wrote:

> Pull-Request: https://github.com/gitgitgadget/git/pull/100

What a nice thing that the 100th GitGitGadget Pull Request is celebrated
by a new GitGitGadget user.

Pleased,
Johannes
