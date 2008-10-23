From: Francis Galiegue <fg@one2team.net>
Subject: git-cvsimport bug? Newly created branch not seen unless there's at least one commit in it
Date: Thu, 23 Oct 2008 14:01:09 +0200
Organization: One2team
Message-ID: <200810231401.09262.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 14:02:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksytl-0005lI-5G
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbYJWMBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbYJWMBN
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 08:01:13 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:34611 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbYJWMBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 08:01:13 -0400
Received: from erwin.olympe.o2t (pas75-3-82-235-191-170.fbx.proxad.net [82.235.191.170])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 33ACF92C024
	for <git@vger.kernel.org>; Thu, 23 Oct 2008 14:01:05 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98953>

Hello,

I've tried to git-cvsimport a module from CVS, where a branch named "foo" 
existed. CVSROOT set in the environment, CVS_RSH too, and I imported with:

git-cvsimport -k -a -C themodule themodule

However, it didn't do what I expected: I couldn't see the branch named "foo".

I had to make a commit using CVS on that very same module on that "foo" 
branch. After the commit, out of curiosity, I executed the same git command 
again in the same directory: this time the branch was seen.

Is this a bug, or is there a git-cvsimport option that I missed? I have looked 
at the manpage several times, and couldn't find what option could be of any 
use in my case (mind you, I haven't looked at the cvsps manpage either).

Thanks,
-- 
fge
