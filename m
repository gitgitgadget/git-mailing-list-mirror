From: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
Subject: git-svn and logging.. new to git
Date: Wed, 5 Mar 2008 09:22:33 +0000 (UTC)
Message-ID: <fqloop$ll$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 10:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpsl-0000l0-O0
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757048AbYCEJZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757399AbYCEJZK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:25:10 -0500
Received: from main.gmane.org ([80.91.229.2]:43088 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048AbYCEJZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:25:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JWpry-0001Fk-WA
	for git@vger.kernel.org; Wed, 05 Mar 2008 09:25:03 +0000
Received: from pool-71-161-44-24.clppva.east.verizon.net ([71.161.44.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 09:25:02 +0000
Received: from kt-usenet by pool-71-161-44-24.clppva.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 09:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-161-44-24.clppva.east.verizon.net
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76203>

I'm in the process of moving to git from subversion and I've run into
something I just don't understand.  I've moved one project from subversion
using git-svnimport and that went successfully.  Unfortunately the latest
git doesn't include svnimport so I'm trying to do the same thing with
git-svn.  It seems to have worked without any problem, but when I do "git
log"  I don't see all the entries I see when I do "svn log" on the same
project in subversion.  So, now I have to ask myself, "have I lost changes
in the import?"  

The command I used to import the source code is:

 git-svn clone file:///home/kt/oldsvn/Personal/Projects/Journal \
 --trunk=trunk --branches=branches --tags=tags

Am I doing something wrong here?  Do I need additional options on the
git-log command?  

Any explanation or assistance would be greatly appreciated.  

Thanks.

