Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A7E207F8
	for <e@80x24.org>; Fri,  5 May 2017 10:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbdEEKIP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 06:08:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33664 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdEEKIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 06:08:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so187440wrc.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkS9sIqzE5SEfCOFeDotjBCYvlt75sncqYcdbvnBaho=;
        b=QXIKDzdSJ9tyLirfJ8rM0PWTFQQucDBaUhnIbxItnq4WZ96/uxpWZEsHNlD5QhPHa4
         FXlFbWDSk+9fvrO/iXjh36prSgp9l0mx1E4kNw0EBBIsB3V2xf3VMIGXRhgMZU4Ta1Bv
         X+HjMdop9Jc3if78VyMunPysr+WvJxP2VnhyER7Z3DIAnfKExpvmdk9RqcrYigi5o1mx
         WKqfeNXbzvrVlkMxdgA0r2wiagtKm1g2ilNE6+rQ8N2R80l9vflFeFxjXngbP3pOgbrY
         KTl/+A9/i5gxt307vAOvpkepsrFR9XxxuoUHe12yrZJf+EKjmkoG6bVdXuLd501qkvmW
         CoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkS9sIqzE5SEfCOFeDotjBCYvlt75sncqYcdbvnBaho=;
        b=IQJ2aI8Ggk+S4yCR/zLVKfIPVh0tjoPvzrKo6Q3YYD1txT8lgkvgTqAz08D2TKvZd5
         2nEeTkLdFtNu3IFwEwZj4bbCPSwhigods7Y6gDMEg9ONUDtr1AAseLM6tkikrZcZeNYm
         nNmiEY0l7Y9nZxxohJWmqX38gl0Na53zlqwLEpvsZNwrv+xUrZs+PdK2jwuX8VChRJS2
         na3OsE5+C/7eRsgzO7K9O/jgARKobR2BkXTBrHKMgjb5fMWobqTdDJUlKNUSDYj489pG
         XGFIArMUvu+daXKmQtZ1XIGuSKt6j69m1J0b4NJojfW6f9PqE9/ygSl5iMv7eg1I0OSv
         zqcQ==
X-Gm-Message-State: AN3rC/6yy7ryk0T6OcgaHCj0byUcpjgtO412/5bsA7uizP/51CzbXfwv
        T/Y7vVNI39eqlw==
X-Received: by 10.223.154.226 with SMTP id a89mr31999236wrc.192.1493978892509;
        Fri, 05 May 2017 03:08:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id f25sm6515337wrf.13.2017.05.05.03.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 03:08:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] doc: replace a couple of broken gmane links
Date:   Fri,  5 May 2017 10:08:03 +0000
Message-Id: <20170505100803.13238-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a couple of broken links to gmane with links to other
archives. See commit 54471fdcc3 ("README: replace gmane link with
public-inbox", 2016-12-15) for prior art.

With this change there's still 4 references left in the code:

    $ git grep -E '(article|thread)\.gmane.org' -- |grep -v RelNotes|wc -l
    4

I couldn't find alternative links for those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Perhaps someone else will have better luck with the other ones, which
are:

    Documentation/git-bisect-lk2009.txt-1355-- [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
    Documentation/git-bisect-lk2009.txt:1356:- [[[7]]] http://article.gmane.org/gmane.linux.scsi/36652/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Gmane.]
    Documentation/git-bisect-lk2009.txt-1357-- [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
    --
    git-rebase--interactive.sh-7-# The original idea comes from Eric W. Biederman, in
    git-rebase--interactive.sh:8:# http://article.gmane.org/gmane.comp.version-control.git/22407
    git-rebase--interactive.sh-9-#
    --
    t/t4038-diff-combined.sh-356-# Test for a bug reported at
    t/t4038-diff-combined.sh:357:# http://thread.gmane.org/gmane.comp.version-control.git/224410
    t/t4038-diff-combined.sh-358-# where a delete lines were missing from combined diff output when they
    --
    tree-walk.c-1077-                * in future, see
    tree-walk.c:1078:                * http://thread.gmane.org/gmane.comp.version-control.git/163757/focus=163840
    tree-walk.c-1079-                */

 Documentation/CodingGuidelines      | 2 +-
 Documentation/git-bisect-lk2009.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a4191aa388..2248cf7324 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -24,7 +24,7 @@ code.  For Git in general, a few rough rules are:
 
    "Once it _is_ in the tree, it's not really worth the patch noise to
    go and fix it up."
-   Cf. http://article.gmane.org/gmane.linux.kernel/943020
+   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
 
 Make your code readable and sensible, and don't try to be clever.
 
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 8ac75fcc25..b5d5e8b544 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1350,7 +1350,7 @@ References
 - [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
 - [[[2]]] http://www.oracle.com/technetwork/java/codeconvtoc-136057.html['Code Conventions for the Java Programming Language'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
-- [[[4]]] http://article.gmane.org/gmane.comp.version-control.git/45195/[Junio C Hamano. 'Automated bisect success story'. Gmane.]
+- [[[4]]] https://public-inbox.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
 - [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
 - [[[7]]] http://article.gmane.org/gmane.linux.scsi/36652/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Gmane.]
-- 
2.11.0

