Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9D21FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 08:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbcIDIBm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 04:01:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:52779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbcIDIBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 04:01:41 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M6zvN-1aueoR0IhZ-00wjtX; Sun, 04 Sep 2016 10:01:38
 +0200
Date:   Sun, 4 Sep 2016 10:01:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Beau Martinez <beau@beaumartinez.com>
cc:     git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_git_add_-p=E2=80=94splitting_hunks=2C_limit_is_too_large?=
In-Reply-To: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609041000420.129229@virtualbox>
References: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DykLP7be34ogJ0R+cJJoCYidYmVPDraxq0w2WeyfI4cPLgK2Ge4
 G15B/QXVWpw8mKTgb3T8jQ3A2He4odMbNONEJ9Z14rrpBgBdI+tvylgsFenS1RmqoY30/xn
 NBvgs7JKjpNvIWhSsDjqt11AZWDbX6VcJXP1HCcNxOs/hamMnIktTegfNOwKqs/XwSTpNum
 L2jN6vWmycMsLHFJ2BjgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TopTLQjz57w=:Xcu2eDANeeEmjWdV+Wq7vQ
 oA+O0e2tcNTukUkajD0ZMa/6tLe2g//fB7KrtjCA2uAK3tj1CCBJYAZGjerobstEcCld8dF9i
 pldL44NUGzgiZrKepQbNLBUwxlxz7aciyVqw3Tc6jJ8IMBpJ3ewQ/sS02ozay+U04nNHxh0ik
 zzY5CoNQp/6Vc7X3E9jzeZ9amhoVwCL9tyoGheRlvPd6pasTU9kb3oQxWMIQDe7hd0SRawJUo
 +DLGdZ4WZ49JeVFPMn3e2XQMws3GT4YL15g5x4KQreIk2dsz5fYdlmROsYgr0WT+n4olF5D6g
 EkB9vZZwO114qWxvBPPCCAxeA1F6Pl5IO06P5cWhSzL6PHFtSkjkBMRcELpymnigkGNeVlQ4u
 1ZJkM295JgEBPjXzgEP/H71jwkD8ypDzs2z+DVBtpGy269j726tOk8FBJ/UfBsXEhiJkO0kgx
 8Uz+1jwtAgZzVcifsaFut4PVspBtLdTyo3KxJ/p4VVFteKwi4xuVSQcgwKM9KefRPBRszAQO/
 Yoidit8zn9/GNJuUIBr+UuwyiNJTz0NKwHP/tUWNbXvRqj4k5CItPJsG5ExjREFverOIQPxsJ
 LHftf/cl5S8Im7fxX7UDQnzVNQehExCEsA00DUdbtdHO4UVsSxC1GAj8xt5aA1AkFjuemwOzI
 lVxD8TKdw29PDUdfh6XWRvm+X+Vzd7R1Y17lcKABlEe63AJ1lTJ06Zu2+bQssvsKRXaMnoLIu
 0zJs9WUX2FthAG/NkDnXcXTwGEa1O+DbfdxmuAkOa8cz6f15ZvVKDO+pVb0Njnlw+f8dZ798B
 SO6XQq2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beau,

On Fri, 2 Sep 2016, Beau Martinez wrote:

> Hi git developers and community,
> 
> I'd like to inquire as to why `git add -p` can only split hunks so
> much. The limit is too large; why can't you split until each hunk is
> only a line? I often have to run `edit` and split them manually
> myself.

Please note that git gui lets you stage lines individually.

Ciao,
Johannes
