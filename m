From: Rob Landley <rob@landley.net>
Subject: Re: UI tweak suggestion for kernel.org git web gui.
Date: Mon, 21 Nov 2005 11:41:08 -0600
Organization: Boundaries Unlimited
Message-ID: <200511211141.08559.rob@landley.net>
References: <200511211019.51110.rob@landley.net> <20051121165522.GA3217@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 18:44:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeFfN-0003zG-Oa
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 18:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVKURlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 12:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVKURlO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 12:41:14 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:8879 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932399AbVKURlM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 12:41:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jALJFWQZ028841;
	Mon, 21 Nov 2005 14:15:32 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
User-Agent: KMail/1.8
In-Reply-To: <20051121165522.GA3217@vrfy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12461>

On Monday 21 November 2005 10:55, Kay Sievers wrote:
> On Mon, Nov 21, 2005 at 10:19:50AM -0600, Rob Landley wrote:
> > When I view the changelog at:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=sh
> >ortlog
> >
> > It mixes in tags, which is cool, but they're the same color as regular
> > commits.
>
> They are all commits. There is nothing "mixed". Tags usually just point
> to a commit.
>
> > Is there any way that tags could stand out visually?  (Bold them,
> > give them a different color background, etc.)
>
> You mean, you want to see in the list of commits, the ones marked, which
> a tag is pointing to? Similar to what gitk is doing?

I don't know what gitk is.

This shows tags on the bottom half of this page, with the last few commits in 
the top half:

http://www.kernel.org/git/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git;a=summary

If I click on the "..." under shortlog, I get to see a full page of commits, 
which does (currently) include the -rc2 tag.

My use case is I want to see what commits have gone in since the last tarball 
I downloaded.  (Waiting for various patches to be merged, etc.)  The tag 
indicates the last intentionally released (and thus minimally tested) 
tarball, so it would be nice if the tag's entry was visually distinct in the 
big list.

> > I'd try to ask this in the right place, but the above page doesn't even
> > say which git web display package kernel.org is using.  (A small discreet
> > link at the bottom would be nice...)
>
> There is no package for gitweb. Just the single gitweb.cgi file, which is
> copied there. You can get the gitweb version in the html source. Just do
> "view source" in your browser.

Ah:

<!-- git web interface v252, (C) 2005, Kay Sievers <kay.sievers@vrfy.org>, 
Christian Gierke <ch@gierke.de> -->

Good to know.

> Kay

Rob
