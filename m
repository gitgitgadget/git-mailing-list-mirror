Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A47B20188
	for <e@80x24.org>; Sat, 13 May 2017 18:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbdEMSal (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 14:30:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:53767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbdEMSak (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 14:30:40 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgszY-1dMiol1CHA-00M12g; Sat, 13
 May 2017 20:30:35 +0200
Date:   Sat, 13 May 2017 20:30:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
In-Reply-To: <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705131251260.146734@virtualbox>
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de> <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-640590847-1494700235=:146734"
X-Provags-ID: V03:K0:lyQlJkaeJKOCFiS9nIyUy0iq/j++BIHwnyuOulIi1bATFMQ1xZZ
 lDQjfKW3Psg+3EOHuZt8Q6DBF8evYzT51szS5lVDcslkL8PWTJQ2whcgKDl2hh/jnC8ljm5
 hScERGm2yOSr/VPBQT9JEZMISvi8oDOghZbC9FUBpRCXbpAvk41/JsEPlcaS6LWLTzpeIVK
 gPvMD1mdw85deJFEST0AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hsvJ5FQ7Prc=:EU5u6tvh0mAB4kz+l1zt+b
 kb3wlI8tSCBm0aCbLNUiDk+hTArzg7K3TZf1/Ml7Kr1p9TrnNiN/sFYRA5bk08G6j2oDLlMmG
 oSOA3q6vc0fRPoYEndOL/dtgXFkuuGfyiBXxgxEuHWe3PtUyNexLRFa2TA+VbTmJAJVXRI8eL
 6CbgOpntyDVktJF58gGtWfo8ACl/ugVKsnH0DjGKhUJqOzxxiDiN3yaEpnFl+6rrFCHzvKsle
 yeh5sBdNl9oHV65TryzO0LjiNIhOaZQWntf2HlSg93YGIPnyeaMLJieIPUUlCpLbD+4KxC6HZ
 fLoRya7PK8OVvZ6gYA+OKYRYJgZCKJxdaVfyihwF8+9SrelOaxfjeyHusCeiguUo16VaFTSdc
 xGGT3TFKq9Bx9p6pUh/FMRAeHXMfrS+9Pj36Cl9BxfD+lPuQdXCdOHbBKpbMfs2M8M2ABuD2G
 zPr0Rmn2PExauJxv0DwnLyb+ICaO4/Cz+prGO1y1hXBoWIENAFS31mI6qhqgHnsWG7k6vx242
 gbT6ibHTnY2FDkesvIMdAeno4/Zo64n9oQOoLMOSH8pVutln1KkPq3umtDxucPGQnLMBjiXxd
 /fE0hBbuuGWzv4ozwoURrXoFQrLOcNzs/iCNyzGWxE1gjYO6HckB1MTCzCXV2wDezVQNxav8m
 JaluMj8zx3bjHZFsD4uWC51LGtj19kDTJvTIY0lmAzFh7ECT5HL4KshiZFlLdIH6Fk6H4SxXI
 HF+LQ1JW/0eooKktaFfLgfQ4PPcAKqDgdmkvCvsQzZzp43RayO58XybReqIRB23YSTerH+l0j
 5xska3m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-640590847-1494700235=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

I originally replied in a very verbose manner, going step by step through
the "one-liner", but decided to rephrase everything.

So here goes.

On Sat, 13 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Let's drop this current gawk import series.

Well, the reason why you imported the current gawk regex is that we (you?)
decided originally that it'd be easier to go with that one rather than
with the gnulib one (which they friendly-forked). If you switch to gnulib,
I would like to see (in the commit message) the original reason we picked
gawk (which forked gnulib's regex code, after all), and why that reason no
longer applies.

I also would strongly prefer a *non* one-liner, in a commit message that
adds the relevant source code from gawk or gnulib *verbatim*, followed by
patches that adjust the code to Git's needs. That way, a future update can
repeat the commands outlined in the first commit message and then
cherry-pick the subsequent patches.

And remember that you do not need to clone the entire repository. You can
1) fetch into the current one, and 2) use a shallow fetch. Example:

=09git fetch --depth 1 http://git.savannah.gnu.org/r/gawk.git \
=09=09gawk-4.1.4

The next commands could be something like

=09git read-tree --prefix=3Dcompat/regex/ FETCH_HEAD:
=09git clean -dfx -- compat/regex/

Oh, and please do not use `master`. If Git is any indication, a tagged
release will most often be a bit more robust than any in-between commit.

Thanks,
Dscho
--8323329-640590847-1494700235=:146734--
