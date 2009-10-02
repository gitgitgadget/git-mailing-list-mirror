From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] filter-branch: add --prune-empty to option summary
Date: Thu,  1 Oct 2009 20:52:11 -0400
Message-ID: <1254444731-6852-1-git-send-email-adambrewster@gmail.com>
References: <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
Cc: Adam Brewster <adambrewster@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 02:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtWTu-00087b-KZ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 02:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbZJBA6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 20:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbZJBA6h
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 20:58:37 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:32925 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbZJBA6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 20:58:36 -0400
Received: by qyk3 with SMTP id 3so571841qyk.4
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=bkIMotwxMw3YdmWf9XZrkH4m0KwMzIyt3PtdVNKyKeU=;
        b=hN/tjf+3UngurRoFoOWggjFS/N8HrhDD0NG1et6JlxHRpoiFQvWdbnRQMs5MpAwrKC
         2O+3HY5KFP5wvG5CYqiOE5/JzqSYwfM+JY2Tfa2OHpNvtozM4WpPgI5l21DAZbQPCzX4
         LXbCd7LxmJEFl5hyhrUzXENeaJ6tQAHepUFr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y63zFn2CF84aoX8WfJ2kS+ox7VlheyCuxCYK79j9Qzh8mtgo3d8bmThnjC6lEYHT2V
         0KshOfMxwlZRhArRo5JzaE2ewI+l4J8fxabr91rbNa3/fR5y5j1HO+iLNbRQelahi7ai
         JIOK6EjsZYI/bGBFhPD1hcuuaONLP8sUY7Hlc=
Received: by 10.229.42.208 with SMTP id t16mr2603113qce.14.1254444734004;
        Thu, 01 Oct 2009 17:52:14 -0700 (PDT)
Received: from MBE.internal (c-24-61-131-49.hsd1.nh.comcast.net [24.61.131.49])
        by mx.google.com with ESMTPS id 7sm18526qwb.41.2009.10.01.17.52.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 17:52:13 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id 4C9C4104B37; Thu,  1 Oct 2009 20:52:11 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129419>

Signed-off-by: Adam Brewster <adambrewster@gmail.com>
---
 Documentation/git-filter-branch.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 451950b..2cc3bd8 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
+	[--prune-empty]
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--] [<rev-list options>...]
 
-- 
1.6.0.6
