From: linux@horizon.com
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: 13 Jan 2008 10:05:41 -0500
Message-ID: <20080113150541.21883.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sun Jan 13 16:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE4Pl-0003Uz-NR
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 16:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbYAMPFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbYAMPFo
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 10:05:44 -0500
Received: from science.horizon.com ([192.35.100.1]:14644 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751223AbYAMPFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 10:05:43 -0500
Received: (qmail 21884 invoked by uid 1000); 13 Jan 2008 10:05:41 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70386>

> What does "Renames Support" mean? Does it mean that when browsing history
> we [can] show file / directory renames? Does it mean that log of file or
> directory history [can] follow renames? Does it mean that line-wise file
> history [can] follow renames? Renames support in merges is as TODO, so
> I don't think that this one matters in this question. Because the answer,
> especially in the case of git which is a bit different in that it does
> rename detection and not rename tracking (using inodes / file-ids),
> depends on that...

Let me make a bolder statement: a person asking for "rename support"
has been mentally damaged by using CVS too much.

CVS's fundamental problem is that it's a tree of versioned files.  So a
file has to have a well-defined identity across versions, so CVS uses
the name, and that leads to problems if you rename the file.

And this is fundamentally broken.  Both git and subversion do it right:
a repository is a versioned tree of files.  Files don't have versions, but
rather versions have files.  With this model, the problem Just Goes Away.
It doesn't exist any more.  There's nothing to solve, nothing to do.

"Rename support" is a kludge to make a fundamentally broken model
less painful.  Git doesn't have the problem, and so doesn't need,
doesn't have, and doesn't want the kludge.  Indeed, as your questions
above show, it's hard to even define what it would be if it existed.
It's like asking if an electric light has a thoriated mantle, or inquiring
about the filament supply voltage of my mp3 player.

In all honesty, the correct answer is "no", git doesn't have that feature,
just like my laptop doesn't have a cooling water pressure sensor and
my solar-powered pocket calculator doesn't have a user-serviceable
mains fuse.

What's broken is the feature checklist.  Someone has to go and re-think
the issue in a less CVS-centric way.


Just in case I was not clear enough above:

	The need for a source file to have an identity
	that persists across multiple revisions is an
	artifact of CVS's implementation.  Anyone asking
	if a different version control system can preserve
	that identity across renames needs to learn that
	we now have ways of making light without fire.
