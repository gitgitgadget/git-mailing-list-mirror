Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2741F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfJHTcF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:32:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40602 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfJHTcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 15:32:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so10829277pgl.7
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sWpatjb5depKPVM0NtJOMgvxN0lstq1rIOCEkUSqGE8=;
        b=ab7OQ0GRolhIRYOxB8CpF96BBAHbR0pNSyGqourFauQRdal273pdhTRTAvTQebbUWT
         ho6xwBcuOqUTqj2dtSttE50tT58GuM4nc8l01iP/XahKPYdP5N8egKHsW2NLM4eHBxTL
         l1bahko+J74jdNyX03eHv05gg1188cFHoZVDCgnQl7YCKfrP4YznfcTMi12DWYtYgV5+
         gjCadfY7v//WgY3f4UDBdstnNreFfbpetyWl6sKBUlco9K7cuQk53RMj03UtwYvw9V46
         ClGt8eT8eVM/BI2IzfsFoz1l27rb9lQ+M6Q8gS4jv2d/vUpl8pxnQBoiRzX9x30pVTYL
         7t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sWpatjb5depKPVM0NtJOMgvxN0lstq1rIOCEkUSqGE8=;
        b=IjI79MdwdF9pL2mwxyOUgVz7c5hKHEDCa33sBAQTOAimoyu9f3sLseACITHsLW8ewM
         KqP/FR2fU5jIFJq+kr1FHOAChbf6RhV0KiyoaIVXFW3eD9SAP88ALnZnX+GmeXHJoPWh
         YC51M5VP5254TtvdsPewxO5UCh+lT5hfDxAOmJv2ixPlKLAlKqxJCFq1IpoWRoI5mNck
         xW3WapKE+kWv8J+QmVVzmqiAZ9tWBvg9JQmH1pPHU2x1avzZ75BP/DXzaGR+An+H0Qro
         lGsl2QY7zYiEVEKO7Tx3sdVWcr+zm3GEvpRfw5+KKc4BbwHA2c5yIaCJm/dHX06T3/5r
         9Vpg==
X-Gm-Message-State: APjAAAXg7mc5LMfKfQPspHwjMBVoBMentltLc/0m9DEADIo+ZaOuh+g1
        m6gb2/nrQY35bxN80VUnMNCd0NhGxXw=
X-Google-Smtp-Source: APXvYqwiTokRzYEdgThL/ga/ZQYRx93dbWe2zi0hSmb5j1RgdqJUMmoxWTMOTUucJz/1jhHx8G+2Dw==
X-Received: by 2002:a63:ef57:: with SMTP id c23mr9759pgk.436.1570563124213;
        Tue, 08 Oct 2019 12:32:04 -0700 (PDT)
Received: from ?IPv6:2409:4073:2011:f689:a6db:30ff:fee2:b535? ([2409:4073:2011:f689:a6db:30ff:fee2:b535])
        by smtp.gmail.com with ESMTPSA id l72sm5677pjb.7.2019.10.08.12.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:32:03 -0700 (PDT)
Message-ID: <f751705949a7fd23c77cbbf839c081b95b12394b.camel@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
From:   Harish Karumuthil <harish2704@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Date:   Wed, 09 Oct 2019 01:01:59 +0530
In-Reply-To: <nycvar.QRO.7.76.6.1910071159530.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
          <20160331164137.GA11150@gmail.com>
          <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
          <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
         <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
          <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
          <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
          <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
          <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
         <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
         <e71835129c0628ff3b9a0653febc3737128fa23c.camel@gmail.com>
         <nycvar.QRO.7.76.6.1910071159530.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, there is an update:

I added necessary error catching code so that, script will not crash if the
keybinding code is worng. Instead of crashing it will print error message.
The final patch will look something like this.

---
 lib/tools.tcl | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/tools.tcl b/lib/tools.tcl
index 413f1a1700..3135e19131 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
 }
 
 proc tools_populate_one {fullname} {
-	global tools_menubar tools_menutbl tools_id
+	global tools_menubar tools_menutbl tools_id repo_config
 
 	if {![info exists tools_id]} {
 		set tools_id 0
@@ -61,9 +61,25 @@ proc tools_populate_one {fullname} {
 		}
 	}
 
-	tools_create_item $parent command \
-		-label [lindex $names end] \
-		-command [list tools_exec $fullname]
+	set accel_key_bound 0
+	if {[info exists repo_config(guitool.$fullname.gitgui-shortcut)]} {
+		set accel_key $repo_config(guitool.$fullname.gitgui-shortcut)
+		if { [ catch { bind . <$accel_key> [list tools_exec $fullname] } msg ] } {
+			puts stderr "Failed to bind keyboard shortcut '$accel_key' for custom tool '$fullname'. Error: $msg"
+		} else {
+			tools_create_item $parent command \
+			-label [lindex $names end] \
+			-command [list tools_exec $fullname] \
+			-accelerator $accel_key
+			set accel_key_bound true
+		}
+	}
+
+	if { ! $accel_key_bound } {
+		tools_create_item $parent command \
+			-label [lindex $names end] \
+			-command [list tools_exec $fullname]
+	}
 }
 
 proc tools_exec {fullname} {
---

@Johannes Schindelin: In short, from your previous message I understand point.

1. shortcut codes like "<Control-,>" will only in Windows platform. It may not work in Linux / Mac.
2. We need do translate shortcut codes somehow ( using one-to-one maping ).

If this is correct, do you have any example on how to do one-to-one maping of a list of string on TCL ?

