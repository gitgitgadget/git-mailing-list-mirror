From: Leandro Lucarella <llucarella@integratech.com.ar>
Subject: git citool/gui bug
Date: Wed, 30 Jul 2008 15:53:06 -0300
Organization: Integratech S.A.
Message-ID: <20080730185306.GV7616@integratech.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 21:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGur-0003uV-Am
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbYG3S7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYG3S7u
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:59:50 -0400
Received: from smtp-03.arnet.com.ar ([200.45.191.14]:53647 "HELO
	smtp-03.arnet.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753247AbYG3S7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:59:49 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jul 2008 14:59:48 EDT
Received: (qmail 12704 invoked from network); 30 Jul 2008 18:51:20 -0000
Received: from unknown (HELO integratech.dyndns.org) (190.136.125.249)
  by 0 with SMTP; 30 Jul 2008 18:51:20 -0000
Received: from scm.integratech.net (scm.integratech.net [192.168.0.2])
	by integratech.dyndns.org (Postfix) with ESMTP id F33CA67D8C
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 15:53:06 -0300 (ART)
Received: from localhost.localdomain (azazel.integratech.net [192.168.0.77])
	by scm.integratech.net (Postfix) with ESMTPS id DB1DBD12E6
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 15:53:06 -0300 (ART)
Received: from luca by localhost.localdomain with local (Exim 4.69)
	(envelope-from <llucarella@integratech.com.ar>)
	id 1KOGnK-0002BE-N8
	for git@vger.kernel.org; Wed, 30 Jul 2008 15:53:06 -0300
Content-Disposition: inline
X-Paranoid: Just because you're paranoid, don't mean they're not after you.
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90833>

Hi! I think I've hit a really silly bug in citool/gui:

1) mkdir test; cd test
2) git init
3) vi test.txt # add content
4) cat test.txt

===============
Hello World!!!!
===============

5) git citool
6) add the test.txt file to the index
7) see test.txt index diff

git citool shows:

new file mode 100644     # black
@@ -0,0 +1,5 @@          # blue
+                        # green
 ===============         # orange
+Hello World!!!!         # green
 ===============         # orange
+                        # green


Please Cc me, I'm not in the list.

Thank you!

-- 
Leandro Lucarella
Integratech S.A.
4571-5252
