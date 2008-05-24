From: Ilya Silvestrov <modjo@ngs.ru>
Subject: native (cyrillic) filenames in git-diff and git-log (qgit and gitk)
Date: Sat, 24 May 2008 21:45:37 +0700
Message-ID: <48382A11.2060308@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 16:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzv19-0007Ym-Pu
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 16:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYEXOpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 10:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbYEXOpx
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 10:45:53 -0400
Received: from smtpout1.ngs.ru ([195.93.186.195]:50541 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbYEXOpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 10:45:52 -0400
Received: from [192.168.112.102] (nat7.academ.org [89.31.118.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: modjo@ngs.ru)
	by smtp.ngs.ru (smtp) with ESMTP id AACC141512470
	for <git@vger.kernel.org>; Sat, 24 May 2008 21:45:38 +0700 (NOVST)
User-Agent: Mozilla-Thunderbird 2.0.0.12 (X11/20080420)
X-Anti-Virus: Kaspersky Anti-Virus for Sendmail with Milter API 5.6.20,
	 bases: 20080524 #799621, check: 20080524 clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82816>

Hi, All!

I'am looking for possibility to work with native (cyrillic) filenames in 
git. The problem I struggle with is that I'm unable to view filenames in 
readable form in git-log and git-diff. They are in escaped form, like this:
diff --git "a/\321\200\321\203\321\201\321\201\320\272\320\270\320\271" 
"b/\321\200\321\203\321\201\321\201\320\272\320\270\320\271"
new file mode 100644
index 0000000..69b7ded
--- /dev/null
+++ "b/\321\200\321\203\321\201\321\201\320\272\320\270\320\271"
@@ -0,0 +1 @@
+balabala

I was asking about this situation on #git irc channel and the answer was 
that this is as bug.
I'am working with git version 1.5.5.1

Silvestrov Ilya
