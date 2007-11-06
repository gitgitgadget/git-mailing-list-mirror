From: Bill Priest <priestwilliaml@yahoo.com>
Subject: git-merge ignore specific files
Date: Tue, 6 Nov 2007 04:38:35 -0800 (PST)
Message-ID: <174134.11501.qm@web55007.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 13:38:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpNhk-0001L3-Cz
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbXKFMih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755471AbXKFMig
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:38:36 -0500
Received: from web55007.mail.re4.yahoo.com ([206.190.58.141]:41858 "HELO
	web55007.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751079AbXKFMig (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 07:38:36 -0500
Received: (qmail 11512 invoked by uid 60001); 6 Nov 2007 12:38:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=N/hWd+Bmow2hm0l9pZtNNmM+2uHWre1kfs8tAvRSK8rb82dzMdisXE1R02YV8d1436mckbuGdyr4g1UdQ+pN3cKzcsPYKM01Z86KyP1Kzp8q/sgNC5wv0I6EstoRFtsZ+mjteqkWs2rBV5qezuMjFJMlH9twi8lhtsYrj3yOEAc=;
X-YMail-OSG: BjlEF9wVM1k2j_Fg06KAfiNPveuJ96wz5Xh1L139cO4EMNNnmm0_CPSlOx6i5cuij88mJ7NaJifO_NV7axRA88fmHnEXa6SyOmM5XSyRHPm60JSArEJhoU3WlhoTOw--
Received: from [12.44.137.148] by web55007.mail.re4.yahoo.com via HTTP; Tue, 06 Nov 2007 04:38:35 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63670>

All,
  I have two branches that are slightly different and
most changes "belong" in both.  There are a handful of
files/directories that are disparate.  Is there any
way in git to tell it not to merge these files?  Kind
of like .gitignore but for merges.
  In addition I'd like a way to specify to git-merge
to leave all merged files unrecorded in the index. 
Then as I go through each file making sure that the
merge "makes sense" (not that git did the right thing;
but that I want the changes in both branches) that I
add the change to the index.
  I'm sure that I'm probably using git "incorrectly"
and I welcome suggestions for modifying my workflow to
a git style.

Any and all suggestions greatly appreciated,

Bill


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
