From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/3] sh-i18n--envsubst: do not crash when no arguments are
 given
Date: Mon, 06 Jun 2011 08:59:10 +0200
Message-ID: <4DEC7ABE.6070000@viscovery.net>
References: <4DEC7A65.7020207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 08:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTTmQ-000301-IY
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 08:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab1FFG7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 02:59:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37207 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab1FFG7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 02:59:13 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QTTmK-0006BE-5D; Mon, 06 Jun 2011 08:59:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E908C1660F;
	Mon,  6 Jun 2011 08:59:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEC7A65.7020207@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175095>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 sh-i18n--envsubst.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 2eb0ee4..47a306f 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -74,6 +74,7 @@ main (int argc, char *argv[])
 	{
 	case 1:
 	  error ("we won't substitute all variables on stdin for you");
+	  break;
 	  /*
 	  all_variables = 1;
       subst_from_stdin ();
-- 
1.7.6.rc0.1186.gfb4fd
