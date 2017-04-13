Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F1F20960
	for <e@80x24.org>; Thu, 13 Apr 2017 12:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbdDMMH0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 08:07:26 -0400
Received: from mout.web.de ([217.72.192.78]:55169 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbdDMMHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 08:07:19 -0400
Received: from nack ([84.138.104.35]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddJY-1ci57D2gyy-00PLKP for
 <git@vger.kernel.org>; Thu, 13 Apr 2017 14:07:11 +0200
Content-Type:   text/plain; charset=US-ASCII;
        format=flowed   delsp=yes
Subject: gitk feature request: checkout any commit
To:     git@vger.kernel.org
Date:   Thu, 13 Apr 2017 14:05:43 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
From:   stef <no-wm@web.de>
Message-ID: <op.yymujtzglf264t@nack>
User-Agent: Opera Mail/12.16 (Linux)
X-Provags-ID: V03:K0:vdLIwSHv2t5G8Pd2ExozHd2I/9QOmbeijaegZZUs9NxpM4cPt2U
 nV8cJXgGDjDzTvJanU8NXOa8285y3KTLAVyKnABi+wtuQlv1ead+TkaxuREdxwJZXMKhsxF
 o4Uhv5XYDHPlOi026ZSG7MMp7riZXimyyAzbKyWZlYBC/+X/ccV0EfJsD8Bs5ZQ5O+tRCnF
 KwBD5ihoUp50C33+TrxZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oUmt4F5blhk=:QOE5ugg3e9+BIOH8UCW+xi
 DITqx045L0qILq57mFUQTwNHqzojBjjb85C4VEGUrB9dmWZZgiJGamMjl3YatLQN3h5QbPXds
 H3U6IdwepRM6ib74eDPfCCopTXugY8pNO5zXImLiv449yd1oW5OUjBAPEDD8p2oOFlm/loeMW
 ABv9Ie26njs3guL+TzFphf67KQe8gicp8+WgFLr3T6DPwv3xuCDdX0y6AhzavDNhtl9eyXLDR
 bwStQ/mXTR92iTmTcCNSrclTi+4FMQwhmaoqgdQ0PRIfFRNUrUtzioEuKKC9Ufc8HIpgpSB2Z
 9Bd5qZULCrCDG925vHUh/7i9Un5C52H093gDQY7EDFnaQOTJkGiLmrCjrK+oGowo2iWXqzCtW
 lPrnwFg64YlETQgwXr4MtOomxQPuZtUXvWw/88hOoFDnaX1mnmt37Hli7IFyIXdkcWVzyBxg3
 k3qE7WFkIVn3nZLVLzQBqqEWIHscv9H2qspRmo3jwOLv2ztkQwRB2hwoIrbyGGELFqpyhZ4W7
 cVEktVbd7q/E7dZtK+PTjnIo3C1lRlLBotfhniauD5f+uEWe8bYuA42cdgr/pOhztB5BbE70K
 EWZQ1HXMWyf0N6ocWHqIWmYTy1z2RczFk2ZrPQ6ASscoGIwJ2PlcD/UYG5Yxu5sff6geFFAEI
 Nfxugl7s+TDhdkAgj3Ne+BgLVXFcKeSy+cvcT71heXiMFOMN9wHOoNqdfGDG+Z3pyZZWNfa3V
 HARPIdm3VGiwI1ZxHjpgSOU+QUJbOahT9hkpAGaNexwz2pUS2mbK3RCfXIq4p1ktRQliaLYha
 3+QwPZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

it would be helpful, if gitk would allow checkouts not only for local  
branches but also for remote branches and any other commit.

For remote branches, it is sufficient to remove the code that greys out  
the context menu. The context menu for regular commits would need a new  
entry.

Of course, this can easily be done via command line - but that's true for  
every gitk feature :)

Another feature that would really suit gitk is the "Tools" menu from  
git-gui. A simple 1:1 copy would be fine ;)



-- 
regards,
stef
