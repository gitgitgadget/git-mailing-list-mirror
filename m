From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v2] Update 'git remote update' usage string to match man page.
Date: Sun, 15 Nov 2009 14:46:25 -0500
Message-ID: <32c343770911151146m82ac4a3p12ecc988da88ab6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>, finnag@pvv.org
X-From: git-owner@vger.kernel.org Sun Nov 15 20:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9l3d-0000va-Bo
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 20:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZKOTqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 14:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbZKOTqV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 14:46:21 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53423 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZKOTqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 14:46:20 -0500
Received: by bwz27 with SMTP id 27so5019739bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=uTkniSKzVhuGnKvNVszmlPgvOxcySLwa5+T8YJiYJx0=;
        b=GU9REKCh7FXXj2fhA6O7+jZ1Fu2pJP2NhQMeY1JarDawNz4PUtlRKd2gDvL1hNPKwc
         DPb6ybI3B0S47fXrF43xhkDZMUviHS/4XIrF/MR792nS8N9REFWvU39mjK1U+X9uPeE4
         5TaMDbadhw5gJx/aVE28nEkDvPjHMB4QUhEVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=MrPM+tl+pba0UU6qob+jXx7zHTFf8UDBkqmXYhuN2bbSbz0zLDf8BffGtyWKHVZGGI
         eF7sGs2xl6c5+FwUcLQQbclF3c7CGFkLTgDrAn9l6O4iyAkmwJFbSN1KoPpraPStxPz3
         3aA3ymq8Lm5ztu9Zmb3Sw306SADP6riXPMcFI=
Received: by 10.216.90.212 with SMTP id e62mr747233wef.26.1258314385240; Sun, 
	15 Nov 2009 11:46:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132954>

Commit b344e161 taught 'git remote update' to understand
[group | remote] as its argument.  The man page was updated
to document this change, but the usage string was not.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This updates the patch found at:
http://article.gmane.org/gmane.comp.version-control.git/132953

The change to the man page synopsis has been dropped.  This
patch now only updates the usage string in builtin-remote.c.

The author of commit b344e161 has been added to the CC list.

Based on advice from Junio, further changes to the usage string
and man pages will be explored in a separate patch series.


 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..c4edb86 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group]",
+	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
 	NULL
 };

-- 
1.6.5.2.185.gb7fba.dirty
