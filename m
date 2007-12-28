From: Eric Hanchrow <offby1@blarg.net>
Subject: generated HTML contains broken links
Date: Fri, 28 Dec 2007 15:49:31 -0800
Message-ID: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 29 03:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8RJZ-0000N3-Tn
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 03:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbXL2CUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbXL2CUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 21:20:16 -0500
Received: from main.gmane.org ([80.91.229.2]:40977 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbXL2CUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 21:20:15 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1J8RIw-0006EX-Ub
	for git@vger.kernel.org; Sat, 29 Dec 2007 02:20:02 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 02:20:02 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 02:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:myc4Kcu2ddBVa0EE19ewXa/od3M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69306>

I'm just starting to play with git, and have checked it out (with "git
clone git://git.kernel.org/pub/scm/git/git.git"), and built the
documentation (cd Documentation; make), on Cygwin.  I notice that the
generated HTML docs are full of broken links -- for example, my file
C:/cygwin/usr/local/src/git/Documentation/git.html includes this:

        git<a href="git-instaweb">1</a>

but there is no document named "git-instaweb" on my disk; instead,
it's named "git-instaweb.html".

I'm using asciidoc version 8.2.4, if it matters.
-- 
I write [from 5 AM to 7 AM] to discover what I think.  After
all, the bars aren't open that early.
        -- Daniel Boorstin, former Librarian of Congress
