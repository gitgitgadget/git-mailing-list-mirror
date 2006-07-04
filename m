From: Jakub Narebski <jnareb@gmail.com>
Subject: qgit idea: marking refs (heads and tags)
Date: Tue, 04 Jul 2006 08:58:47 +0200
Organization: At home
Message-ID: <e8d3i6$ne9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 08:58:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxerd-0005xh-9I
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 08:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWGDG60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 02:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWGDG60
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 02:58:26 -0400
Received: from main.gmane.org ([80.91.229.2]:6369 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750962AbWGDG6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 02:58:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxerT-0005wX-Am
	for git@vger.kernel.org; Tue, 04 Jul 2006 08:58:19 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 08:58:19 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 08:58:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23261>

One thing I sorely lack in qgit as compared to gitk (and even gitweb[*1*])
is marking commits with refs (heads and tags, marked with different colors
or different shape marker). gitk currently uses markers in short log line
before text of commit summary, gitweb uses markers after (at the end) of
commit log summary. In qgit head commits are marked as such, but not to
which branche they belong[*2*].

And also somewhat (but to much lesser extent) showing explicitely sha1-ids
for commit, parents, tree, referenced object (in tag), to copy'n'paste to
shell.


[*1*] Currently _only_ in summary view IIRC, see e.g.
http://www.kernel.org/git/?p=git/git.git;a=summary
[*2*] gitk has also somewhat expensive "branches that commit belongs to" and
"closest tag(s) that are in lineage of this commit".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
