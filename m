From: Petr Baudis <pasky@suse.cz>
Subject: History rewriting swiss army knife
Date: Fri, 24 Mar 2006 15:08:31 +0100
Message-ID: <20060324140831.GY18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 24 15:08:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMmxs-00015D-V7
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 15:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWCXOIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 09:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWCXOIa
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 09:08:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58040 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932624AbWCXOI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 09:08:29 -0500
Received: (qmail 1956 invoked by uid 2001); 24 Mar 2006 15:08:31 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17919>

  Hi,

  it is not very frequent, but sometimes you really want to rewrite your
history - you need to get rid of a copyright violation or a file with
confidential information slipped through, or who knows what other good
reason you might have. As long as you are aware of the implications of
all the tree/commit ids getting different, why not.

  It's never been so easy before - I've written cg-admin-rewritehist,
which will execute your filters for each commit (which can rewrite the
tree contents, just the tree itself through the index, committer/author
information and commit message) while the script will obviously preserve
all the other information like merges, author/committer information etc.
The script will place the rewritten history on a newly created branch.

  If you are interested, you can also look at the script at

	http://kernel.org/git/?p=cogito/cogito.git;a=blob;f=cg-admin-rewritehist

but it has few Cogito dependencies.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
