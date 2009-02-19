From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/6] Improve error message for git-filter-branch
Date: Thu, 19 Feb 2009 16:03:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902191602520.6223@intel-tinevez-2-302>
References: <200902190736.35364.johnflux@gmail.com> <43d8ce650902190619u149b4619k3f9e08bc1e5869f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 16:06:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaASm-0008Mm-Mm
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 16:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZBSPDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 10:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZBSPDu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 10:03:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:36775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751425AbZBSPDu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 10:03:50 -0500
Received: (qmail invoked by alias); 19 Feb 2009 15:03:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 19 Feb 2009 16:03:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ngL8Zw3GnYD+gEEHCXhf957zGl89A/JAvFcwnr4
	hML50ZYZIwjkF2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <43d8ce650902190619u149b4619k3f9e08bc1e5869f8@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110708>

Hi,

On Thu, 19 Feb 2009, John Tapsell wrote:

> 2009/2/19 John Tapsell <johnflux@gmail.com>:
> > Tell the user that a backup (original) already exists, and how to solve
> > this problem (with -f option)
> 
> 
> "Oh, and also all are:
> Signed-off-by: John Tapsell <johnflux@gmail.com>"

Might be nice to resend it so that the maintainer has less work, no?

Also might be nice to cut the complete crap after the only piece of 
information in your mail:

> 
> > ---
> >  git-filter-branch.sh |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 27b57b8..1ca45e2 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -226,7 +226,8 @@ while read sha1 type name
> >  do
> >        case "$force,$name" in
> >        ,$orig_namespace*)
> > -               die "Namespace $orig_namespace not empty"
> > +               die "Cannot backup - a previous backup already exists in $orig_namespace\n" \
> > +                   "Force overwriting the backup with -f"
> >        ;;
> >        t,$orig_namespace*)
> >                git update-ref -d "$name" $sha1
> > --
> > 1.6.2.rc1.3.g7d31b.dirty
> >
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
