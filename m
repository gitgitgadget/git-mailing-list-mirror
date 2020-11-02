Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5596C388F2
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5755D223BF
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 12:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="anii3IQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgKBM2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:28:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:33161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgKBM2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 07:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604320107;
        bh=CT48o4g+h/h4B7XfgIRHa6/Y59XH0wnhUkGG5F7JQDU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=anii3IQO0b/QWMBNriqkST9eMrV6YdccxMt3Md7zNSa5ktibXUivQuPqwQ+T16WY4
         0OnAUfhvdnYnsKzuTf75A4Zphpa+DbFp6hhE4RiVbiai47B/NESdYeAhSUa/CdUH2I
         7XG344sl/EdOELUjkbR7ZlHtLPtsxILqFJ8H6ZjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1kBy9u2vfJ-00wnmK; Mon, 02
 Nov 2020 13:28:27 +0100
Date:   Mon, 2 Nov 2020 02:50:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jk/committer-date-is-author-date-fix-simplify, was Re: What's cooking
 in git.git (Oct 2020, #04; Tue, 27)
In-Reply-To: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011020250170.18437@tvgsbejvaqbjf.bet>
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hiFL8Ru8rpCL1h2bRhIRM5uOVYUuhSqt611MD1FLJSS02H9uROn
 ozHNssCSAyLT9dd2XNysgbWtIxUHXEpTGDqisSt/CYWDDtp9J0yG48Apyuyr4Xm5D8LYSxn
 4els7R7gUvO9/Y/G9Iyxng5wMDRdp3AeaH59kCqzYzAkyPDMxagn1H61q30DGR7KwizoDMC
 yTiaso0a4evK6ZBgwTm0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jXuXPgbaTX0=:bqPEilFRAF7kpnNOZo4jvr
 fYHdM83On1kxPktnQVJ1JOUea3217jD7WTL7hzv/0kwbapLIex4t7T/l/RAuBUcH3IOBnoOBU
 AUWMFK99kEWSRYf7Tj7zWI6sWMbUrRXNSrj+Xbz5xL9QvqhENPWYD53V9aRtlHc1QZm80DtUo
 CaB/64LeznYfZqigh5EO1o0l2SCq31Y8QcoXC599/DvsD/zTrVgqyrENKYRtTp1cNQsQCU5zc
 nNoVy5TauWVII58JL7t9Myx5o1ff9ghOvgSZVFXpK8X2r/c4awDfSwxchsvG0h0hUzkNLIqJ4
 fAf6LVQzuiH2u/0cYuRgorZf864jcdTguzXQJbnS6ot/HNMKzpnGq/xfbObcaEe9dnBjfvGXd
 clELnqKwSfWuylkI70EXSxZlZ+PoNEszbu9fdis+cwlQ9lfeCKhUlqnvlCnfClzmd8bXfws5U
 vccAkatnIf2YLjoZG2KwJkxsP9BZsYXw2Fnz7218g00zcSwnT//yTvPd5Wm02iuBe7AYd+Uir
 V0yEmxlmvwvhMdxX/U/bMl9OLffLhIgSkaby17PGoXoBUMabU8UFcRAANwIFyELmx7JK8RCvW
 PFfY1OxfZ1kBFHhcqyPMVLqHj7pn+kcgIuZP1IOIj4QYVTGTDDlpx2pq/FDUAsRZpcid7WPek
 nlpr2sTiQab9Kn5H8kjrWTZEAhIo1actDsElddl7F/zVHXFxKQX5pcbgy1QghlDL1ShVnaiMh
 tuPzQZkNT2z8iM747B6/pyF6l3D26ySYrRn/cI9BGP/ZYNhTAKlWPM/7ltHZ9RB44lAKPYUVX
 o7igufEIUUmaVSooSPOqvUg2g98cYAmvwvN4oVMMpDMOZigTxBgk/w9cf38xfzYycXnwtC43p
 oZwLFj7rRo+aYdwIl+PjLT8OTO+pZhOwpVW+kHW3U=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Oct 2020, Junio C Hamano wrote:

> * jk/committer-date-is-author-date-fix-simplify (2020-10-26) 1 commit
>  - am, sequencer: stop parsing our own committer ident
>
>  Code symplification.

s/y/i/ ;-)

Ciao,
Dscho
