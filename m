From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] git-show-branch.txt: document --date-order option
Date: Sat, 23 May 2009 15:14:20 -0700
Message-ID: <1243116860-25812-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 24 00:14:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7zU8-0001Gg-HP
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 00:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbZEWWOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 18:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbZEWWOX
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 18:14:23 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:46514 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbZEWWOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 18:14:22 -0400
Received: by pxi1 with SMTP id 1so1933073pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Tby30U3x17hE5/Syy3x98437AGoG4d6cXmJgQ7ABLZs=;
        b=cCr7JpYMJI95953MOiUhyNtsj+T8GpYr4UhxmXuc9Ez+9uxtKRVWzhLU1uFuxVhKZ6
         rHcxKRZhlb1ah4RyyrNLGQOFqe7kL7qWtEKfOFGDSA6vF92bGJwMqWeFXY7BcX1nx/vj
         Rbf49Mo1/g7LNcqmAsTiKiQuxT6DKCHVMec3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vfDFjc43lC4IOLohz/p+SvsDi7EZ1WpbFo/tzwQ6ACKi+RSJZ9ZTL5+eit+qBCgRis
         ISckcNZt0U/9SPk970BPPo/wO9HCzkagPJfFpfNeZ4fL2gUeika/zPqN6Cm9gKaf3xiu
         KOopM6jXCeaYVg55UsgCnOpzXoi7SPgxGgYCY=
Received: by 10.114.153.2 with SMTP id a2mr11014382wae.170.1243116864167;
        Sat, 23 May 2009 15:14:24 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id n9sm5510039wag.32.2009.05.23.15.14.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 15:14:23 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 15:14:20 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119803>

Copy the description of date-order from rev-list-options.txt, and then
reword it to be commit specific. While we're at it, put <rev> <glob>...
on a new line to not exceed 80 characters.
---
 Documentation/git-show-branch.txt |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index edd8f64..a68c3d0 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,10 +8,11 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git show-branch' [--all] [--remotes] [--topo-order] [--current]
+'git show-branch' [--all] [--remotes] [--topo-order | --date-order]
+		[--current] [--color | --no-color
 		[--more=<n> | --list | --independent | --merge-base]
-		[--color | --no-color]
-		[--no-name | --sha1-name] [--topics] [<rev> | <glob>]...
+		[--no-name | --sha1-name] [--topics]
+		[<rev> | <glob>]...
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
 DESCRIPTION
@@ -58,6 +59,11 @@ OPTIONS
         appear in topological order (i.e., descendant commits
         are shown before their parents).
 
+--date-order::
+	This option is similar to '--topo-order' in the sense that no
+	parent comes before all of its children, but otherwise commits
+	are ordered according to their commit date.
+
 --sparse::
 	By default, the output omits merges that are reachable
 	from only one tip being shown.  This option makes them
-- 
1.6.3.1.145.gb74d77
