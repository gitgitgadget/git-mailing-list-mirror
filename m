From: Kevin Ballard <kevin@sb.org>
Subject: Breakage caused by 2fe403e7 git-svn.perl: workaround assertions in svn library 1.5.0
Date: Tue, 8 Jul 2008 17:41:48 -0700
Message-ID: <6583867F-ED86-4E3D-AE8B-39FB974C43D7@sb.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, pape@smarden.org
X-From: git-owner@vger.kernel.org Wed Jul 09 02:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNm9-0002Yi-Ct
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYGIAmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbYGIAmU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:42:20 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:35175
	"EHLO randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752519AbYGIAmT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 20:42:19 -0400
Received: from [192.168.1.80] (adsl-76-199-69-6.dsl.pltn13.sbcglobal.net [76.199.69.6])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id B8B22109E8B;
	Tue,  8 Jul 2008 17:42:18 -0700 (PDT)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87822>

Commit 2fe403e7 causes `git svn info` and `git svn info .` to break.

   Use of uninitialized value in localtime at /usr/local/libexec/git- 
core/git-svn line 4277.
   No such file or directory at /usr/local/libexec/git-core/git-svn  
line 897.

If it makes a difference, I have svn 1.4.4 installed, not svn 1.5.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
