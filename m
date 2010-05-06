From: Dave Abrahams <dave@boostpro.com>
Subject: Instead of rebasing, etc....?
Date: Thu, 6 May 2010 22:42:15 +0000 (UTC)
Message-ID: <loom.20100507T003055-527@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:42:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9m4-0001VF-PG
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab0EFWm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:42:27 -0400
Received: from lo.gmane.org ([80.91.229.12]:53569 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632Ab0EFWm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:42:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OA9lw-0001SJ-4O
	for git@vger.kernel.org; Fri, 07 May 2010 00:42:24 +0200
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 00:42:24 +0200
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 00:42:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.223.249 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146507>

I often find myself pursuing a development branch that I'm pushing out
to a public repo, and then wanting to go back a few commits and start
the end of the branch anew.

o-o-o-o origin/dev
      \
       o-o-o dev

Of course then I want to push dev and move origin/dev to refer to it.
So I delete and recreate origin/dev.  That's essentially like
rebasing, and all the advice says "don't do it."  How bad is that,
really, if it's my own development branch?

If I try to avoid doing that I guess I have to "merge" with the remote
branch but discard all its changes?

o-o-o-o - - - -o origin/dev dev
       \      / 
        o-o-o 


Is there a shortcut for that?  It would be nice if Git had a way to
note that sort of "false parentage" (the dotted line above)
explicitly; it's not really there logically; it just helps the
workflows to move along smoothly.
