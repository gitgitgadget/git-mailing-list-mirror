From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Change double quotes to single quotes in message
Date: Sat, 21 Mar 2009 11:08:12 +0200
Message-ID: <877i2j6y6b.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 10:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkxDj-0002O5-FK
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 10:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbZCUJIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 05:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbZCUJIc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 05:08:32 -0400
Received: from main.gmane.org ([80.91.229.2]:42276 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbZCUJIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 05:08:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LkxBp-0006ds-AJ
	for git@vger.kernel.org; Sat, 21 Mar 2009 09:08:25 +0000
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 09:08:25 +0000
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 09:08:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.91 (gnu/linux)
Cancel-Lock: sha1:gNW6N/kxCg1bl77i70fcU1y3qwU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114031>


>From 6daec692a39a1ecf0452f1ad1eb7ba6fbf5661c9 Mon Sep 17 00:00:00 2001
From: Jari Aalto <jari.aalto@cante.net>
Date: Sat, 21 Mar 2009 11:00:54 +0200
Subject: [PATCH] Change double quotes to single quotes in message

This helps selecting the text inside quotes by using mouse double-click
action (e.g. in Putty). Functions affected: update_refs_for_switch(),
update_refs_for_switch() and cmd_checkout().
---
 builtin-checkout.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9fdfc58..49daade 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -503,10 +503,10 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path))
-				fprintf(stderr, "Already on \"%s\"\n",
+				fprintf(stderr, "Already on '%s'\n",
 					new->name);
 			else
-				fprintf(stderr, "Switched to%s branch \"%s\"\n",
+				fprintf(stderr, "Switched to%s branch '%s'\n",
 					opts->new_branch ? " a new" : "",
 					new->name);
 		}
@@ -515,7 +515,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path)
-				fprintf(stderr, "Note: moving to \"%s\" which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}
-- 
1.6.1.3
