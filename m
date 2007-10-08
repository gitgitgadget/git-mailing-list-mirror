From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 8 Oct 2007 02:06:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080204140.4174@racer.site>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
 <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
 <Pine.LNX.4.64.0710080018270.4174@racer.site>
 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
 <Pine.LNX.4.64.0710080028301.4174@racer.site>
 <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>
 <Pine.LNX.4.64.0710080129480.4174@racer.site> <20071008010033.GA25654@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 03:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieh5C-00013d-CD
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 03:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213AbXJHBGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758103AbXJHBGm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 21:06:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758222AbXJHBGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 21:06:41 -0400
Received: (qmail invoked by alias); 08 Oct 2007 01:06:39 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp038) with SMTP; 08 Oct 2007 03:06:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19N0DctSkZNJJVRB14P4zlN5s7SGnhocR53PdXC6y
	CzlsTx+MNfAnn1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071008010033.GA25654@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60272>

Hi,

On Sun, 7 Oct 2007, J. Bruce Fields wrote:

> On Mon, Oct 08, 2007 at 01:34:07AM +0100, Johannes Schindelin wrote:
> > It does what it should do.  It is _your_ task to look at refs/original/* 
> > if everything went alright.  Then you just delete the checked refs.
> 
> It seems odd to me, by the way, that filter-branch has its own 
> home-grown backup mechanism.  Lots of other commands can "lose" commits, 
> but none of them keep an extra backup like this.

The rationale was this: filter-branch recently learnt how to rewrite many 
branches, and it might be tedious to find out which ones.  But then, there 
is git log --no-walk --all, so maybe I really should get rid of 
refs/original/*?

I'd like to have some comments from the heavier filter-branch users on 
that...

Ciao,
Dscho
