Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3194F203E3
	for <e@80x24.org>; Sat, 23 Jul 2016 17:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbcGWRri (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 13:47:38 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34986 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbcGWRrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 13:47:37 -0400
Received: by mail-wm0-f49.google.com with SMTP id f65so90438170wmi.0
        for <git@vger.kernel.org>; Sat, 23 Jul 2016 10:47:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OZg5UhIS8l08b7j+PaPY3gnz1TPoPVLngbuCA87ScU8=;
        b=YbngYfEtbbWck3cQUrZtztHtC1nuv0KlpXyhPalWYKQtU5x7B6bS8JmSBm01fM9MSr
         GX9JWQQajUe8/Q6uCA7wPLRL1iuZWvUTzDVm9bntwJbRKA30G8bCYjH0mmUiEnsPMN9D
         Z8RhEJY9Ghm8xVz0hXrmxiJN1JmrX2XjCX5bqe3ju9owQy8ovu8pzBP5Zk7R0qfgcvrC
         SdGpgnIiZlwYl05BKnd60ZlBHA1xS76okJ8VuvtA0PAvyhRIEK05tQbUsK9Tq3xCudpH
         JOUcJoFsqdVeGj4A+j1fXoLDV5V1U+GCNSdhrIAqGiy1V9M7josjiuUn11yipYEEWbXK
         iD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OZg5UhIS8l08b7j+PaPY3gnz1TPoPVLngbuCA87ScU8=;
        b=k/x9SuV87YKEwewyP5spiUYcbE093OtX/SGNR0db1ipo51cNmmaZ/QC4mtDuzKbw3F
         ffHNYznTz0avN9PEUUoKv51MH5yvqNWN6HQgRyPlL0wDL6VhS5p/MBDHLYveFSWU7oA4
         yaEX6qrH05JEErgGZyVyNSGhV85TlbBksWlzTPmNJXu9pHMtKV8M21Grxe7j5KXKQ5/l
         CWw2NP+LxG6OI7cA1LqMucmTEJ6xtx2dg9uQsb/Vxll/CPAt8eg22WiWBLJsB6lvVA8L
         VcVtD84icOBLz4cYdfeTn0e72bj73Qa7vcgzSGxqN8UNPDcI/KPceiRLcPU9S+BAPTlL
         xOMQ==
X-Gm-Message-State: ALyK8tLd8JvJyIkGN3SiK9g0erN7DMPWivgI6qdv3HNH9Eamu+SmrpwZCQgi2o8gDA+pAw==
X-Received: by 10.28.1.74 with SMTP id 71mr30854663wmb.4.1469296054666;
        Sat, 23 Jul 2016 10:47:34 -0700 (PDT)
Received: from [192.168.1.26] (dcf38.neoplus.adsl.tpnet.pl. [83.23.57.38])
        by smtp.googlemail.com with ESMTPSA id pm1sm6867858wjb.40.2016.07.23.10.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jul 2016 10:47:33 -0700 (PDT)
Subject: Re: Complex gitweb URL
To:	CLOSE Dave <Dave.Close@us.thalesgroup.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <225e6ff4-178c-cd2a-6a05-b621f0ad4a84@us.thalesgroup.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5793ADAC.6030009@gmail.com>
Date:	Sat, 23 Jul 2016 19:47:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <225e6ff4-178c-cd2a-6a05-b621f0ad4a84@us.thalesgroup.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 21:24, CLOSE Dave pisze:

> I'm trying to create a URL that will always refer to the latest version 
> of a file stored under Gerrit. gitweb access is available. The man page 
> specification doesn't seem to work for me. Instead, I seem to need to 
> put most of the information into arguments (after the '?').
[...]
> 
> Are these arguments documented somewhere? What is the recommended way to 
> construct a URL like I need?

Actually it turns out that gitweb URLs are described in gitweb(1) manpage
https://git.github.io/htmldocs/gitweb.html#_actions_and_urls in the
"Actions, and URLs" section.

What was missing was explanation of available query parameters (the URL
arguments after the '?').  Would the following patch help, or is it still
missing something (NOTE: not tested)?:

----- >8 ------------------------------------------------------ >8 -----
Subject: [PATCH] gitweb(1): Document query parameters

The gitweb manpage includes description of gitweb URL structure,
but it was limited to passing parameters in the path part of URL
('path info'), and it didn't include explanation of query parameters.
---
 Documentation/gitweb.txt | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 96156e5..301003f 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -395,6 +395,43 @@ atom::
 	Generates an RSS (or Atom) feed of changes to repository.
 
 
+Query parameters:
+~~~~~~~~~~~~~~~~~
+In some cases gitweb cannot pass a parameter in path part of URL, for
+example if a filename contains double dots ('..') inside.  All parameters
+that cannot be passed in that way are put as a query parameter, that is
+after '?'.
+
+By default gitweb would generate links using query parameters, unless
+the original URL was using path part, or gitweb was configured to use
+pathinfo with the 'pathinfo' feature. All gitweb installations recognize
+URL in either format, so you can use one that is better for you when
+interacting with gitweb (handcrafting or editing URLs, or creating
+a program interacting with gitweb installation).
+
+Here is the list of some of query parameters, together with their
+long names (which should help remembering the short name of
+each parameter):
+
+'a' (action)::
+	The action that will be run.
+
+'p' (project)::
+	The project repository that will be displayed.
+
+'h' (hash)::
+	The object id of displayed object (commit, tag, tree, blob).
+	In case of files 'hb' (hash_base) and 'f' (filename) might be
+	used instead.
+
+'hp' (hash_parent)::
+'fp' (file_parent)::
+'hpb' (hash_parent_base)::
+      Those parameters define the second object for diff-like actions,
+      the object gitweb is comparing againts.
+
+
+
 WEBSERVER CONFIGURATION
 -----------------------
 This section explains how to configure some common webservers to run gitweb. In
-- 
2.6.3



