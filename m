From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/3] Adding Beyond Compare as a merge tool, was: Re: What's
 cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 26 Feb 2011 11:49:40 +0100
Message-ID: <4D68DAC4.9060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: charles@hashpling.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 11:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHir-0006nL-Rn
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab1BZKt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:49:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:36397 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab1BZKt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:49:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PtHil-0006kT-S5
	for git@vger.kernel.org; Sat, 26 Feb 2011 11:49:55 +0100
Received: from p5ddb01ed.dip0.t-ipconnect.de ([93.219.1.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 11:49:55 +0100
Received: from sschuberth by p5ddb01ed.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 11:49:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb01ed.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167974>

This is the follow-up to

http://marc.info/?l=git&m=129871641232007&w=2

and an alternative to the proposed

cp/mergetool-beyondcompare

Sebastian Schuberth (3):
   mergetool--lib: Sort tools alphabetically for easier lookup
   mergetool--lib: Add Beyond Compare 3 as a tool
   mergetool--lib: Add the proper executable name for ECMerge

  Documentation/git-difftool.txt         |    4 +-
  Documentation/git-mergetool.txt        |    4 +-
  Documentation/merge-config.txt         |    8 +-
  contrib/completion/git-completion.bash |    2 +-
  git-gui/lib/mergetool.tcl              |  101 +++++++------
  git-mergetool--lib.sh                  |  250 
+++++++++++++++++---------------
  6 files changed, 198 insertions(+), 171 deletions(-)

-- 
1.7.3.2.msysgit.6.dirty
