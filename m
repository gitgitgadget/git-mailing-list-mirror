From: Gerrit Pape <pape@smarden.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9l aka 1.0rc4
Date: Wed, 7 Dec 2005 17:20:30 +0100
Message-ID: <20051207162030.18532.qmail@c9a97849515963.315fe32.mid.smarden.org>
References: <7vy831p69i.fsf@assigned-by-dhcp.cox.net> <20051205172601.4980.qmail@67565db8368c55.315fe32.mid.smarden.org> <7vu0dnb8pm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 17:21:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek21d-0000AJ-NK
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 17:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVLGQUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 11:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVLGQUE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 11:20:04 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:4485 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751198AbVLGQUC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 11:20:02 -0500
Received: (qmail 18533 invoked by uid 1000); 7 Dec 2005 16:20:30 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vu0dnb8pm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13330>

On Mon, Dec 05, 2005 at 12:16:37PM -0800, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > On Sun, Dec 04, 2005 at 01:21:13AM -0800, Junio C Hamano wrote:
> >> *1* It appears Debian finally has an official maintainer, so I
> >
> > Yes, I've taken over maintainership, and introduced the git-core package
> > into Debian/unstable, the git tools previously were included in the
> > cogito package.
> 
> This question is probably relevant only to you and people who
> want to build deb themselves until you package the updated
> upstream, but what is your (and others') preference on debian/
> directory in what _I_ ship?
> 
> I see three possibilities:
> 
>  - Do not care, and keep them as they are as they bitrot.
> 
>  - Remove debian/ from the upstream tree.
> 
>  - You feed patches to me, and I promise you not to touch
>    debian/ area, except adding a new -0 entry at the top of the
>    changelog when bumping the version number up, and perhaps
>    adjusting to the main Makefile changes if the solution is
>    obvious.
> 
> I am neutral between the second and the third.

Normally we suggest upstream to not ship a debian/ directory at all, and
I would prefer that.  But I can understand that people may got used to
it, and prefer to build the packages on their own.  So I'm also fine
with feeding you with patches, but need to get 0.99.9l into the Debian
archive first (already prepared, waiting in a 'new packages' queue), and
then adapt the build process to use the debian/ directory in the git
tarball, instead of the current tarball-in-tarball approach.

This may take some days, and there are major changes to the debian/
directory as I personally don't use the usual debhelper approach.

Thanks, Gerrit.
