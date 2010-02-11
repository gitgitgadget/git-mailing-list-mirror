From: Stephen Haberman <stephen@exigencecorp.com>
Subject: git-svn writing mergeinfo
Date: Thu, 11 Feb 2010 11:10:07 -0600
Message-ID: <20100211111007.b04e8f26.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 18:19:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfchh-00028F-Pv
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 18:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab0BKRTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 12:19:45 -0500
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:53002 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab0BKRTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 12:19:44 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 12:19:44 EST
Received: from relay1.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id B593B1278826
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 12:10:08 -0500 (EST)
Received: by relay1.relay.dfw.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 8C555127924C
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 12:10:08 -0500 (EST)
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139609>

Hi,

I just stumbled across the mergeinfo support coming in git 1.7. Looks
like very awesome stuff for those of us using git as a better-than-svn
svn client.

Trying 1.7-rc2 locally, I can see mergeinfo properties getting read.

But the killer feature of doing a git merge --no-ff/git svn dcommit
doesn't seem to generate and write mergeinfo properties back to svn.
Unless I'm doing something wrong.

Are there any plans for this, even if svn's model means only in
a limited form? E.g. no multi-parent/reflective/etc.

I was really surprised to learn that Bazaar writes mergeinfo back to
svn [1]--I had assumed a DAG-based DVCS would just never get that good
of svn interop. So, seeing that Bazaar does something like this gives
me hope that git could do it eventually as well.

Thanks,
Stephen

[1]: http://wiki.bazaar.canonical.com/BzrForeignBranches/Subversion
