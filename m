Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BED11F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfGRNTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54276 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfGRNTE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so25552342wme.4
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hu/n5CDL5X3Jv5DVGBhVY2pi1aH+fZYcHe356KwKrSo=;
        b=p6lDPwC+PyiS7NaSMeAgb3Je/Bu9mflUW8zkKOhGLvSmPeE/xNcHASuhsVcd8xARgx
         QmU5Qy/xEuQfkESOGLoeBMsmflfmoaHmMteeO2eySF8/YIHso4iIvXeDDBliOmFZboQw
         QDJg5Q3k1BJBl/TWnYXozxgATPx1ygCZkTXdPD11KD9/oRk3xVt2DZnJBt/TYvsKwro3
         dUK8fWwiJ3iHV2YhEyntq/dstJG7rwuWjJOtcJetzdpJAnSJCFBfZ7ZNGJi1rfuS37Rk
         ct2+YEE1Ldt71EVqfj/C9bJDy6iCtu8RWBIPaJWOMaXmHtBuiIqUADSbHx7wjDK0tF7J
         9cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hu/n5CDL5X3Jv5DVGBhVY2pi1aH+fZYcHe356KwKrSo=;
        b=XutRAtG4CGmncJTMCtVQadeKQbKrEAmnOK9DZIKqAM4N0oXRMMmqPD6o/opNaBPj+4
         MVSp2sa4/n2YymzFmdQkWlImOi1en/oJt7EuxedIV/IcJDkGpZ243t6mMIhrL1ajQIwc
         rQ2DBvVzsLaglt5gdvUCw3edrGHIgNa/hzxuw1N8Ad5h2wLh12cqc13UpxFIOBjYRgdW
         h304B3B9oTXabi/xLGsrgtKyO8a0tVxay5fAn9Hzg6o29MSJ9J0pMhhaaZDxVIbzsK2Q
         z/8J2YeFGXU16Ab3CMbQHu7YWQ8V8QheVU2IBjWmpM990HmMtGGfDhfJvpKtBiYx4kMf
         Uc3A==
X-Gm-Message-State: APjAAAXf68xzwfpHqjBxPRYja81cenQdN7Q+j8s9vLVpOQRf7Im8Udqb
        a9nzveSm/YGq6/cJV8llJ0Ti0YiE
X-Google-Smtp-Source: APXvYqxcGvDhVQ9Nv9WKnzX/Zm2tJgmWMMuc7p5T4Itfw6DwZPisphYz6qXtvDpBbpe1r1dcfG4Lzw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr44950414wme.113.1563455941765;
        Thu, 18 Jul 2019 06:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c65sm24704339wma.44.2019.07.18.06.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:01 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:01 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:36 GMT
Message-Id: <240ff4251774fbede9cce21a5140af655e05d7ba.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/24] Vcproj.pm: auto-generate GUIDs
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

We ran out GUIDs. Again. But there is no need to: we can generate them
semi-randomly from the target file name of the project.

Note: the Vcproj generator is probably only interesting for historical
reasons; nevertheless, the upcoming Vcxproj generator (to support modern
Visual Studio versions) is based on the Vcproj generator and it is
better to fix this here first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators/Vcproj.pm | 66 ++++-------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index cfa74adcc2..c79b706bc8 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -3,6 +3,7 @@ package Generators::Vcproj;
 
 use strict;
 use vars qw($VERSION);
+use Digest::SHA qw(sha256_hex);
 
 our $VERSION = '1.00';
 our(@ISA, @EXPORT, @EXPORT_OK, @AVAILABLE);
@@ -12,59 +13,12 @@ BEGIN
     push @EXPORT_OK, qw(generate);
 }
 
-my $guid_index = 0;
-my @GUIDS = (
-    "{E07B9989-2BF7-4F21-8918-BE22BA467AC3}",
-    "{278FFB51-0296-4A44-A81A-22B87B7C3592}",
-    "{7346A2C4-F0FD-444F-9EBE-1AF23B2B5650}",
-    "{67F421AC-EB34-4D49-820B-3196807B423F}",
-    "{385DCFE1-CC8C-4211-A451-80FCFC31CA51}",
-    "{97CC46C5-D2CC-4D26-B634-E75792B79916}",
-    "{C7CE21FE-6EF8-4012-A5C7-A22BCEDFBA11}",
-    "{51575134-3FDF-42D1-BABD-3FB12669C6C9}",
-    "{0AE195E4-9823-4B87-8E6F-20C5614AF2FF}",
-    "{4B918255-67CA-43BB-A46C-26704B666E6B}",
-    "{18CCFEEF-C8EE-4CC1-A265-26F95C9F4649}",
-    "{5D5D90FA-01B7-4973-AFE5-CA88C53AC197}",
-    "{1F054320-036D-49E1-B384-FB5DF0BC8AC0}",
-    "{7CED65EE-F2D9-4171-825B-C7D561FE5786}",
-    "{8D341679-0F07-4664-9A56-3BA0DE88B9BC}",
-    "{C189FEDC-2957-4BD7-9FA4-7622241EA145}",
-    "{66844203-1B9F-4C53-9274-164FFF95B847}",
-    "{E4FEA145-DECC-440D-AEEA-598CF381FD43}",
-    "{73300A8E-C8AC-41B0-B555-4F596B681BA7}",
-    "{873FDEB1-D01D-40BF-A1BF-8BBC58EC0F51}",
-    "{7922C8BE-76C5-4AC6-8BF7-885C0F93B782}",
-    "{E245D370-308B-4A49-BFC1-1E527827975F}",
-    "{F6FA957B-66FC-4ED7-B260-E59BBE4FE813}",
-    "{E6055070-0198-431A-BC49-8DB6CEE770AE}",
-    "{54159234-C3EB-43DA-906B-CE5DA5C74654}",
-    "{594CFC35-0B60-46F6-B8EF-9983ACC1187D}",
-    "{D93FCAB7-1F01-48D2-B832-F761B83231A5}",
-    "{DBA5E6AC-E7BE-42D3-8703-4E787141526E}",
-    "{6171953F-DD26-44C7-A3BE-CC45F86FC11F}",
-    "{9E19DDBE-F5E4-4A26-A2FE-0616E04879B8}",
-    "{AE81A615-99E3-4885-9CE0-D9CAA193E867}",
-    "{FBF4067E-1855-4F6C-8BCD-4D62E801A04D}",
-    "{17007948-6593-4AEB-8106-F7884B4F2C19}",
-    "{199D4C8D-8639-4DA6-82EF-08668C35DEE0}",
-    "{E085E50E-C140-4CF3-BE4B-094B14F0DDD6}",
-    "{00785268-A9CC-4E40-AC29-BAC0019159CE}",
-    "{4C06F56A-DCDB-46A6-B67C-02339935CF12}",
-    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
-    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
-    "{9392EB58-D7BA-410B-B1F0-B2FAA6BC89A7}",
-    "{2ACAB2D5-E0CE-4027-BCA0-D78B2D7A6C66}",
-    "{86E216C3-43CE-481A-BCB2-BE5E62850635}",
-    "{FB631291-7923-4B91-9A57-7B18FDBB7A42}",
-    "{0A176EC9-E934-45B8-B87F-16C7F4C80039}",
-    "{DF55CA80-46E8-4C53-B65B-4990A23DD444}",
-    "{3A0F9895-55D2-4710-BE5E-AD7498B5BF44}",
-    "{294BDC5A-F448-48B6-8110-DD0A81820F8C}",
-    "{4B9F66E9-FAC9-47AB-B1EF-C16756FBFD06}",
-    "{72EA49C6-2806-48BD-B81B-D4905102E19C}",
-    "{5728EB7E-8929-486C-8CD5-3238D060E768}"
-);
+sub generate_guid ($) {
+    my $hex = sha256_hex($_[0]);
+    $hex =~ s/^(.{8})(.{4})(.{4})(.{4})(.{12}).*/{$1-$2-$3-$4-$5}/;
+    $hex =~ tr/a-z/A-Z/;
+    return $hex;
+}
 
 sub generate {
     my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
@@ -92,9 +46,8 @@ sub createLibProject {
     $target =~ s/\//_/g;
     $target =~ s/\.a//;
 
-    my $uuid = $GUIDS[$guid_index];
+    my $uuid = generate_guid($libname);
     $$build_structure{"LIBS_${target}_GUID"} = $uuid;
-    $guid_index += 1;
 
     my @srcs = sort(map("$rel_dir\\$_", @{$$build_structure{"LIBS_${libname}_SOURCES"}}));
     my @sources;
@@ -311,9 +264,8 @@ sub createAppProject {
     $target =~ s/\//_/g;
     $target =~ s/\.exe//;
 
-    my $uuid = $GUIDS[$guid_index];
+    my $uuid = generate_guid($appname);
     $$build_structure{"APPS_${target}_GUID"} = $uuid;
-    $guid_index += 1;
 
     my @srcs = sort(map("$rel_dir\\$_", @{$$build_structure{"APPS_${appname}_SOURCES"}}));
     my @sources;
-- 
gitgitgadget

