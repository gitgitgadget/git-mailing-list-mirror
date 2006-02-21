From: Michael <barra_cuda@katamail.com>
Subject: gitk: error on find
Date: Tue, 21 Feb 2006 14:44:27 +0100
Message-ID: <200602211444.27162.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 21 14:45:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBXpN-0000G3-Jb
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 14:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWBUNpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 08:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWBUNpE
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 08:45:04 -0500
Received: from fe-3c.inet.it ([213.92.5.106]:25542 "EHLO fe-3c.inet.it")
	by vger.kernel.org with ESMTP id S1030282AbWBUNpD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 08:45:03 -0500
Received: from dial-up-mi-631.lombardiacom.it ([::ffff:212.34.227.123]) by fe-3c.inet.it via I-SMTP-5.2.3-521
	id ::ffff:212.34.227.123+8m6suWpgSG; Tue, 21 Feb 2006 14:44:55 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16530>

On GIT repository:

~/git$ git --version
git version 1.2.0
~/git$ gitk --all -d

if I search for "1.0.0" and hit "return", gitk gives:

error:

invalid command name "contmergediff"
invalid command name "contmergediff"
    while executing
"contmergediff $ids"
    (procedure "gettreediffline" line 14)
    invoked from within
"gettreediffline file5 c894168631e4b7da66ed3993a4c92380d38599a8"


...and goes to commit 8d712aafd2df3c1f5147a28947f98cefe667cf76, while the 
first commit containing "1.0.0" is c894168631e4b7da66ed3993a4c92380d38599a8

In general, pressing <return> instead of clicking "find", causes gitk to skip 
a commit (without other errors). This behaviour is present since (at last) 
GIT version 1.0.0.

Searching for "1.0.0" but clicking on "find" gives no errors.

I think "contmergediff" is an old procedure, but I don't know how to fix it 
(nor exactly what was meant to do). The error was first introduced with 
commit b77b02785d2f589ca336fc449ee1c27837263dac (it was a big change, so the 
"contmergediff" line was probably forgotten).
