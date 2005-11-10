From: Kevin Geiss <kevin@desertsol.com>
Subject: Re: git-archimport
Date: Thu, 10 Nov 2005 14:49:59 -0700
Message-ID: <20051110214959.GO9131@raven.localdomain>
References: <D92ED0A1-B83A-43C3-B39C-AA8A21934D7F@desertsol.com> <46a038f90511101332r3389734uc1aa1effd2898e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 22:51:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaKJ5-0001iL-SS
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 22:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVKJVuD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 16:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVKJVuD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 16:50:03 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:63390 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S932176AbVKJVuA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 16:50:00 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EaKIx-0006GF-Pj; Thu, 10 Nov 2005 14:49:59 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511101332r3389734uc1aa1effd2898e15@mail.gmail.com>
X-PGP-Key: http://www.desertsol.com/~kevin/gpg.txt
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11529>

ok. I tried this:

git-archimport kevin@desertsol.com--files/scripts--base kevin@desertsol.com--files/scripts--oco

and it always complains:

Cannot find patchset for 'kevin@desertsol.com--files/scripts--oco--0--patch-1' at /usr/bin/git-archimport line 784

I don't have any spaces or funny characters in filenames.

On Fri, Nov 11, 2005 at 10:32:12AM +1300, Martin Langhoff wrote:
> If the two branches are related, and you want the imported git
> branches to be related, do
> 
>    git-archimport arch-eduforge@catalyst.net.nz--2004/scripts
> 
> that will bring all the stuff under scripts. If there are other
> branches or projects there that aren't related or you don't  want to
> pull, do
> 
>    git-archimport arch-eduforge@catalyst.net.nz--2004/scripts--base \
>         arch-eduforge@catalyst.net.nz--2004/scripts--oco
> 
> In any case, you shoud never pass the last token (base-0). Also, if
> you have filenames with spaces or funny chars, you'll want a patch
> that I'm about to post.
> 
> If you don't mind having this discussion on git@vger, could you
> forward it there?
> 
> cheers,
> 
> 
> martin
> 
> On 11/11/05, Kevin Geiss <kevin@desertsol.com> wrote:
> > hello, I was trying out the git-archimport script, I have a question.
> >
> > say I have two branches in tla (in the same archive):
> >
> > scripts--base--0
> > scripts--oco--0
> >
> > and scripts--oco--0--base-0 was tagged from scripts--base--0--patch-2.
> >
> > I first tried importing only the base branch, that worked fine. then
> > I started a new directory, and tried this:
> >
> > git arch-import -v archive/scripts--base--0 archive/scripts--oco--0
> >
> > and it keeps complaning about not being able to find scripts--oco--0--
> > patch-1.  patch-1 is just a regular commit in the tla archive.
> > (patch-2 and patch-3 are merges from scripts--base)
> >
> > anyway, am I understanding the paradigm of the git-archimport script?
> > that I should expect it to be able to create a git repository for me
> > from these 2 branches?
> >
> > thanks for any info
> >
> 
