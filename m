From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git on Cygwin: Not a valid object name HEAD
Date: Tue, 07 Aug 2007 11:02:13 +0200
Message-ID: <f99cem$4a4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 11:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIL0c-0007uk-2a
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 11:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289AbXHGJFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 05:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757986AbXHGJFP
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 05:05:15 -0400
Received: from main.gmane.org ([80.91.229.2]:55858 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757248AbXHGJFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 05:05:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IIKzu-0004MA-6J
	for git@vger.kernel.org; Tue, 07 Aug 2007 11:05:02 +0200
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 11:05:02 +0200
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 11:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55235>

Hi,

I'm running git 1.5.2.2 under Cygwin on Windows XP. This is what I'm 
(reproducibly) getting if I try to clone QGit's repository:

sschuber@xp-sschuber2 ~
$ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git
Initialized empty Git repository in /home/sschuber/qgit4/.git/
remote: Generating pack...
remote: Done counting 2295 objects.
remote: Deltifying 2295 objects...
remote:  100% (2295/2295) done
Indexing 2295 objects...
remote: Total 2295 (delta 1793), reused 1218 (delta 955)
  100% (2295/2295) done
Resolving 1793 deltas...
  100% (1793/1793) done
: not a valid SHA1b870df7cde1e05ee76d1d15ea428f
fatal: Not a valid object name HEAD

sschuber@xp-sschuber2 ~
$ git --version
git version 1.5.2.2

I'm not sure whether the cause for this is the same as mentioned at

http://article.gmane.org/gmane.comp.version-control.git/54825

However, the most recent msysGit worked fine for me. Any clues whether 
this is a repository problem, a Cygwin problem, or a git problem?

Thanks.

-- 
Sebastian Schuberth
