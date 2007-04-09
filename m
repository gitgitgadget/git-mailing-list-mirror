From: =?iso-8859-1?Q?Thomas_H=FChn?= <newsgroups@thomas-huehn.de>
Subject: incorporating the past
Date: Mon, 09 Apr 2007 20:14:17 +0200
Message-ID: <87d52d1kli.fsf@mid.thomas-huehn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 21:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HayYG-0004GL-Vr
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXDISZN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXDISZM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:25:12 -0400
Received: from main.gmane.org ([80.91.229.2]:34481 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbXDISZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:25:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HayY2-0001vN-AC
	for git@vger.kernel.org; Mon, 09 Apr 2007 20:25:02 +0200
Received: from p54a0df24.dip.t-dialin.net ([84.160.223.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 20:25:02 +0200
Received: from newsgroups by p54a0df24.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 20:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54a0df24.dip.t-dialin.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:6+tc6nLiH7bWqJMA+oOK8tfcFKs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44063>

Hi

I have looked through some git tutorials and the manual, and what is
interesting me most right now is, how do I handle a situation like this
with git? It's purely speculative, I don't have such a situation in
reality, so my description might be a bit murky...

I'll try to make an extremely simple example, just one file, no
branching etc.

I have a file under version control, that I got at the point of file
version 1.0. I start committing changes:

o--o--o--o--o--o--o
^                 ^
git init,         current,
version 1.0       version 1.6

Then I get the history up to my version 1.0 from somewhere else (former
maintainer, whatever). In the form of plain text files, one for each
version; say, versions 0.1 thru 0.9. I want to incorporate this past
into my tree.

Can I just do another git init for 0.1, commit the changes up to 1.0 and
merge those two histories? Don't I need a common ancestor for both or
something like that?

Or can I do the same, only up to 0.9 instead of 1.0, and then "sew
together" those histories?

Is there some kind of "add-past", where the changed contents in the
working directory are prepended, not appended to the history? So that I
could "prepend" 0.9, then 0.8 and so on until 0.1?

I guess, I just don't have a clear grasp of what "history" and "branch"
and so on mean.

Thomas
