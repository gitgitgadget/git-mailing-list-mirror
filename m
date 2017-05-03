Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1543A1F829
	for <e@80x24.org>; Wed,  3 May 2017 15:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbdECPdS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:33:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:59011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbdECPdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:33:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmfKJ-1dfHIF3erb-00aAOu; Wed, 03
 May 2017 17:33:08 +0200
Date:   Wed, 3 May 2017 17:33:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 21/21] t1308: add a test case on open a config
 directory
In-Reply-To: <20170503101706.9223-22-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031730040.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-22-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-806365019-1493825588=:3480"
X-Provags-ID: V03:K0:folsfk/UmgF3yB7tNZpkD+gocQCM31ji8p3aKBmNRhFdCMHorMW
 Zm9FvFAE92CDC7gi2pqxZRAUKT+42MAUbNud1b3LhG1TmQgVsmnoFAmL0HCua/RvdYkl2V3
 6PnBOGVdUGp3uaXZJcpU2HhIpc1Yb7XwlGJo0C9KefonS4z8300m8N13uaNUS1Bdn1Ewli4
 DGd662sFZFKwU7TsTrGMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/0jfSfZhiJ4=:OCeQ4k5eE6hm5ew+IF8UT5
 ECAylF7PlyFBdcIuyPt94ytzgTgKlGbNAlzfD36c/mvUQJxwdyxU6u7YQWQvQLIlGPD/y6oaW
 OBn42OQProKzUD1uX5iCyxeCkBZnw1LCTMzQBB5PPbHx2E72V4cK5hd3RvfeW+INklHJsXOBi
 SFGf7Lm8LC7n8iNETNtCU41SIwJzxWVFxHK51ptNddoJHl4Uuix2qSrhIRXilkpH25BxqZPJ+
 9Nx9mK3NRG2R5OkCvOD6i1GU2LIjFZakNE3YjmcIr2N4ny3tw3PFeArfKUY0vdUjXAgemjxDV
 P2lCjJAd2k2JwoYYJlIT45mOnqZijvgTVtvxKEgtdbAmQapyolwDvYvVq0snDYBPqf8qkQLBn
 EyRDJnny+DAeoiYHjPKXmZ6mxQB2Sz3Io64SNkWrcU/+K8wQxC64k71vsiVypAnah4w0FnvF5
 bS1eNjk8KO2/wFS12TL84PuspcyqyVHF+SKYbh3hoT9avrTsKW7EeMsY5t42ipVbjFYpBIFdH
 Ml6zLPVhT6uocvoV2Ihu3+1RFsMxb9vEBTu4Ge5btb82N54nm0duObrAt81ZrFaQtzdDoPbYG
 FnvoEfzereA9d97+Y6MOT8E6lT5FvwEIwwJ3zsHtLAGJnbea/YQP70S1IO7+/srvjabAXmyV1
 nE+Mm6ejydPy281sO0O4F187A/9LNOWazj/Mpid9o0m1CFkhUw0kP1vz7EQwjZzVTqDPfcJ0f
 AkZd6nsvhHPbGh9jszVgeSp6PVMnYa8hvpQZ+VbfB6KJ9mQlBe1qwu2nQWhSr2woviyL1e1bR
 zaFL/og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-806365019-1493825588=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> We don't support config-as-a-directory (maybe someday we will?). Make
> sure we consistently fail in this case, which should happen on platforms
> where fopen(<directory>) returns non-NULL if FREAD_READS_DIRECTORIES is
> defined.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

How about saying that we make sure that this is the case by adding a test
case? Otherwise the reader might (and this reader certainly did) expect a
code change in a .c file.

I reviewed this patch series, and am happy with the overall diff.

My main problem: it should be organized in a more intuitively-graspable
way, i.e. put all the fopen() -> fopen_or_warn() changes into a single
patch, separate out changes (drive-by test fixing for Windows and, ahem,
whitespace changes) into their own commits. Then those commits should be
ordered to relate an easy-flowing story.

Other than that: well done,
Dscho
--8323329-806365019-1493825588=:3480--
