Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74D11FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbdFGSci (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:32:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36235 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdFGSch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:32:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id e23so1896945wre.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JBnci5wn0TY0rGmYS6Q+t9uUPMRPjoz40oYZhJLDk7Y=;
        b=OL11JF5iAPulZOg5IBWv2iY49U/b1EuIGftxUdY6WvuqxLBn8MQkRGzK/NgvWo/T4+
         clu0ysop13VThnDJ99NjQ80o18uixgfD7mUZYKdCvU95jr73wPHDmGH71Kaad4ysnjvU
         usezsJAwBJ+W/60j6mGQ52w9JKuDkB/w8RsUMu+X8k2oXNW+hqtcNE96YK6QojSrKakI
         HXdaxqptO0dRoRHR22XV1tAL/AGgppApfESd5R7WCfd145b3Gp6oyGg4a4qrjTgjeDiQ
         lB9FkGBLdrCdWm1uKOMEbVlagr2HyjEnUkiFPkvhQi8D5mrBNXmHkRVQfNr7MfK/BD/V
         YrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JBnci5wn0TY0rGmYS6Q+t9uUPMRPjoz40oYZhJLDk7Y=;
        b=Idf7RyNEO9DyvPR02SXEpwArIIQbneqNYR3H+GPcART8vyXazwoTQv8R09U/Tklamd
         VlA31CKtibVpZWmwJyZ/7B8MBMbMG7IEIPEjWNUurH7y/Z4LJ7FyG0ymUaWRaGPgBJq8
         hpJ2i8/4w4TGAUIGmPzW9M/ZOy1aA0q7XntMSPtsOjdBM8vIFKhRZtns7weOOIC6vJWk
         K+DStv7Fm4tStT909mSE+SKnacbgy3VIsRMS5VVLamz2nMKBl1Cy78SLhf5vzbEj/5qh
         kwFb3v/CA2dAv5Qqd5AyhBO8Afklt+eNZFkBq5g7eeUJ7jkDipi2r6tzqTtbRC1kqVVN
         FyBA==
X-Gm-Message-State: AODbwcDZhuc0IDnrEb3tVWrEs/TnxI7hzb8hTCCHycbwnu+TIG+GF2DK
        38PfU3ELQKUFsRxjSj8=
X-Received: by 10.223.173.23 with SMTP id p23mr13725621wrc.56.1496860356020;
        Wed, 07 Jun 2017 11:32:36 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:1006:a201:2c73:5f2f:b8a6:9ab1])
        by smtp.gmail.com with ESMTPSA id l26sm4006975wrl.15.2017.06.07.11.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 11:32:34 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: describe git svn init --ignore-refs
Date:   Wed,  7 Jun 2017 20:32:14 +0200
Message-Id: <20170607183214.21259-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing documentation for `git svn init --ignore-refs`.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-svn.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9bee9b0c4..fba0b4eec 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -95,6 +95,10 @@ If you still want the old default, you can get it by passing
 `--prefix ""` on the command line (`--prefix=""` may not work if
 your Perl's Getopt::Long is < v2.37).
 
+--ignore-refs=<regex>;;
+	When passed to 'init' or 'clone' this regular expression will
+	be preserved as a config key.  See 'fetch' for a description
+	of `--ignore-refs`.
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
@@ -138,6 +142,18 @@ the same local time zone.
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
 
+--ignore-refs=<regex>;;
+	Ignore refs for branches or tags matching the Perl regular
+	expression. A "negative look-ahead assertion" like
+	`^refs/remotes/origin/(?!tags/wanted-tag|wanted-branch).*$`
+	can be used to allow only certain refs.
++
+[verse]
+config key: svn-remote.<name>.ignore-refs
++
+If the ignore-refs configuration key is set, and the command-line
+option is also given, both regular expressions will be used.
+
 --ignore-paths=<regex>;;
 	This allows one to specify a Perl regular expression that will
 	cause skipping of all matching paths from checkout from SVN.
-- 
2.13.0

