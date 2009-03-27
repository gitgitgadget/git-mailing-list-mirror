From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] builtin-send-pack.c: avoid empty structure initialization
Date: Thu, 26 Mar 2009 21:37:53 -0500
Message-ID: <5dTED0fgBNPRxaQcq2Yx362_Ykx8_d294JWsQ989AjNLfL5kjzWRBnuVa1D9jLmvQzvhAD5NPfY@cipher.nrlssc.navy.mil>
References: <vllV2KFOw2fPeT48N4ZHBW8HPcTVqhWLjdDJnF8chb2m9lcTJFlnjPZc-WBSwqdoNvvZc5cQ0A4@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 03:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln1z9-0002VO-J1
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 03:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbZC0CiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 22:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbZC0CiI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 22:38:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39212 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZC0CiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 22:38:07 -0400
Received: by mail.nrlssc.navy.mil id n2R2c2nN028935; Thu, 26 Mar 2009 21:38:02 -0500
In-Reply-To: <vllV2KFOw2fPeT48N4ZHBW8HPcTVqhWLjdDJnF8chb2m9lcTJFlnjPZc-WBSwqdoNvvZc5cQ0A4@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 27 Mar 2009 02:38:01.0541 (UTC) FILETIME=[0C345750:01C9AE85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114844>

The IRIX6.5 MIPSpro Compiler doesn't like it.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Signed version, sorry.


 builtin-send-pack.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 91c3651..d5a1c48 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -10,8 +10,7 @@ static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
-static struct send_pack_args args = {
-};
+static struct send_pack_args args;
 
 static int feed_object(const unsigned char *sha1, int fd, int negative)
 {
-- 
1.6.2.16.geb16e
