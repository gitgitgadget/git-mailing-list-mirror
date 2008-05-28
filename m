From: Barry Roberts <blr@robertsr.us>
Subject: git-gui clone differs from command line
Date: Wed, 28 May 2008 09:21:40 -0600
Message-ID: <483D7884.2050407@robertsr.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 17:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1NUK-0005GW-28
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYE1PVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbYE1PVv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:21:51 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:36723
	"EHLO QMTA01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751084AbYE1PVu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 11:21:50 -0400
Received: from OMTA04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by QMTA01.westchester.pa.mail.comcast.net with comcast
	id X08B1Z02G0ldTLk510GY00; Wed, 28 May 2008 15:21:49 +0000
Received: from dalmuti.xactvalue.com ([76.27.63.88])
	by OMTA04.westchester.pa.mail.comcast.net with comcast
	id X3Mi1Z0041uEJYk3Q00000; Wed, 28 May 2008 15:21:44 +0000
X-Authority-Analysis: v=1.0 c=1 a=ytfXWsxltS4A:10 a=YnsGRhsuQbgBr_aXaIAA:9
 a=hK_ELcFtwo_-fHIsdiuQsT4NocUA:4 a=0oFHZcPLJ8YA:10
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83099>

After much mis-directed research, I finally figured out that cloning a 
repo (ssh://) with git-gui doesn't work exactly like 'git clone' from 
the command line.  The main difference is that 'git pull' doesn't work 
on master.  I get the error below.  Is that intentional, or are we doing 
something wrong?


 From ssh://blr@cvs2/var/git/iv
 = [up to date]      master     -> origin/master
 = [up to date]      mbn/xtol   -> origin/mbn/xtol
 = [up to date]      sprint2    -> origin/sprint2
 = [up to date]      sprint3    -> origin/sprint3
 = [up to date]      sprint4    -> origin/sprint4
 = [up to date]      xtol       -> origin/xtol
You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.master.remote = <nickname>
    branch.master.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
