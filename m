From: Martin <html-kurs@gmx.de>
Subject: git svn fetch -with -r doesn't fetch anything
Date: Tue, 05 May 2009 22:18:30 +0200
Message-ID: <4A009F16.50107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 22:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1R6O-0001oq-5q
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 22:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZEEUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZEEUSq
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 16:18:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:42365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752425AbZEEUSq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 16:18:46 -0400
Received: (qmail invoked by alias); 05 May 2009 20:18:43 -0000
Received: from p54B2299A.dip0.t-ipconnect.de (EHLO [192.168.0.123]) [84.178.41.154]
  by mail.gmx.net (mp066) with SMTP; 05 May 2009 22:18:43 +0200
X-Authenticated: #4107867
X-Provags-ID: V01U2FsdGVkX19p+i8tnl9poloE5A2EKG3d61KiCsBqNcRvZfU7J1
	ZpJbXTOJhxioNU
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118312>

Hi,

I upgraded to:
 > git svn --version
git-svn version 1.6.2.5 (svn 1.5.6)

(svn 1.6.1 doesn't compile, see 
http://www.nabble.com/Re:-svn-commit:-r37415---trunk-subversion-include-td23170203.html 
:-( )

Now I create a git repositiory:
 > git svn init https://myserver.com/repo
and want to fetch the latest revision (or a little bit in the past) with
 > git svn fetch -r1234

But git svn rebase runs in an error:
 > git svn rebase
fatal: ambiguous argument 'HEAD': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions
log --no-color --first-parent --pretty=medium HEAD: command returned 
error: 128

With earlier version of git-svn I could fetch only a few revisions. Now only
 > git svn fetch
works. But it fetches *all* revisions (and this takes a while ...)

Is it a bug or a feature?

Thanks
Martin
