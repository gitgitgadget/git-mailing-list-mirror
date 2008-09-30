From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (Sep 2008, #04; Mon, 22)
Date: Tue, 30 Sep 2008 11:28:40 -0700
Message-ID: <20080930182840.GD21310@spearce.org>
References: <20080929184709.GB21310@spearce.org> <81b0412b0809300400i164525ealce8a3ff8dabf783@mail.gmail.com> <81b0412b0809300545m7bc39fb8v2a724c05141d8d37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 20:29:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkjyr-0001Lt-5F
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 20:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYI3S2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYI3S2l
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 14:28:41 -0400
Received: from george.spearce.org ([209.20.77.23]:37137 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYI3S2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 14:28:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BF8723835F; Tue, 30 Sep 2008 18:28:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0809300545m7bc39fb8v2a724c05141d8d37@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97138>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 2008/9/30 Alex Riesen <raa.lkml@gmail.com>:
> > 2008/9/29 Shawn O. Pearce <spearce@spearce.org>:
> >> Here are the topics that have been cooking.  Commits prefixed
> >> with '-' are only in 'pu' while commits prefixed with '+' are
> >> in 'next'.
> >
> > Would you mind adding the remove_path factorization patches
> > in there somewhere?
> >
> > http://marc.info/?l=git&m=122246984212129&w=4
> > http://marc.info/?l=git&m=122246997012269&w=4
> 
> Oh, I see: they're in your master

Yea.  They were trivial enough that I didn't see a reason to hold
off on applying them.  That section of code has been difficult to
deal with merge conflicts on, due to all of the code moving around.
Ironically enough, its the merge code itself that is ugly to
merge... ;-)

-- 
Shawn.
