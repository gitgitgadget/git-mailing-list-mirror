From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: git checkout branch puzzle
Date: Sat, 1 May 2010 17:55:47 +0000 (UTC)
Message-ID: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 20:01:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Gzr-00005i-Hv
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab0EAR4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:56:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:57998 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab0EAR4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:56:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8Guz-0004kK-LW
	for git@vger.kernel.org; Sat, 01 May 2010 19:55:57 +0200
Received: from 86.16.6.62 ([86.16.6.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 May 2010 19:55:57 +0200
Received: from chris.cheney.nospam by 86.16.6.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 May 2010 19:55:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 86.16.6.62
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146103>

I have been using msysgit (curently 1.7.0.2.msysgit.0) for about 18 months 
and thought that I had managed to understand most things. However, the 
following sequence has me baffled:

a) on branch 'master', git status shows that the working directory is clean

b) git checkout HEAD^ gives the usual moan about moving to a head which 
isn't a local branch

c) git checkout master followed by git status gives "changed but not 
updated" and a list of "modified" files

d) git reset --hard does not change the situation

I suspect the situation arose as a result of 'mv'ing some files without 
using git mv, but the resulting state above seems unreasonable.

Any explanation of (c)/(d) would be appreciated.

As a result, I have started using git add -A rather than got add . (and 
wonder why it isn't documented as the default thing to do).

TIA for any light on this.
