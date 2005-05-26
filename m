From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 22:27:12 +0200
Message-ID: <20050526202712.GA6024@vrfy.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org> <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 22:26:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOv2-0001ts-D5
	for gcvg-git@gmane.org; Thu, 26 May 2005 22:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVEZU1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEZU1U
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 16:27:20 -0400
Received: from soundwarez.org ([217.160.171.123]:45261 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261632AbVEZU1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 16:27:16 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 1CF693A36D; Thu, 26 May 2005 22:27:12 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2005 at 06:45:14PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 26 May 2005, Kay Sievers wrote:
> >
> > On Mon, May 16, 2005 at 09:10:10AM -0700, Linus Torvalds wrote:
> > > 
> > > Then you could just do
> > > 
> > > 	git-rev-list -v --header HEAD | grep -z 'author[^\n]*Linus'
> > > 
> > > to tell it to do the "verbose" thing (only showing the header of the 
> > > commit, not the whole message), and grep for "Linus" in the author line.
> > 
> > What happened to that idea? That's not already working in some other way I
> > missed, right? The pickaxe stuff is nice and was easy to call from the cgi,
> > but searching in commit messages would be nice too.
> > If it's not going to happen in the git-binaries, I may do it just in the
> > cgi itself.
> 
> Ok, you twisted my arm. Checked in.
> 
> 	git-rev-list --header HEAD | grep -z 'author[\n]*Linus'

Nice, thanks. Here is a very first try. It searches the commit messages
and uses pickaxe to search in the file content:
  http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=symlink

Before someone asks: kernel.org needs to wait until cogito has catched up and
released a new version and it is installed on the machines.

Kay
