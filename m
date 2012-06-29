From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jn/perl-makemaker-leading-paths] perl/Makefile: Fix a missing
 double-quote
Date: Fri, 29 Jun 2012 10:07:44 +0200
Message-ID: <4FED6250.7010103@viscovery.net>
References: <1339781427-10568-1-git-send-email-adam@roben.org> <20120615180505.GH10752@burratino> <7vwr388dyp.fsf@alter.siamese.dyndns.org> <20120615230234.GA3547@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <adam@roben.org>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:08:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkWFH-0003tK-0q
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 10:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab2F2IH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 04:07:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26296 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2F2IHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 04:07:53 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SkWGM-0002LP-FA; Fri, 29 Jun 2012 10:09:10 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C3C151660F;
	Fri, 29 Jun 2012 10:07:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120615230234.GA3547@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200809>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 perl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Makefile b/perl/Makefile
index 2e8f980..6ca7d47 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -61,7 +61,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 			subdir=/$${i%/*}; \
 		fi; \
 		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
-		echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)'$$subdir >> $@; \
+		echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)'$$subdir'"' >> $@; \
 		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
 	done
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
-- 
1.7.11.1.1304.g11834c6
