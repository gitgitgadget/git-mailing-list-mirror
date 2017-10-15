Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B8520372
	for <e@80x24.org>; Sun, 15 Oct 2017 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbdJOPZN (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 11:25:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:65424 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbdJOPZM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 11:25:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08eS-1dGJOn2pCe-00uIzt; Sun, 15
 Oct 2017 17:25:05 +0200
Date:   Sun, 15 Oct 2017 17:24:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: unify error messages
In-Reply-To: <20171013175157.13634-1-ralf.thielow@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710151724200.40514@virtualbox>
References: <20171013175157.13634-1-ralf.thielow@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1043220010-1508081105=:40514"
X-Provags-ID: V03:K0:mEIZBj4TZro2stw706rTawIgnFP4hUEGemr1WqEDNbY92mYIkUu
 pTFCiENVJUYbVrcVW4x9HvQs7YC0tyI7IpRiVAEvRQFJrk0YILv1nXNAdQLYSd7SUBuVsAV
 h0l4UDxPVKHLrZQmnNZB5Mtwt9zZVg7r9RUdBwdSs+2ufdYMTRSdSY98yV7BnyXk1G9MPdS
 9We0uXiLqY+gxomt2Ql0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:94sZZdkCsNg=:VRz+HPopq2WJXZUnnSKQub
 EdJzWPxiSWUatSG8JaD/OQTvjsOU4u+vUb0g2j9iVLwiCwPQaq/ejRLk3r5XGCzkG+VGgvzyc
 pESBDKad0IjP7P8ZRjTVs/NBKGqAMuf5IwRKawxi9Z/sU8kD4/xp8X7FpFBnJ/MbeAGEdCrs6
 gJd7hyiID05j6tE9Gqki9Tff1LHyCqLzHeRtwhdl/CGRZ4bfw/jfQWWca4WmgIIsg0rkSMfSC
 qCJOC3sxFnUq5MXYvcWg9W0UEqUZNUqoScrVcYaSvf8u+WROgvoLUUQkvcCj4J6i3TWQCHZez
 tMZUGS7kyxezjMSvZBotNpzoYYMBIdtIm+oiZ9xMT4oAPbYoueHQa3uFj7a+U3QvgxvnObQ19
 /2GajMAgvsxMHuMAua9ae/0PH8afWnRCpOXT5hybF2kWIwSq490l+Fwv7o6MnZxVxXh//dThz
 /3dRh4+ItaazlsPU65nxMVWlp2T9inIK0ZmSun5sFgZRfFVnrBL0Cyayak9o1h98rRertv7Ma
 jiMEj/BLwRfR/gyQARfagXVpLH7Tj7p3w8nGfAUXAcB0srO8T+X1AvxPEgOkSEg6si+mybvCU
 20/sK++tqeMvvx6KtkqIzNsC2UhmvIKrtNpO0R7QbFbXhqId8T25d0njhgHFlhVb0EJ/Bkwe7
 ApIQVl2CfvZBvkdRvl3jrhqh+UO/x8Gvvhx0ZHyft/trx/H+86xCZW54Vmucjz4HRO+BEkMrW
 NdAh0xghNSYGuyscGSY3JZfiSsOV6tEa6vD7izTErE/BLRxIMz831t2869jYb0mGTGZ/ujGlL
 AGMLoVgL+2giODvfyR8GlQw/ptvz1GoPfwXTmYEkR8IqRWxvEs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1043220010-1508081105=:40514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ralf,

On Fri, 13 Oct 2017, Ralf Thielow wrote:

> When ftruncate() in rearrange_squash() fails, we write
> that we couldn't finish the operation on the todo file.
> It is more accurate to write that we couldn't truncate
> as we do in other calls of ftruncate().
>=20
> While at there, remove a full stop in another error message.

Thanks, looks good (maybe s/read/write/ as pointed out by Ren=C3=A9, though=
?).

Ciao,
Dscho
--8323329-1043220010-1508081105=:40514--
