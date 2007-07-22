From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: A simpler approach to tracking directories
Date: Sun, 22 Jul 2007 17:45:40 -0400
Message-ID: <20070722214540.GA821@fieldses.org>
References: <85fy3hqtwl.fsf@lola.goethe.zz> <85abtola79.fsf@lola.goethe.zz> <20070722175731.GA16658@thunk.org> <85myxoi8fi.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjFL-0002U4-Mc
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbXGVVpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbXGVVpo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:45:44 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37586 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980AbXGVVpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:45:43 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1ICjFE-0000Y6-DK; Sun, 22 Jul 2007 17:45:40 -0400
Content-Disposition: inline
In-Reply-To: <85myxoi8fi.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53328>

On Sun, Jul 22, 2007 at 08:45:37PM +0200, David Kastrup wrote:
> Theodore Tso <tytso@mit.edu> writes:
> > One of the fundamental things which falls out of the "Git Tracks
> > Contents" mantra is that information which you expect to be pushed
> > forward future revisions (as opposed to metadata which is specific
> > to a commit, such as the Author and Committer of a patch, the Commit
> > log, etc.) *MUST* be information which is realized in the working
> > tree.
> 
> For every _file_ in the working tree, there is _one_ bit of
> information in the repository that is not in the working tree: namely
> whether git is tracking this file at all.

Actually, no.  The index just stores data for a given set of files.  You
can think of the set of files for which data is stored in the index as
the set that is "tracked", but there's no independent
"tracked/untracked" bit, and no way of marking a path as tracked without
also adding content at that path.

--b.
