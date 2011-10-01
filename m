From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] test-ctype: add test for is_pathspec_magic
Date: Sat, 01 Oct 2011 18:39:58 +0200
Message-ID: <4E87425E.10606@lsrfire.ath.cx>
References: <4E87417E.1060100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 18:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA2bq-0007ds-Ex
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 18:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1JAQkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 12:40:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:55667 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1JAQkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 12:40:12 -0400
Received: from [192.168.2.104] (p4FFD8E7C.dip.t-dialin.net [79.253.142.124])
	by india601.server4you.de (Postfix) with ESMTPSA id 2E2B32F803A;
	Sat,  1 Oct 2011 18:40:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E87417E.1060100@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182565>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 test-ctype.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/test-ctype.c b/test-ctype.c
index b4d1f74..707a821 100644
--- a/test-ctype.c
+++ b/test-ctype.c
@@ -36,6 +36,7 @@ int main(int argc, char **argv)
 	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
 	TEST_CLASS(is_glob_special, "*?[\\");
 	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
+	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
 
 	return rc;
 }
-- 
1.7.7
