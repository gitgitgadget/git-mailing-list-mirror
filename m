From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git add: trivial codestyle cleanup
Date: Tue, 24 Feb 2009 23:59:03 +0200
Message-ID: <1235512745-26814-2-git-send-email-felipe.contreras@gmail.com>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 23:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5L0-0004k8-7R
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760420AbZBXV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760319AbZBXV72
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:59:28 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48790 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760213AbZBXV71 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:59:27 -0500
Received: by bwz5 with SMTP id 5so6205604bwz.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Si/7o5KkQAbq0iNt2GZyrT9Ng2E1/pMAkfe7B1/CpWM=;
        b=vN8XMosqCfu/nlXAQ0R34FzhiTCbF173QJwTUeggQcIE+fdv16G9dvk3GAqMQePtZ3
         PwROboCOvTy1NPkc0z7eTGc1yRKuFnvoYvprlLfK7sVUXtPiB1ev4XFW3mNqEjRbdY9Q
         7Y3iA3vAJ9936M12SRxlh+WsnZfQYzotSRd+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jq875D2gMmc1waRVBUokQXpEhfIiP7xpiLBI9/RLJu0U7y6vKL6WuUipsFmZMWqu11
         ubPYglvxzJPx7SiT1x3PxxSO/EGmPPmZmJzi0mYlGLJeZ9Xdy2BD+NKO4T8a2yLOjdqm
         xUK1G8WLw8aGXezWNeH2qKY3vEIw5Aulo9AKY=
Received: by 10.223.113.9 with SMTP id y9mr172252fap.19.1235512763720;
        Tue, 24 Feb 2009 13:59:23 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm4377835fks.5.2009.02.24.13.59.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:59:10 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111350>

Global static variables don't need to be initialized to 0/NULL.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index ac98c83..08443f2 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -15,7 +15,7 @@ static const char * const builtin_add_usage[] = {
 	"git add [options] [--] <filepattern>...",
 	NULL
 };
-static int patch_interactive = 0, add_interactive = 0;
+static int patch_interactive, add_interactive;
 static int take_worktree_changes;
 
 static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
-- 
1.6.1.3
