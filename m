From: Paul Mackerras <paulus@samba.org>
Subject: Re: git cherry-pick feature request
Date: Wed, 23 Aug 2006 23:07:33 +1000
Message-ID: <17644.21269.128308.313284@cargo.ozlabs.ibm.com>
References: <17643.62896.396783.890223@cargo.ozlabs.ibm.com>
	<7vfyfnixv5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 15:08:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFsSN-000450-75
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 15:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWHWNHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 09:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWHWNHk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 09:07:40 -0400
Received: from ozlabs.org ([203.10.76.45]:4817 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932454AbWHWNHj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 09:07:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 89EBE67C3D; Wed, 23 Aug 2006 23:07:38 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyfnixv5.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25916>

Junio C Hamano writes:

> Quiet sounds sane.
> 
> Reverting to its "previous state" I am not quite sure if it is
> worth making it an option and run it as part of cherry-pick.

OK.  If the git cherry-pick terminates with an error I'll get gitk to
show the error message (if any) it printed along with a warning that
the working directory might need to be cleaned up.  I don't really
want to do a git reset automagically since the user might have local
modifications that they want to preserve.

While I'm asking for features, another one that would be really useful
for another tool I'm writing is a 3-way diff for a file between the
working directory, the index, and the current head commit, something
like what git diff-tree -c does for merges.  That is, it would have
two columns of +/-/space characters, one for the current head and one
for the index.  A '-' would indicate that the line appears in the
current head or the index but not in the version of the file in the
working directory.  A '+' would indicate that the line appears in the
working directory version.

How hard would it be to adapt the git diff-tree -c mechanism to work
on two blobs plus the file from the working directory?

Thanks,
Paul.
