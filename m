X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT 2] Branching and merging with git
Date: Mon, 4 Dec 2006 02:23:50 -0500
Message-ID: <20061204072350.GC28043@fieldses.org>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net> <20061120235136.4841.qmail@science.horizon.com> <20061204011958.GB28043@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 07:23:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061204011958.GB28043@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33169>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr8B9-0007jV-D0 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 08:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758992AbWLDHXx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 02:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758991AbWLDHXw
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 02:23:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:25231 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1758938AbWLDHXv
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 02:23:51 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gr8B4-00050q-Mn; Mon, 04 Dec 2006
 02:23:50 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

On Sun, Dec 03, 2006 at 08:19:58PM -0500, J. Bruce Fields wrote:
> That doesn't mean *you* need to do everything from scratch, but it would
> be helpful to figure out where this would fit in with the other
> documentation in a logical progression.  As a start, the first paragraph
> could say "before reading this, we assume you've read X, Y, and Z", and
> then the rest of the document could be audited to make sure that it
> didn't assume anything that isn't in X, Y, and Z.

By the way, I have some draft rough work on getting that introductory
documentation organized at

	git://linux-nfs.org/~bfields/git.git

See Documentation/user-manual.txt and Documentation/quick-start.txt.  I
think I've stolen a small amount of text from you--hope that's OK!

I have two ideas in mind:

	- The tutorial is supposed to a very quick "look what git can
	  do" document, but people also want it to really explain git,
	  prepare people to read the man pages, etc., which will make it
	  much longer over time.  So I'm trying to split out an
	  extremely concise "quick-start" guide (modelled partly on
	  Mercurial's) that doesn't even pretend to explain anything, and
	  a "user manual" that's much more verbose and tries to cover
	  the basics comprehensively.

	- A lot of people don't actually need to do commits or merges at
	  all--they just need to know how to clone a repository, check
	  out a few versions, etc.  (Witness the number of web pages
	  with "how to check out our latest code from CVS" out
	  there....) I'm also assuming most people are joining an
	  ongoing project instead of creating a new one.  So instead of
	  starting right away with init-db/add/commit, I'm putting off
	  actual "development" stuff till pretty late:

	  	1. clone
		2. checking out old versions, basic branch management
		3. keeping up-to-date with fetch
		4. bisect
		5. archaeology (commits DAG, git-log, ...)
		6. creating commits, index file
		7. resolving merges, pull
		8. publishing a public repository, push

	  etc.  I'm hoping you'd be interested in working together on
	  the last parts (7 and 8 especially).

Comments welcomed...

