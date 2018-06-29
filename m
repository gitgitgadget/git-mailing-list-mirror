Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B331F516
	for <e@80x24.org>; Fri, 29 Jun 2018 02:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030334AbeF2CK4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 22:10:56 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:53445 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030327AbeF2CKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 22:10:55 -0400
Received: by mail-vk0-f74.google.com with SMTP id x138-v6so2817062vkd.20
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=1DK0UF/kL82QrvYABqU/VoJiKaE1Dt6FgsB7/yAupGI=;
        b=YC8H9xD1wRgs2K9Znc/ingZMPUCI5kU3hx+yY5TGY6p0oMs3r+MHYFRlXENN6XiiDM
         m7kwjt8JE7LuvFGG1s0PMtNN4+iqES1yoTsM/YV0KZh9XtkkJhi79edXZMemoYQMNACM
         OZWpAmlgqjDJYKFow8I+goW3lJ6Vn+Ie/lqYgi5ZBu2jCQ9ORM8stuk/R0racQwnm2fE
         Ub5ALavHEOYYaEi9iT04zNT9OCuJPob8x6Y+wzUnSqrhPl0VOi62hLjwmNi+/jNYoSQe
         xwtlzdT3VhY1aMu2+Se18iEQkTmFXbIar/ZkqfDKFJoIPYjr/X/XLmRVDilJCzYnFOuJ
         Wi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=1DK0UF/kL82QrvYABqU/VoJiKaE1Dt6FgsB7/yAupGI=;
        b=UnJo+LWQLC8V6yf9eWvYboavYyUL6Ef3MbHFKBR/8Ku/iPF/SoN1XzV7K6MBuge1K3
         Ri0hHb0Ql1aO5X6dxeQ2C42E7Pnn/MpjdASIT2Dv8lxPS0urCgRrb+YwkngVhxKlwN5H
         tdNEHvc1443RivavVF87iYbEUgS52gzMP2oToqbYWv7PKE7mJVA9gA4rUibyfgHqNJ0t
         Fm3xJNyXyLd1x9MlW4HS82JOSGwdzuu3Id7ONalqbnEVa+9S0dJMmnCIvxbDMQ84sQ4V
         LX29kzkeLqJStuZ5V3ZiHk5VJ48V2KSlsoGOGOQ/3gpF+CtmRMeGyxa4Sdkv21KC8pfu
         I+4w==
X-Gm-Message-State: APt69E0oeESEZgQUQfJMv+0fmg0jHbCGWb8dyl7RdVGX1P8A9rc5w+Xy
        VvcbG9kyZozugacDkSvkr1l/qrlT11x6k3sgQdqovwuUNQ3UIKwAxsvrIus02TkKH11VswMDmjP
        UeylVXE+tl9xqxhEe7NUjCU2kUNSTUUhefsnkdbwS2g3pNPniV5n1j8njOnyl
X-Google-Smtp-Source: AAOMgpetNdpCs2m7o3eqkW1pVGKcovgGgwHYgCSzC24cfiUS8Th94WW/nte6MDbuWL/PZqpN9vQkdtjO36DR
X-Received: by 2002:ab0:4141:: with SMTP id j59-v6mr5253683uad.1.1530238254361;
 Thu, 28 Jun 2018 19:10:54 -0700 (PDT)
Date:   Thu, 28 Jun 2018 19:10:48 -0700
Message-Id: <20180629021050.187887-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH 1/3] .mailmap: merge different spellings of names
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a continuation of 94b410bba86 (.mailmap: Map email
addresses to names, 2013-07-12), merging names that are
spelled differently but have the same author email to the
same person.

Most spellings differed in accents or the order of names.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .mailmap | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index df7cf6313c7..f165222a782 100644
--- a/.mailmap
+++ b/.mailmap
@@ -35,11 +35,13 @@ Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
 Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
 Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
+Christopher D=C3=ADaz Riveros <chrisadr@gentoo.org> Christopher Diaz River=
os
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
 Daniel Barkalow <barkalow@iabervon.org>
+Daniel Knittl-Frank <knittl89@googlemail.com> knittl
 Daniel Trstenjak <daniel.trstenjak@gmail.com> <daniel.trstenjak@online.de>
 Daniel Trstenjak <daniel.trstenjak@gmail.com> <trsten@science-computing.de=
>
 David Brown <git@davidb.org> <davidb@quicinc.com>
@@ -57,6 +59,7 @@ Eric S. Raymond <esr@thyrsus.com>
 Eric Wong <e@80x24.org> <normalperson@yhbt.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.ntnu.=
no>
+Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achleitn=
er2.6.31@gmail.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
@@ -86,6 +89,8 @@ Jason McMullan <mcmullan@netapp.com>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
+Jean-No=C3=ABl Avila <jn.avila@free.fr> Jean-Noel Avila
+Jean-No=C3=ABl Avila <jn.avila@free.fr> Jean-No=C3=ABl AVILA
 Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
@@ -149,6 +154,7 @@ Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.c=
a>
 Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
 Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>
 Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
+Matthias R=C3=BCster <matthias.ruester@gmail.com> Matthias Ruester
 Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
 Michael Coleman <tutufan@gmail.com>
@@ -213,6 +219,8 @@ Sean Estabrooks <seanlkml@sympatico.ca>
 Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.com>
 Seth Falcon <seth@userprimary.net> <sfalcon@fhcrc.org>
 Shawn O. Pearce <spearce@spearce.org>
+Wei Shuyu <wsy@dogben.com> Shuyu Wei
+Sidhant Sharma <tigerkid001@gmail.com> Sidhant Sharma [:tk]
 Simon Hausmann <hausmann@kde.org> <simon@lst.de>
 Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
 Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
@@ -253,7 +261,8 @@ Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =
<ukleinek@informatik.uni-frei
 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <uzeisberger@io.fsf=
orth.de>
 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <zeisberg@informati=
k.uni-freiburg.de>
 Ville Skytt=C3=A4 <ville.skytta@iki.fi> <scop@xemacs.org>
-Vitaly "_Vi" Shukela <public_vi@tut.by>
+Vitaly "_Vi" Shukela <vi0oss@gmail.com> <public_vi@tut.by>
+Vitaly "_Vi" Shukela <vi0oss@gmail.com> Vitaly _Vi Shukela
 W. Trevor King <wking@tremily.us> <wking@drexel.edu>
 William Pursell <bill.pursell@gmail.com>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <qhwt+git@les.ath.cx>
--=20
2.18.0.399.gad0ab374a1-goog

