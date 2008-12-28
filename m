From: Hannu Koivisto <azure@iki.fi>
Subject: gitk Branch: field problem with 1.6.1
Date: Sun, 28 Dec 2008 18:53:51 +0200
Organization: NOYB
Message-ID: <83eizsckbk.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 17:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGyvN-00083H-Vg
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 17:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYL1QyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 11:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYL1QyK
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 11:54:10 -0500
Received: from main.gmane.org ([80.91.229.2]:52153 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbYL1QyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 11:54:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGytx-0004mU-0u
	for git@vger.kernel.org; Sun, 28 Dec 2008 16:54:05 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 16:54:05 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 16:54:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:VxkDbzYJjJRz79kZ+bCcXnfIxvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104053>

Greetings,

If I create a test repository as follows...

mkdir gitktest
cd gitktest
git init
echo foo > foo
git add foo
git commit -m "foo"
echo bar >> foo
git add foo
git commit -m "bar"
git checkout -b branch HEAD~1
echo baz > baz
git add baz
git commit -m "baz"
echo baz >> baz
git add baz
git commit -m "more baz"
git checkout -b debug2
echo baz >> baz
git add baz
git commit -m "even more baz"

...and with gitk --all look at the "more baz" commit, it says
"Branch: debug2" as shown here
<http://www.iki.fi/azure/tmp/gitk-test1.png>.  My understanding is
that it should show "Branches: branch, debug2" but I might be wrong
of course.

I have another test repository (I can make a creation recipe or
make the repository available for download if needed) where, in
addition to the problem above, gitk shows empty "Branch:" field for
the master branch's tip commit.

Both tests made with 1.6.1 on Linux.

-- 
Hannu
