Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612CD1FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1043972AbdDVRMV (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 13:12:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36025 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756596AbdDVRMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 13:12:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so10055076wmu.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aS6IsJWGTRvxEg7kwoIOvfjoecfhE/BTgvRM11i5Xxo=;
        b=hvDUtKJGxgLG3WeaK/rxZz877azJGXqToHqcojtl6Dioku/iexMSA0YC8tvOptjG0m
         2dXQoJUWdjxMB6p+vI9tOAI1VXafiDyoxiBiPNLWkDKYv+xBMZ0jpOa6mPBMJdKu2djC
         lmqK4vagG0kZ0Qx/JjDdX9xKyrLsrYeGumTSuwFnYayhwaPJ398eVD5FFHQsxZQ1RWTC
         124V3X05355/QhzQ3YXCyrCKhfciUnxnImSAgNeRgJv09nJ3lOWKgjShzpPrtse8xMRM
         hf7Bp3+npPkPxMhfOeR7r35M5Md2YxXUY4q3FhEn/B78TWwrVfopifZuklfooc5RU+hd
         NSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aS6IsJWGTRvxEg7kwoIOvfjoecfhE/BTgvRM11i5Xxo=;
        b=nkFYYPKq0DDLQBUAhE7qe7Y+mjurqBuLiag4f3UbwIAqlSVFQC/3yTOJP9Mxc2qK0H
         Ea8BXGVYBms7sTEtQUz6CwfLNuptPn9N6Ef34jz9mf4q4m50iyJMR959U1n5QNfKay8T
         1wZMVOU2foN5sJJ2V/IWXQNM6k6SEgfjujc7JUZ5I3fUElXoFMAI36YWJpWq+arhQmX7
         WWItWck40IDSh0VSxaFvSW8IBkn+NAj8eEKz5E+YKM5mUsYa6Nwys8IWYV6yW5iCZo++
         iqV4DsPX/dIhphvmRRlWfS1ipbCSmceMmtJ/OgfyLxOZ5cLi3oQJgg+26aFa/C6iqmIy
         3HUg==
X-Gm-Message-State: AN3rC/5OvqSU15S9F05NPMm3oo1j+7HRamT3E7RD/ee1uCzs3dhqG+ZL
        mYvyai7qvhN5yQ==
X-Received: by 10.28.193.198 with SMTP id r189mr2958149wmf.118.1492881138044;
        Sat, 22 Apr 2017 10:12:18 -0700 (PDT)
Received: from ?IPv6:2a02:8071:3185:fe00:94c1:ef8f:4f8a:6061? ([2a02:8071:3185:fe00:94c1:ef8f:4f8a:6061])
        by smtp.googlemail.com with ESMTPSA id y63sm6560852wme.31.2017.04.22.10.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Apr 2017 10:12:17 -0700 (PDT)
Message-ID: <1492881136.7368.3.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Sat, 22 Apr 2017 19:12:16 +0200
In-Reply-To: <xmqq1sspdvjk.fsf@gitster.mtv.corp.google.com>
References: <1492287435.14812.2.camel@gmail.com>
         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
         <1492347718.19687.14.camel@gmail.com>
         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
         <1492368692.22852.9.camel@gmail.com>
         <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
         <1492380399.19991.13.camel@gmail.com>
         <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
         <1492452173.11708.22.camel@gmail.com>
         <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley>
         <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
         <1492518377.5720.47.camel@gmail.com>
         <xmqq1sspdvjk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-04-18 at 18:40 -0700, Junio C Hamano wrote:
> Christoph Michelbach <michelbach94@gmail.com> writes:
> 
> > 
> > On Mon, 2017-04-17 at 17:31 -0700, Junio C Hamano wrote:
> > 
> > > 
> > > Obviously, "grab all paths that match <pathspec> out of <tree>,
> > > add
> > > them to the index and copy them out to the working tree" will
> > > never
> > > be able to _restore_ the lack of 'd', even it may match the
> > > <pathspec> being used to do this checkout, by removing it from the
> > > current index and the working tree.
> > Exactly. "grab all paths that match <pathspec> out of <tree>, add
> > them
> > to the index and copy them out to the working tree" is a more
> > accurate
> > description of what the command does (but it might need some
> > rewording
> > ;-) ).
> Of course it is accurate, as that is how I would write it, not
> "restore", if I were doing the documentation.
> 
> Care to send in a patch to update the documentation?

From 10c362b0632255f90e0975fb6656feedca5fd407 Mon Sep 17 00:00:00 2001
From: Christoph Michelbach <michelbach94@gmail.com>
Date: Sat, 22 Apr 2017 18:49:57 +0200
Subject: [PATCH] Doc./git-checkout: correct doc. of checkout
<pathspec>...

The previous documentation states that the named paths are
updated both in the index and the working tree. This is not
correct as those paths can point to folders which are not
updated to what they are in the given tree-ish. Rather,
the files pointed to by the pathspecs are copied from the
tree-ish to the index and working tree One difference being
that one can name paths which are not present in the working
tree and another being that only files which are already
present in the given tree-ish are affected.

Furthermore, the changed text is intended to be more
intelligible as it is written in a way which is easy to
follow, rather than describing the technical process in
order of execution.

A hint alerting the users that changes introduced by this
command when naming a tree-ish are automatically staged has
been introduced.

Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
---
 Documentation/git-checkout.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-
checkout.txt
index 8e2c066..f74f237 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -81,13 +81,15 @@ Omitting <branch> detaches HEAD at the tip of the
current branch.
 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
 	When <paths> or `--patch` are given, 'git checkout' does *not*
-	switch branches.  It updates the named paths in the working
tree
-	from the index file or from a named <tree-ish> (most often a
-	commit).  In this case, the `-b` and `--track` options are
-	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
-	(i.e.  commit, tag or tree) to update the index for the given
-	paths before updating the working tree.
+	switch branches.  It copies the files matching the pathspecs in
+	<tree-is> (i.e. a commit, tag, or tree) to the index and
+	subsequently to the working directory, overwriting changes
+	(including deletion of files) in those files.  In this case,
the
+	-b and --track options are meaningless and giving either of
them
+	results in an error.  Note that because the index is updated,
the
+	changes introduced by this command are automatically
staged.  If
+	no tree-ish is provided, the current index is used and remains
+	unchanged, modifying only the working directory.
 +
 'git checkout' with <paths> or `--patch` is used to restore modified or
 deleted paths to their original contents from the index or replace
paths
-- 
2.7.4

