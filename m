Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B9C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CFC208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cXF9Ggqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGTLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:11:43 -0400
Received: from mout.web.de ([212.227.15.3]:49535 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEGTLn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588878701;
        bh=n3gi7WY4PyGhw0lxFof9cMT9TeGDqduhYdOgzv6Ks80=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cXF9GgqrFAoKX2VsO/2+5f052D5gnI+5iEaL1DP66PVyHq44ghTqDEGSO1oEO5wIP
         lbxUwy7yKjaWSXPGPtU9mIo7yCnR8kkNvSDtyq1No7V+ibjwapKmk6Re2u13uk7I3i
         /O7nlzuBvKwbj2OiXcDYbmqZRIAKz6RuKTylzmvE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCoku-1jO0UP2Brk-008spE; Thu, 07
 May 2020 21:11:41 +0200
Date:   Thu, 7 May 2020 21:11:41 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: chmod: missing operand =?utf-8?Q?after?=
 =?utf-8?B?IOKAmGErcnd44oCZ?=
Message-ID: <20200507191140.rm5dynfgbxgutiz5@tb-raspi4>
References: <CAH8yC8nAsF7HT__AhsRk08wpa_Bjsc6RXoZuomVbM1CWeG8QeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8nAsF7HT__AhsRk08wpa_Bjsc6RXoZuomVbM1CWeG8QeA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:aHS4ptjuW2Up0hcBKH4Di/4InaFaJEal2OiGPad5yFzwZSWGFF/
 VjURfQkLAZ+KJObznuwW6Bs1MUwjiU8ZV+Rz/B+RwZccnU93JHb/c9m0fZivNDr9DPptBBh
 K73l0m0Y/AnTuO2umMgfI8RpBeLqd+B7WfR7Tzi5aoMWYi5/Lxooi+jvIMGKuxVOEIchTh2
 Dnix19VS537wBkaH5nBJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ztscUBcaxkM=:2wz8G89UFnaQ4GAkM3VTLm
 qm72cjrSI47mHStn63MAy0GNb0MlwVBhdNiDxHsgsO4/fbNIiTYwXoTPvCmOyhfIv4JjRBLEu
 mErPKXqn7a9E4FQVrQ4a+TmLU72BYRxYxHtuwoMOOoPfKHEomFUc9z7h/XoR9XoyWK5IPLJrD
 v7ndHH9vLse/R2AHjrSNPUsMVo01QKUscGNI2wmluJBeFivnzwxBHrUx/ncrw7SFjPoXNMWSj
 TdWgkRI+5Njkphdav8QVD9n47w4Mufu4Hrnb0F4Rs6D0y9WX0vGQPONSAl2BUfs4uSG9SyBSv
 hFWERQAHzp2SInZKhNsn4SAszR3+Rz77p9sVfphYSHwqDf24ZvTNJPvyUOM4eF+Z6EB2fI9jK
 UkEUD5b24H9D9xfXnGNAM+ySgjlz199imRLQsrlPZnxF18289PEjoSHxgwiuXBkE6CYojXMCg
 K0dpIqp/0wOdC5D0y/HFU+LIjvwLnmg091Z5HVFZDtdz/Tn2vCVrchheDVEqSb90KbhmphTtA
 SMdvX8ByEJ5gpXskG9vB5GFPnLYqps8bq1clZX3i7vzqE1Dqk0OZ2nDf9MA1DlKvlAYJ3ELgS
 7azqgQsm6vzCQUZ4hxc+pvCfqWrTKebMlLgCNnXBCuxvlFc9ebSi0IbdfBWMeg/caTKh8aW7Q
 +H2nGM3pxd3dowLYHPR/Ow/pBRuUg8vZyG4qYy1KiyPT5WTeE49/sOspGxrnbPzI/pz8HEVyY
 i1diFtkEfJ5n94Zb4O2rPQR3bSYx8lxCbDXnpgbHcN4KVLUeMYULnQIz9rMLvS50QlqgldxbY
 /R5jan1kRMeTH4xkryctDIOtyXfRenhDdK0+sxv3ZoO0yiJ/PMfc/z0A2oJy/RcdHIBsYB+l7
 8lw9qbrw8WKryJ2qBRwSbm1UyIejajUWPnDJRPjcydWhG6T8XW+9wOpB6csOe+L7uq62SFL9o
 Lhd6Sj0aqBCTuhVNr3S5i0x8bQGC+CL8HSW55Gqy8jQ0ec0+W2niNcH3sK+m+9zDPK75hY9ur
 bUWb9AhmEtZS46DRY327dwgHYEr2tKwUAJPZpyIJh8p7D2ehbDkcl0t8WHO8lkJ61GEyuh98R
 nVrueiQc0HFGYbu3nZD0QAKL4G2kd4ZRlhA4KOtbBgLmYmIkECd0ccB2fxLF91+dYjUy0Y5Ch
 VNN1lRKkCpEfVdGz6cIpZhaw6NkbZo1CbgHNPpBxQjz6Fg4muLOMOmq2xw2UppJiPciST3jBR
 Bp+u0+X82AbobCnOT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 10:03:01PM -0400, Jeffrey Walton wrote:
> Hi Everyone,
>
> Git 2.26.2 passes its self tests on OS X using libiconv-utf8mac.

I think this sounds like good news; what is libiconv-utf8mac ?
Something you compiled ?
Anything you want to share with us ?

