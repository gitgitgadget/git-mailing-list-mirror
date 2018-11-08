Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3154A1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKICog (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 21:44:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42044 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKICog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 21:44:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so9112039pgq.9
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9gbWDnTTrA24KNK6J0LNuc4KD3EA27LpgGRVTsdyiwY=;
        b=KkCx6O8yPCD7CH20hRKHWc6x9KwRiWGtRfF4eqmjC8d5YnQLXsZ8ZTB2RSkT+L7onr
         toUasxuIVGvKrxDL9fi6nHCUF5ironINbhQe2jVrjlSCehjE9rKCJ38WKOXxF/pXANV7
         THbII/c4wsiJHYeV9M7I1RXmTA9UTmg5oz6yLg7LZBzhmIvsFzKgDpeKzleeS1MYWh6H
         fJtG94W3QNORpjZBYx5Rf44jbfjM6yO5lej6DOSotQjkiR7ql+wBNXZLpAnvASkORP+r
         Kd08IKz56B2VteifB39TGgPleYflkDi/C+x7Xa3ev8zqWDH9fIprRmyd0uzbC+hp/MXS
         m03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9gbWDnTTrA24KNK6J0LNuc4KD3EA27LpgGRVTsdyiwY=;
        b=s3unOEZnFG7rjh7hlOiPWgOHucgxL8UNYsfFOHfkWDjOtYf02ZdcDUCDWAiJYpz5MT
         owbNQXZIw11sxf6/sYLNxgkS0qnvsW34IOav38mM0yUxUkRtNYtBg5Uw5WjclsenjvLV
         R+T4cAXa5T15ckARLMcty+kFWE5poY9DzvcxNDU0EurokobhO9qOM93dJEtpMyX3FDEB
         VANKn9rg10oYOCeDvof+SDOtYGwPE2s6luChxDzILNP6OVXursa7bQie8sC77N7wHyU3
         AvwTZUwMeojq028buRjReoK/eHPQzRNl0VL4bHqQMFahKMLrYmoPkuZXJi0UFHWRAMB8
         9OJA==
X-Gm-Message-State: AGRZ1gIeWs2lj7SoSUDdVpeZAS8jc/7Mam0nI4xOxW9g0rwfkjVaWhvS
        oXz0AznXHsVYwsvMASO3mc3lSBTg
X-Google-Smtp-Source: AJdET5c0luGFjjUXDdkXVsCkvW1xTCxNilc5XRNKKpO+EvVi1lnWI8ORA8nk1aMCA3vsAY8gffWWqg==
X-Received: by 2002:a62:25c2:: with SMTP id l185-v6mr5522529pfl.64.1541696890528;
        Thu, 08 Nov 2018 09:08:10 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id a73-v6sm4661711pfj.38.2018.11.08.09.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 09:08:09 -0800 (PST)
Date:   Thu, 08 Nov 2018 09:08:09 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 17:08:06 GMT
Message-Id: <b590a9bebf8ac10b6f1d85287bb8d7a8ac7082a6.1541696887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.71.git.gitgitgadget@gmail.com>
References: <pull.71.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Update .mailmap
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

This patch makes the output of `git shortlog -nse v2.10.0`
duplicate-free.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .mailmap | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.mailmap b/.mailmap
index bef3352b0d..1d8310073a 100644
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
+Masaya Suzuki <masayasuzuki@google.com><draftcode@gmail.com>
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
