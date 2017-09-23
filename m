Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73EB9202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 05:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdIWE4g (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 00:56:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34482 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdIWE4f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 00:56:35 -0400
Received: by mail-pg0-f68.google.com with SMTP id u18so1759543pgo.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 21:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRwOSagXcxiVzoEthU77VLE0ufgnnJ9HTnNtG+tsnVE=;
        b=NCuUhVo50OEzcBnGIkfhb9nIWg3Yi2l5B6pgUb9JZ3FpsLFs0dj9pjPv4IjyIpFO+1
         YeMYvPfSzDNxgqaQYLb1KKMSUn7tUlcE82lXnImjU4lD4eNMEe3aqT9tTsyWHGNQ5mHb
         fmGuh6DAi5B6iFJ8IL52tajkvnAlmN4feaxV4lHBbe0bdOyz6RNyoAo4eQjf0RkVzFgi
         2hGl02gwZqGzAHZGFci2o70vrCNdvvZoLrFkX+IWUjg865Bhg+pgMpOh+35EJfc1T2ul
         xldmtwyfBqjwXKhVq/mhFz4K1k3cWMLxW6B96HwjdpC3dcvlfFIyylKH7BVNfuK499aB
         VY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRwOSagXcxiVzoEthU77VLE0ufgnnJ9HTnNtG+tsnVE=;
        b=oD7RRVJPTEq45TqJQWfgY+VacgLl9kNRGp7yM0bMkrV0FXeNtWO7yzTr9rUT5GmFBa
         zQWxish7wejffWTvf5DlfljFVa/8PfYVYxSlJLZstIAbDWHUsm+oJ7+ygbQY1bJHvezI
         9PAZ+M3Oen6e1zdWIiu8mBjXpoUBY4FUNhlKARqlKJVdI5M7Rc7QmSQreASTxCeUfDEX
         kLFHk2hdzJ7Tcq3lmn0LHu5JxREL/C3AW85yz7l8yAuqUgg+XRJam78wBqkp8iRocf81
         JwS8f9Z+aF2Y1h4kvFb8fN2vQQeSUvlOS0tS72xZAJL0aRLBr7hMKE7DaSgc5edoUVSo
         pcHw==
X-Gm-Message-State: AHPjjUgdA0H5HL705yHpHCgSS/x5PqC4v7OPfP7s33LrzUssmRblwGXV
        vREKCGPM++mUyupUNPMdyww=
X-Google-Smtp-Source: AOwi7QCUuHsEu32ZEVTLsnktd6bk7xs8N8YrhxNBv7t7dDsrY841cUbxwINgP8baOldK9kzmqJzHzA==
X-Received: by 10.101.76.73 with SMTP id l9mr1161135pgr.367.1506142594868;
        Fri, 22 Sep 2017 21:56:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:70c5:34d4:d97c:af1b:33e7:ca29])
        by smtp.gmail.com with ESMTPSA id l12sm1642812pgp.74.2017.09.22.21.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2017 21:56:34 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] doc: camelCase the config variables to improve readability
Date:   Sat, 23 Sep 2017 10:26:17 +0530
Message-Id: <20170923045617.3782-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.868.g66c78774b
In-Reply-To: <20170919202201.GD75068@aiede.mtv.corp.google.com>
References: <20170919202201.GD75068@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few configuration variable names of Git are composite words. References
to such variables in manpages are hard to read because they use all-lowercase
names, without indicating where each word ends and begins.

Improve its readability by using camelCase instead.  Git treats these
names case-insensitively so this does not affect functionality. This
also ensures consistency with other parts of the docs that use camelCase
fo refer to configuration variable names.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Triple checked the 'In-reply-to' Mail-Id this time ;-)

 Documentation/git-branch.txt | 4 ++--
 Documentation/git-tag.txt    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e292737b9..58f1e5c9c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -92,10 +92,10 @@ OPTIONS
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 	Note that in non-bare repositories, reflogs are usually
-	enabled by default by the `core.logallrefupdates` config option.
+	enabled by default by the `core.logAllRefUpdates` config option.
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
-	`core.logallrefupdates`.
+	`core.logAllRefUpdates`.
 
 -f::
 --force::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 543fb425e..95e9f391d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -174,7 +174,7 @@ This option is only applicable when listing tags without annotation lines.
 	`core.logAllRefUpdates` in linkgit:git-config[1].
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
-	`core.logallrefupdates`.
+	`core.logAllRefUpdates`.
 
 <tagname>::
 	The name of the tag to create, delete, or describe.
-- 
2.14.1.868.g66c78774b

