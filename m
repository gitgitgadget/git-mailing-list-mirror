Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE351F453
	for <e@80x24.org>; Fri,  9 Nov 2018 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeKIVL3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 16:11:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39785 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeKIVL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 16:11:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so743921pgv.6
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 03:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VrEoJHALKzAECXhA53DJ5q1IeynEzNEwCYFU9RiHcgA=;
        b=JDGrEMFRI8GPSsk4dTEaU/6Pmr8pqnFLaKg/0pao08RUqxhS9++4JxfHxifL7Dh14U
         +ud3NHeaslllkzZn6jyqAjoIa3rxiGpe81qCUnQ9JGy8DmmCPqhbBi1fylXxR6Ncd4Ja
         6uTXAtylnCVMWgnmmAqmmBNfYC9E7tDonqgoZtqKiQ0zFC6O5ytYwjl7v+qfHOnY6ges
         Dl2A8kdOJuembYWMtzoQHcw3hOW9pHzq6EF7qPRp9O03gphts4jaHd7TT72VA2ADzPUI
         vZ6k1XkumxwWlX1Ai3dJJaj47iIrbpqWUEXr29s2nsdEs33GOOIeVvj5/IfjspJ5ZlI/
         xfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VrEoJHALKzAECXhA53DJ5q1IeynEzNEwCYFU9RiHcgA=;
        b=GChgQGwwOiTIBSceB3IlwliZ8X763sY6oxIGp5WqGMnnIy6/Iu39wGGWyMPuYA0knB
         h/AyFvAOXEeG1KgBHcgBLOgZ8jUHDx8idIC5GilQEt2qwaIww2hmPAGuIjHPKilu+dLO
         XaBHwLTxubmT2TUHqFn/4KRUvy3p2D7sLGDqq77gsIor2DQL2+VsmnXCyuItcanN9Rxm
         jdaKz2qUFHza9pUYLHGUKCC3YTiEYTNYVoG/J9SBd6DuV4W+ZFqQLODUAbH/VxqZXzmf
         T45ldH7uTvTkzfqzk09E62gUA5fOaRT3BOqQonWqUU/PreRA6aZ6L5q85J4GdJOzqrwU
         +rgw==
X-Gm-Message-State: AGRZ1gKWQCqLK1intWaNsjFf/yJOH+yjpIFMedUIYD4dEW2bFhkKadBu
        NBwoiZ6GsVh6tFfyR1h//gjhLVtBgsg=
X-Google-Smtp-Source: AJdET5eYb4SIsf6BC1ds2IRl9nFHKLNgfUDt6sxhU2vBUHSCjO6l/+LTJDA8IffNaeQ+xywOXT1E1g==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr7126519pgd.422.1541763075147;
        Fri, 09 Nov 2018 03:31:15 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id m5-v6sm10969298pfc.188.2018.11.09.03.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 03:31:14 -0800 (PST)
Date:   Fri, 09 Nov 2018 03:31:14 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 11:31:11 GMT
Message-Id: <c121ebc47428077ec30fd6f0c724fd99f81387f6.1541763071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.71.v2.git.gitgitgadget@gmail.com>
References: <pull.71.git.gitgitgadget@gmail.com>
        <pull.71.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] Update .mailmap
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch makes the output of `git shortlog -nse v2.10.0..master`
duplicate-free.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .mailmap | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.mailmap b/.mailmap
index bef3352b0d..eb7b5fc7b9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -21,6 +21,8 @@ Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
 Amos Waterland <apw@debian.org> <apw@us.ibm.com>
+Ben Peart <benpeart@microsoft.com> <Ben.Peart@microsoft.com>
+Ben Peart <benpeart@microsoft.com> <peartben@gmail.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
@@ -32,6 +34,7 @@ Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
+Christian Ludwig <chrissicool@gmail.com> <chrissicool@googlemail.com>
 Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
 Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
@@ -51,6 +54,7 @@ David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
 David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
+Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
 Deskin Miller <deskinm@umich.edu>
 Dirk Süsserott <newsletter@dirk.my1.cc>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
@@ -98,6 +102,7 @@ Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Lindström <jl@opera.com> Jens Lindstrom <jl@opera.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
+Joachim Jablon <joachim.jablon@people-doc.com> <ewjoachim@gmail.com>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@gmx.de>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
 Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
@@ -150,6 +155,7 @@ Mark Levedahl <mdl123@verizon.net> <mlevedahl@gmail.com>
 Mark Rada <marada@uwaterloo.ca>
 Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gmail.com>
+Masaya Suzuki <masayasuzuki@google.com> <draftcode@gmail.com>
 Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
 Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
 Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>
@@ -157,6 +163,7 @@ Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
 Matthias Rüster <matthias.ruester@gmail.com> Matthias Ruester
 Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
 Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
+Matthieu Moy <git@matthieu-moy.fr> <Matthieu.Moy@imag.fr>
 Michael Coleman <tutufan@gmail.com>
 Michael J Gruber <git@grubix.eu> <michaeljgruber+gmane@fastmail.fm>
 Michael J Gruber <git@grubix.eu> <git@drmicha.warpmail.net>
@@ -180,7 +187,11 @@ Nick Stokoe <nick@noodlefactory.co.uk> Nick Woolley <nick@noodlefactory.co.uk>
 Nick Stokoe <nick@noodlefactory.co.uk> Nick Woolley <nickwoolley@yahoo.co.uk>
 Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nicolas.morey@free.fr>
 Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nmorey@kalray.eu>
+Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nicolas@morey-chaisemartin.com>
+Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <NMoreyChaisemartin@suse.com>
+Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nmoreychaisemartin@suse.com>
 Nicolas Sebrecht <nicolas.s.dev@gmx.fr> <ni.s@laposte.net>
+Orgad Shaneh <orgads@gmail.com> <orgad.shaneh@audiocodes.com>
 Paolo Bonzini <bonzini@gnu.org> <paolo.bonzini@lu.unisi.ch>
 Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
 Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
@@ -200,6 +211,7 @@ Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
+Randall S. Becker <randall.becker@nexbridge.ca> <rsbecker@nexbridge.com>
 René Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
 René Scharfe <l.s.r@web.de> Rene Scharfe
 Richard Hansen <rhansen@rhansen.org> <hansenr@google.com>
@@ -238,6 +250,7 @@ Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 SZEDER Gábor <szeder.dev@gmail.com> <szeder@ira.uka.de>
+Tao Qingyun <taoqy@ls-a.me> <845767657@qq.com>
 Tay Ray Chuan <rctay89@gmail.com>
 Ted Percival <ted@midg3t.net> <ted.percival@quest.com>
 Theodore Ts'o <tytso@mit.edu>
-- 
gitgitgadget
