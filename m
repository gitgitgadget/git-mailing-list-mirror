Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7831A20D0A
	for <e@80x24.org>; Sat, 27 May 2017 04:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdE0ExK (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 00:53:10 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:36150
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751971AbdE0ExB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 May 2017 00:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1495857232;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xq66JhL4UXl3gHOMVJSce32LxhTo4CHWiSCISMvX4Sg=;
        b=QkP8kLzftkpgRhH8UjaucJc/Q0aAiEXcjugex+SbnsOwnIwkqE218Fd4t456aaRb
        SnFT+hHzPesb72uoiM/y/NlhD/0E4dsQdmiT2q01jux/uMqUftE/eDIn3KkW3628Hgz
        yYNPjpd2X8KlZuIlKNju+4LzCHLkn0vsplnLACw0=
From:   Adrian <forbesa06@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c4809f8c7-a5cb604c-782d-4a10-87e1-2fe23e9989ba-000000@eu-west-1.amazonses.com>
Subject: [PATCH] change 'commands' to comments and improve wording
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 May 2017 03:53:52 +0000
X-SES-Outgoing: 2017.05.27-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-stash.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 70191d06b69e..3899d36b2bab 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -233,7 +233,7 @@ return to your original branch to make the emergency fix, like this:
 $ git checkout -b my_wip
 $ git commit -a -m "WIP"
 $ git checkout master
-$ edit emergency fix
+# ... edit emergency fix ...
 $ git commit -a -m "Fix in a hurry"
 $ git checkout my_wip
 $ git reset --soft HEAD^
@@ -245,7 +245,7 @@ You can use 'git stash' to simplify the above, like this:
 ----------------------------------------------------------------
 # ... hack hack hack ...
 $ git stash
-$ edit emergency fix
+# ... edit emergency fix ...
 $ git commit -a -m "Fix in a hurry"
 $ git stash pop
 # ... continue hacking ...
@@ -261,11 +261,11 @@ each change before committing:
 # ... hack hack hack ...
 $ git add --patch foo            # add just first part to the index
 $ git stash save --keep-index    # save all other changes to the stash
-$ edit/build/test first part
+# ... edit, build and test first part ...
 $ git commit -m 'First part'     # commit fully tested change
 $ git stash pop                  # prepare to work on all other changes
 # ... repeat above five steps until one commit remains ...
-$ edit/build/test remaining parts
+# ... edit, build and test remaining parts ...
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
 

--
https://github.com/git/git/pull/361
