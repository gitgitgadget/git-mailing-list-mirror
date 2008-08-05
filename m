From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/8] bash completion: Add completion for 'git mv'
Date: Tue, 5 Aug 2008 12:08:30 -0700
Message-ID: <20080805190830.GD27207@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 21:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQRuY-0001m7-6k
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762936AbYHETIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 15:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759219AbYHETIc
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 15:08:32 -0400
Received: from george.spearce.org ([209.20.77.23]:51215 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762936AbYHETIb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 15:08:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4FEE038420; Tue,  5 Aug 2008 19:08:30 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91455>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The missing patch 8.

-- 
Shawn.

--MGYHOYXEY6WxJCY8
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <lee.marlow@gmail.com>
X-Original-To: spearce@spearce.org
Delivered-To: spearce@spearce.org
Received: by george.spearce.org (Postfix, from userid 1000)
	id 38E8138420; Tue,  5 Aug 2008 05:50:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=4.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.4
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by george.spearce.org (Postfix) with ESMTP id C879838368
	for <spearce@spearce.org>; Tue,  5 Aug 2008 05:50:50 +0000 (UTC)
Received: by wf-out-1314.google.com with SMTP id 28so2372236wfa.16
        for <spearce@spearce.org>; Mon, 04 Aug 2008 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FqGQGd4bWlP4tXVbFr+Hq1MkYxKrwtwc+EV5nbC+wFY=;
        b=gD0k3dWtKzpv9l833t51pig87gHr5nWqZ1pEEY7t8KOSvlGazsIUXZMmNpdO7xm5J8
         3HPwAog2xvECs63e3VcMZKmqBxBXp3rQJGeZiI9bH3aDhb5mXsBFgH5BCQtEB1POlfMG
         X+VqkLubHnnxVocm34QaVUU189EGibCWXbB40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=miqyJkDn3Av8O3aKfjg4i+5K0H5GLbvOLznenm048tQQMb9p7lYBtVOTBPMKWfOmph
         vngQvP01cGWC6PZOELFVraD7BwG225nSfgLaovNDvYqO866XiMoy2Pk0yAdmidfOgJj9
         Z7YLUrBpDtxkxN4yfOw5V+7pR74L631APs3nU=
Received: by 10.142.242.11 with SMTP id p11mr5272292wfh.217.1217915450634;
        Mon, 04 Aug 2008 22:50:50 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:50 -0700 (PDT)
From: Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 8/8] bash completion: Add completion for 'git mv'
Date: Mon,  4 Aug 2008 23:50:38 -0600
Message-Id: <1217915438-6838-9-git-send-email-lee.marlow@gmail.com>
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-8-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-5-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-7-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-8-git-send-email-lee.marlow@gmail.com>

Added completions for all long options specified in the docs
        --dry-run

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 936cd35..57b8c0f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -983,6 +983,18 @@ _git_merge_base ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_mv ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--dry-run"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_name_rev ()
 {
 	__gitcomp "--tags --all --stdin"
@@ -1615,6 +1627,7 @@ _git ()
 	ls-tree)     _git_ls_tree ;;
 	merge)       _git_merge;;
 	merge-base)  _git_merge_base ;;
+	mv)          _git_mv ;;
 	name-rev)    _git_name_rev ;;
 	pull)        _git_pull ;;
 	push)        _git_push ;;
-- 
1.6.0.rc1.48.g2b6032


--MGYHOYXEY6WxJCY8--
