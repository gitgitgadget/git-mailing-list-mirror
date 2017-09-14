Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8752820A21
	for <e@80x24.org>; Thu, 14 Sep 2017 22:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbdINWVS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 18:21:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:56299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdINWVR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 18:21:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MY86C-1dx8k21eWO-00UttP; Fri, 15
 Sep 2017 00:21:02 +0200
Date:   Fri, 15 Sep 2017 00:21:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/2] test-lib: group system specific FIFO tests by
 system
In-Reply-To: <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
Message-ID: <alpine.DEB.2.21.1.1709150020070.219280@virtualbox>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox> <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f8FSYo5ZMFgsAJKNADxKpQD4qFFXFJjuhxlt6FRqp5jRDZ9sK2O
 9DvxVnzY0i+lCbRP5P7oij4wJsU94B/6PrLjc9cvgjL3ci7z9iOScyq59NYaz/DQzniNijh
 D0yG+tmm6gNmzjwObjMgQpnVq0i/tHj4wqgpzVcL6UXV+kZf+hHKZZVgnuKZgEO6SrOZwMf
 Kr6Z9RVZrJUIZN1OCE6xA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mAOqan4I5D4=:6lQYpThoL761ahD8072SeA
 +xDp8HSpAPujxeKgwJ+LjZYwaeTwoUQbHJCm+R6pZp+7ozOTfdHE1RHv/w0+XvOSxwXwpyXiw
 jouBqLSqLxWm8dPUWtlQ0sSVsWp3rQsLWxEotvdAARS3CaqXgNEnl1DiXPYztiumuavSSg7Lf
 gxBIM3tPf9qIUNZMikf78b1v8PIHQE3fGO7/9ed1/xb3TqtDZMTddrQbziL3luNBiDF5JSo8+
 HshPIzqdpgEzMsJz6wU850S209joqybNl/hOrzWU7y3YxTmNa/ulpD4CRorzIHzpT9sPcZ1s2
 NzWD9tN7QMb6xSJ4rpp37tY3N4q093ADdViETD5e7Q1ARnA1dypWxXTwN0g7DGnJXKN4gFKb2
 voiuB6Rpl9wB56fh7FHFVgp+ALx1oNQ+OTFTp2o7oSeDr/PLcLplXo9mS+F4OBHas8N9MupF5
 d/fK+HmnIOCXEEQ3nvbRFN2uKOj0dysi74LNlkgXoiWLDd4YLphuAZpkrK/sch1nTBCNInGPC
 Qcc4e6TfBR4ut7dsQSfbx6buDxx36jd6LQryPG+lPi1SuvaHS63bnJoFEiwCDq+W/pp0Xjx2b
 NLQYVOjt4stRBrZhbLssuTeTp1S6E6+pevf/68T8wS6Ja+WLC2l5f0W1PZe4t7IGIqropiOt2
 y+xvGxqsqoNVwwABYWW6o0KHHQF4ekcAnpmlWwCfK99zbznj5QH8N4ROB0HptLC6wdjNuUF/E
 RCFImxfbHCiQHvss0sjnbu81tzaO6IQMtraO9keClfkGBi40Zrb2rP4YB/u9WBIsPr+vDkiQm
 D5YjwRY03RRwLKM2tuRjbjcT3RBFEepK+U30RBtC9/W1WbZEds=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 14 Sep 2017, Michael J Gruber wrote:

> test-lib determines whether a file-system supports FIFOs and needs to do
> special casing for CYGWIN and MINGW. This separates those system
> specific settings from those at more central place.
> 
> Set mkfifo()  to false in the central system specific place so that the
> same test works everywhere.

The mkfifo() emulation of Cygwin seems to work, no? I think it works even
in MSYS2, but not in MINGW.

So maybe this patch should affect only the MINGW arm?

Ciao,
Dscho
