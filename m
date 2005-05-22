From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Kernel nightly snapshots..
Date: Sun, 22 May 2005 18:01:40 +0100
Message-ID: <20050522180140.A21384@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org> <1115305813.16187.143.camel@hades.cambridge.redhat.com> <1115307033.16187.146.camel@hades.cambridge.redhat.com> <427ABA45.3050803@zytor.com> <1115364543.29495.24.camel@localhost.localdomain> <427BE699.60802@zytor.com> <20050506215142.GA15357@logos.cnet> <20050522115038.GC15178@cip.informatik.uni-erlangen.de> <1116763160.19183.15.camel@localhost.localdomain> <20050522120954.GH15178@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 19:00:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZtoW-0008GB-2l
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVEVRBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVEVRBu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:01:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31245 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261832AbVEVRBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:01:46 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DZtpf-0002H3-Cc
	for git@vger.kernel.org; Sun, 22 May 2005 18:01:43 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DZtpc-0007S7-Hf
	for git@vger.kernel.org; Sun, 22 May 2005 18:01:41 +0100
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050522120954.GH15178@cip.informatik.uni-erlangen.de>; from sithglan@stud.uni-erlangen.de on Sun, May 22, 2005 at 02:09:54PM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 22, 2005 at 02:09:54PM +0200, Thomas Glanzmann wrote:
> Hello,
> 
> > That should be done against the 2.6 kernel, and that tree is already
> > available.
> 
> it is a shame that 2.6 doesn't even boot on this machine[1]. And even if
> the patch doesn't do its way upstream its good to have something like
> git available to to vendortracking.
> 
> 	Thomas
> 
> [1] http://bugzilla.kernel.org/show_bug.cgi?id=4415

This bugzilla entry unfortunately gives me two problems:

1. I don't know what a 2.6.x-hh kernel is, or what modifications there
   are from the 2.6 mainline kernel.

2. I don't have visibility of this jornada list, nor what diagnosis
   has been done so far.

It's also worth pointing out that the patch there is for a 2.4 kernel,
and therefore probably isn't suitable for 2.6 as is.

What I can say is that there's been very little flow of patches into
mainline for Jornada 7xx - the last attempt was back in January 2002.
Many of the problems from that time stemmed from me having a separate
tree, which caused the expectation that I would handle integration of
_anything_.  Since the -rmk tree is no longer a public offering, and
usable ARM support is merged into mainline, this expectation has been
removed.

What this does mean, however, is that from my point of view, Jornada
is a dead and unmaintained machine as far as 2.6 goes, and is ripe for
removal from the kernel source - the only reason it builds today is
because I've been tweaking it to keep it building.  Whether it actually
works or not is a completely different matter.

The way to stop it from being removed is for someone to step up and
maintain the thing in mainline.  How easy this would be is also
something I have no view on, since I've no idea what's outstanding,
nor what unmerged handhelds features Jornada 7xx depends on.

All in all, due to the above, I think submitting bugs for -hh kernels
to the mainline bugzilla is a worthless exercise unless they can be
proven to be relevant to mainline kernels.

Sorry.

-- 
Russell King

