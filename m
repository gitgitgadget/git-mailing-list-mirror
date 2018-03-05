Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555AD1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 23:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeCEXPr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 18:15:47 -0500
Received: from mail.netzguerilla.net ([217.11.57.120]:48915 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932636AbeCEXPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 18:15:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 9CDC1100014
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 00:06:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([217.11.57.120])
        by localhost (sal.netzguerilla.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gSq490Q0ebtc for <git@vger.kernel.org>;
        Tue,  6 Mar 2018 00:06:42 +0100 (CET)
Received: from [IPv6:2003:dd:ff0c:7c01:fdb4:c152:7c00:53f8] (p200300DDFF0C7C01FDB4C1527C0053F8.dip0.t-ipconnect.de [IPv6:2003:dd:ff0c:7c01:fdb4:c152:7c00:53f8])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 0A6A0100012
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 00:06:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1520291202;
        bh=q0a3hUC0F1UWh9wDQowNoleFr1cKiGeTZrVYhNdOQAI=;
        h=To:From:Subject:Date:From;
        b=nsePScmID+A/12fZlkL8MmL2IXsN/1xSj0mWK0LDz9o4NLkP5tzcqVVUO8j4KCHeP
         cwA+iN0GsKZAaz25I8rmphPdWfHJiaBLsHs1v1MksJN/UF7eWk4Or6OHKlVCX9DuTo
         QFTi6LSU44tZfYF8jUGLeKkt9XInIKAkzMg5Rx9X2Xv1+lZ4J4OMgF/4HOUCkhPVJY
         iTfs+kIsAXcDmtnfF9BfeCxgudBKZRUeduVtafm/dMmXNmUWT8pTeI0TxOJGRHrAPa
         zcRnTdShGB08eBeAEOwH2QxWnm5Y3ntQcplEH8ID1IE/SYX9qFGifOg6M/57eiX1+h
         OJnEvrmKutcdw==
To:     git@vger.kernel.org
From:   kalle <kalle@projektwerkstatt.de>
Subject: man gittutorial: patch proposal
Message-ID: <d34357b0-45a4-d22b-9a53-1a376addbd53@projektwerkstatt.de>
Date:   Tue, 6 Mar 2018 00:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060984869ECDDAD95F85BAFE"
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060984869ECDDAD95F85BAFE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

see attachment.
greetings,
kalle

--------------060984869ECDDAD95F85BAFE
Content-Type: text/x-patch;
 name="0001-I-corrected-some-few-quotation-mistakes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-I-corrected-some-few-quotation-mistakes.patch"

From ed466d29733a14acf3b2071d3d35aa829e09b1d7 Mon Sep 17 00:00:00 2001
From: kalledaballe <kalle@projektwerkstatt.de>
Date: Thu, 8 Feb 2018 18:53:54 +0100
Subject: [PATCH 1/5] I corrected some few quotation mistakes

---
 Documentation/gittutorial.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 242de31..d04f8ac 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -372,7 +372,7 @@ her work-in-progress on top of the resulting history.
 
 When you are working in a small closely knit group, it is not
 unusual to interact with the same repository over and over
-again.  By defining 'remote' repository shorthand, you can make
+again.  By defining remote repository shorthand, you can make
 it easier:
 
 ------------------------------------------------
@@ -406,8 +406,8 @@ could merge the changes into her master branch:
 alice$ git merge bob/master
 -------------------------------------
 
-This `merge` can also be done by 'pulling from her own remote-tracking
-branch', like this:
+This merge can also be done by pulling from her own remote-tracking
+branch, like this:
 
 -------------------------------------
 alice$ git pull . remotes/bob/master
-- 
2.1.4


--------------060984869ECDDAD95F85BAFE--
