From: Daniel Pittman <daniel@rimspace.net>
Subject: git-svn, and which branch am I on?
Date: Sat, 28 Feb 2009 19:50:08 +1100
Organization: I know I put it down here, somewhere.
Message-ID: <87ljrr7xof.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdL9e-0007s3-13
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbZB1JFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZB1JFM
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:05:12 -0500
Received: from main.gmane.org ([80.91.229.2]:60273 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbZB1JFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:05:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LdL82-0003hc-B0
	for git@vger.kernel.org; Sat, 28 Feb 2009 09:05:02 +0000
Received: from ppp59-167-189-244.static.internode.on.net ([59.167.189.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 09:05:02 +0000
Received: from daniel by ppp59-167-189-244.static.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 09:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ppp59-167-189-244.static.internode.on.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:c5PoOCuadr5grc1fblrDj5i9/Tk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111755>

G'day.

I recently got asked a question about git-svn that I had no idea how to
answer, and which I am actually curious to know how to find out.

The general question was: in git, how do I identify where this branch
came from?

Specifically, this was about 'git svn', but also generally how to
identify this information in git.

So, with a repository branch layout like this:

  master        (local)
  testing       (local)
  trunk         (remote)
  v100          (remote)

How would I find out which remote branch master and trunk came from?


To restate that, because I am not sure if that is clear, given this
layout of branches:

     trunk (remote)
     |
 o---o---o---o---o  branch master
  \
   \
    o---o---o---o branch testing
    |
    v100 (remote)

How can I identify that 'testing' came from the 'v100' branch, and that
master came from the 'trunk' branch?


Ideally, I would like to work this out on the command line, without
needing to reference gitk or another graphical tool, but even a solution
that used them would be fine.

Initially I figured there would be some equivalent of the Mercurial
'glog' output available, showing this; for reference the second and
third examples here are what I was envisaging:
http://www.selenic.com/mercurial/wiki/index.cgi/GraphlogExtension

(from that display I could infer where testing and master came from,
 rather than directly getting the answer, but that is just fine.)


...and, finally, is the reason that I am finding it hard to explain this
because I have an expectation of how things work that doesn't match up
with git?  In other words, is the question actually meaningless?

Regards,
        Daniel
