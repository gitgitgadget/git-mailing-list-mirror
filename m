From: Tim Chase <git@tim.thechases.com>
Subject: Proper URI for "svn clone" on a network share (Win32)
Date: Wed, 14 Aug 2013 12:49:33 -0500
Message-ID: <20130814124933.77b51a04@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 14 21:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9gMd-00074M-Nb
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 21:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932972Ab3HNTEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 15:04:07 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:36290 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932946Ab3HNTEG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Aug 2013 15:04:06 -0400
X-Greylist: delayed 4554 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2013 15:04:05 EDT
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:43235 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1V9fB5-000GLQ-9m
	for git@vger.kernel.org; Wed, 14 Aug 2013 12:48:11 -0500
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232311>

I've been sparring with the proper syntax and hope someone can give
me the magic I'm missing.  I want to do something of the form

  c:\temp> git svn clone "file:///x:/path/to/repo/trunk/utils/project1"

but get various failures.  My best-effort (above) gets me as far as
actually starting some sort of clone but it dies with

"""
Permission denied: Can't open '/tmp/report.tmp': Permission denied 
at /usr/lib/perl5/site_perl/Git/SVN.pm line 1210
"""

If it makes any difference, this is within a cmd.exe shell (with $PATH
set appropriately so git is being found).

Am I missing something in the URL syntax to get it to clone my svn
repo with less drama?

-tkc

PS: I don't really care much about pushing back to svn, existing
svn branches or tags, or username mapping.  If needed, I can apply
patches out of git which is far less painful than switching/merging
branches in svn.  So I can be a little rough-shod with cloning the
svn repo.

PPS: in case it matters:
C:\work\utils\temp\ios>git version
git version 1.8.3.msysgit.0



.
