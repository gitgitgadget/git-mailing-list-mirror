From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Wed, 10 Jun 2009 21:49:02 +0200
Message-ID: <200906102149.03411.jnareb@gmail.com>
References: <200905291855.03328.jnareb@gmail.com> <200906102042.15119.jnareb@gmail.com> <20090610193016.GA13512@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1METnU-0000HQ-SG
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 21:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303AbZFJTtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 15:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761405AbZFJTtF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 15:49:05 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:33448 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760983AbZFJTtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 15:49:03 -0400
Received: by ewy6 with SMTP id 6so1313507ewy.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kqb9Ly1+04lDYl1qxj0O7NKjfOOpu2Sv/Ewb4TrDKIo=;
        b=SSB8vZq+yAn19Ih+eQWZ1yKKdS2mf2kRr0roCUdNM9tsVT+fsXGOwKCMPfsceLGiy/
         vWQiHdpOOCSUz/SqDooPwQ2V8r7hncQmU52Cek6zPiEpEP78eRpJAWElMOyqG6ICLEiY
         a2QZ6PpWvFAbmFEDw5R95tXsawJvZ5VSywo6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rMHQRSeP1M0kf9ndeW1lh1dIMRi1+O/IX/9IZvvF1pOGIjmwNK1d2m96VxR0joi1h2
         jah/vOvvBoWL20LrZOEB8pdS8GF3ezdlKzao+ICeOJ7TkpkofhVP6O/09D0tc7wvwLVF
         2ztEgZ5391joA9vOqB/G+SlAC53LyQZgtRGsQ=
Received: by 10.210.34.2 with SMTP id h2mr2109416ebh.72.1244663344488;
        Wed, 10 Jun 2009 12:49:04 -0700 (PDT)
Received: from ?192.168.1.13? (abvn21.neoplus.adsl.tpnet.pl [83.8.211.21])
        by mx.google.com with ESMTPS id 28sm149325eye.36.2009.06.10.12.49.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 12:49:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090610193016.GA13512@m62s10.vlinux.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121299>

On Wed, 10 June 2009, Peter Baumann wrote:
> On Wed, Jun 10, 2009 at 08:42:13PM +0200, Jakub Narebski wrote:

> > ------------------------------------------------------------------
> > Git User's Survey 2009: proposed questions
> 
> [ ... leaving out some questions ... ]
> 
> > 11.*Which porcelains / interfaces / implementations do you use?
> >     (multiple choice: git (core), JGit, Cogito, pg, StGIT, Guilt,
> >     Easy Git, Pyrite, TopGit, other - please specify)
> > 12. Which of the following git tools do you use?
> >     (multiple choice: JGit (EGit etc.), Cogito, pg, StGIT, Guilt,
> >     TopGit, Easy Git, editor/IDE VC integration, gitk, git-gui,
> >     QGit, GitView, Giggle, tig, git-sh, instaweb, git-cola / ugit,
> >     GitNub, GitX, GitTortoise, Git Extensions, git-cheetah, Gitosis,
> >     graphical diff tool, graphical merge tool, other - please specify)
> 
> Those two seems a little redundant. Could we combine those into
> 
>   11.Which porcelains / interfaces / implementations / tools do you use?
>      ...

Good idea.  It is hard to distinguish sometimes: JGit is Java 
implementation, developed alongside EGit Eclipse plugin;  Grit is
Ruby library, but also partial implementation, etc.

We would probably have place then for one free-form question:

11'.What tool would you like to have Git support in?
    (this includes language bindings / reimplementations)

> > 16. Which of the following features do (or did) you use?
> >     (multiple choice: non-default hooks, working with dirty tree,
> >     bisect, submodules (subprojects), integration with IDE/editor,
> >     multiple worktrees (git-new-worktree), gitattributes, stash,
> >     separate worktree / git.worktree, patch managemten interface
> >     (e.g. StGIT), alternates mechanism (sharing object database),
>                  ^ 
>                  | - TopGit, Quilt

Well, this was 'for example' (e.g.); also TopGit hails as topic branch
management and not as simply patch management.  You also probably meant
Guilt (formerly gq, Git Queues), not Quilt.

> > The trouble with "What editor, IDE or RAD you use working with Git?"
> > question is coming up with a good list of editors... and that such
> > list is of necessity fairly long.  Perhaps it would be better to
> > change it to more generic question
> >  10.*What kind of editor, IDE or RAD you use working with Git?
> >     (multiple choice: simple text editor[1], programmers editor[2],
> >     IDE or RAD[3], WYSIWYG tool[4], other kind - please specify)
> >     [1] for example pico, nano, joe, Notepad
> >     [2] for example Vim, Emacs, TextMate (syntax highlighting,
> >         autoindentation, integration with other tools, etc.)
> >     [3] for example KDevelop, Anjuta, MS Visual Studio, but also
> >         Quanta+, BlueFish or Screem for editing HTML, and Kile
> >         or LyX for LaTeX.
> >     [4] text processors such as MS Office or OpenOffice.org,
> >         but also tools such as Adobe Acrobat (for PDF) or GIMP
> >         (for images)
> > (if we are not to remove this question entirely).
> 
> If you leave the question, you might want to add Eclipse at the appropriate
> place.

Eclipse as example of IDE / RAD?  Yes, of course.

-- 
Jakub Narebski
Poland
