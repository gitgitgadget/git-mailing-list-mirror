Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED47A200B9
	for <e@80x24.org>; Tue,  8 May 2018 12:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEHMXX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 8 May 2018 08:23:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEHMXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 08:23:22 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Mg6ir-1euttJ3bin-00NQWN; Tue, 08 May 2018 14:23:16 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id C11EF64A76C;
        Tue,  8 May 2018 12:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M2rSXIFISath; Tue,  8 May 2018 14:22:57 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 54551648745;
        Tue,  8 May 2018 14:22:57 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Tue, 8 May 2018 14:22:56 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id C3850804D2; Tue,  8 May 2018 14:22:56 +0200 (CEST)
Date:   Tue, 8 May 2018 14:22:56 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] gitk: add an option to run gitk on an item in the file
 list
Message-ID: <20180508122256.nyv6ddcoifygfpk4@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180508121104.rtsrektxiihvpqtx@pflmari>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180508-2, 08.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:8eT6SjNTJqsBGvl5oqKASPOZ5mwgqZEwRqAcCzmuF3pVJ0/Nmwu
 uiJ6JrX6gI9/W/W1E0MXP91qvfULh5C04l5GRWvFnyVkB64xdWzdCh2bcwc7zr9KsK4jpyv
 7Hiaa/FjpD6NUDh+oIhySVIgJwz1zJkz1N5n1K6jDzm6eODjMylpRXInvnFXEs0QzM6ryO5
 ezEiWEodyoh8MJ1QncsDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bHiSk3vr2YA=:ymqDeSrOCjiKsHJy7rbUoS
 vWFQZqSKrhm2+Kq65yKVtIOPo8bU1U6kQYLX+y41ZEVAXqizbEIgFsxMfOPygEdzUcXsmWQuv
 vWJUXOUmJQRwgO+9+V/tLs62MGuPRC8eNxUDNSA0TiOvUX+2xSDK2dgWizZPLjFmfvE0qA+aF
 mxFQv15/ChZa5vg70OKQSecCpkrAUsySqvYgQZ4zqmLBBbHV0OgSM4lY7i+0hhXC2fFXjythP
 PsyJj2xeigGFZin4i2Js1PsDxG9wCGZM/rh/EzwV5whU5xuGLbpfKTsZp1i6pSTs3ftUaiHp+
 363pAGl7ksSsqolk6aa1HGqA9nOSRxxWoCIespR8mcuxKHojnQfBpeHB9rGBLi32TW0UXxF5o
 y8Vq832msyVlWB87jSTwwq5DerVI/i3FZpf3532kOJuQPdojLU3lhNs79YX0adBHOwD0AAbMr
 4ZuPxlp0xzfkkBq1EsPudqg1QUX+k4EN7ikrylQqfgOSglDNYTK435FMuRNvZNDCWvsXZuzdf
 /lBAhPSR9pf6B/eTua2OrllqE6YDAG68CKGQVV/ocXA2y3wsiFVKDr2qDWWoHFYq6WyucyjdW
 iaXP+UwpTlEA7cb12BnhD94JKq7HooXC8vSCllJLT8zEGX7YP5p1Sj1ZdKAMLKrJ8FdxzGu2B
 QbphOH/wjSUcQ6o6bWdtlwXrG7RODDHmavIbYrRB9v56s7BopWrYx9At26hXZtd7lacY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

Similar to a git gui feature which visualizes history in a submodule,
the submodules cause the gitk be started inside the submodule.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 gitk | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitk b/gitk
index d34833f..1ec545e 100755
--- a/gitk
+++ b/gitk
@@ -2682,6 +2682,7 @@ proc makewindow {} {
 	{mc "External diff" command {external_diff}}
 	{mc "Blame parent commit" command {external_blame 1}}
 	{mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
+	{mc "Run gitk on this" command {flist_gitk}}
     }
     $flist_menu configure -tearoff 0
 
@@ -3555,6 +3556,17 @@ proc flist_hl {only} {
     set gdttype [mc "touching paths:"]
 }
 
+proc flist_gitk {} {
+    global flist_menu_file findstring gdttype
+
+    set x [shellquote $flist_menu_file]
+    if {[file isdirectory $flist_menu_file]} {
+	exec sh -c "cd $x&&gitk" &
+    } else {
+	exec gitk -- $x &
+    }
+}
+
 proc gitknewtmpdir {} {
     global diffnum gitktmpdir gitdir env
 
-- 
2.17.0.rc1.56.gb9824190bd


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

