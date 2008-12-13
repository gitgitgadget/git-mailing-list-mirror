From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH] Let git remote accept up as alias to update
Date: Sat, 13 Dec 2008 21:18:56 +0300
Message-ID: <20081213181704.20126.4200.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 19:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBYxI-0006X8-Er
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 19:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbYLMSJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 13:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbYLMSJr
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 13:09:47 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:9972 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbYLMSJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 13:09:46 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1103344muf.1
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=8fhPSVb8XnMxCk9jFPW5JuEu6wrR73SRhogAdENNpzE=;
        b=nF/1VknBwwdrp9PsC1svHDMVabYb2nMnGiTSJya47f3mBgoNFcdTGgu849ooUhxFkp
         IU3pfUdk1MV2ba1RA1pACsaUefaaTBSGtXb31mfNoTCxFtupHwOcPs+4YqRKZL2TsFVW
         HhRb1kpFm+iM2H+VpBmaPqP1gL0+mZeX7VToE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:to:from:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=kLcuXSPMcVPtRYEFVaAGPH1DgfpfuQqL394v55bPmc3WVEMGLlmkXU4J8UN4h0+pbS
         PUXUKOoZc3QWk+kD1UxjV5Kt6UO8bTDurSwf+niYvcrwtccyq17XNLTNfn27blF3tulI
         MBFeo7CYUa8UkQmkovMfGwwHKUYD7lFRNv3dk=
Received: by 10.103.213.10 with SMTP id p10mr2343363muq.17.1229191784513;
        Sat, 13 Dec 2008 10:09:44 -0800 (PST)
Received: from zaytsev.su ([77.221.155.68])
        by mx.google.com with ESMTPS id j10sm8670512muh.57.2008.12.13.10.09.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 10:09:43 -0800 (PST)
User-Agent: StGit/0.14.3.292.gb975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103008>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---

Don't know why, but I keep typing remote up instead of
remote update. As update is probably by far the most
used remote action, can we please have this alias?

 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index abc8dd8..8f5cd6d 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -893,7 +893,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = show(argc, argv);
 	else if (!strcmp(argv[0], "prune"))
 		result = prune(argc, argv);
-	else if (!strcmp(argv[0], "update"))
+	else if (!strcmp(argv[0], "update") || !strcmp(argv[0], "up"))
 		result = update(argc, argv);
 	else {
 		error("Unknown subcommand: %s", argv[0]);
