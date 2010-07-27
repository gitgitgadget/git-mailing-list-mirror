From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] commit: remove full stop from usage help for -u
Date: Mon, 26 Jul 2010 22:40:32 -0700
Message-ID: <1280209232-23864-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 07:40:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdcuL-0006yq-A8
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 07:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab0G0Fks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 01:40:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52982 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0G0Fks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 01:40:48 -0400
Received: by gwb20 with SMTP id 20so358198gwb.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=heUlq+sqU355bTc3Lgz0Hmx9mVGlY7mgD+W08uhn87k=;
        b=eAVGRk/J8PUMFeoHVSk10jRV+BNKAB6StOZ/cEqJYHPRGY75YRSf33vjwg9Cdgc6IZ
         My3mkKZ7mBAhQH4TfvTMrwaBnz6KCXVGU2GRpNtUnt0oHLuEPERRxMJ8vrogylRAMBJt
         sv62iL0lf2quXLrMIJZr0FUQqnxVyIyqpFmHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HQugUGeAksddgb8DUjyOBs6+3AGqhxUcnjVZU/4IXWEbuRUs7N12H4TqvJtsYZgBM4
         SasATQmgXcfc6jF6Uds4Ld95KJp8w5Pt+Fgrof0/8zHYBg/shU2A2SmMGobzWfSJ0XPB
         4vFwvbm34erAtcn2KJDTae3SOe3H8ucgRyEmo=
Received: by 10.150.56.32 with SMTP id e32mr10195749yba.218.1280209247242;
        Mon, 26 Jul 2010 22:40:47 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id f5sm4560961ybi.7.2010.07.26.22.40.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 22:40:46 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 26 Jul 2010 22:40:32 -0700
X-Mailer: git-send-email 1.7.2.19.g9a302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151911>

>From api-parse-options.txt:

  `description` is a short string to describe the effect of the option.
  It shall begin with a lower-case letter and a full stop (`.`) shall be
  omitted at the end.

It also makes it less confusing if the argument is 'no.' or 'no'.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c101f00..04f4c7d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -147,7 +147,7 @@ static struct option builtin_commit_options[] = {
 		    "terminate entries with NUL"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
-	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	/* end commit contents options */
 
 	{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
-- 
1.7.2.19.g9a302
