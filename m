From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 20:22:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 02:22:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb22q-0004MU-3P
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab0A3BWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086Ab0A3BWe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:22:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45102 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0A3BWe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:22:34 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX100575D5LK6O0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 20:22:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138419>

On Fri, 29 Jan 2010, Mark Lodato wrote:

> Still, I find it slightly confusing and unfriendly.  How about the following?

It is slightly inaccurate.

> Checking out commit 'master^0'.
> 
> Since this is not a local branch head, any commits you make will be lost
> when you check out another branch or commit.  (In git terminology, HEAD
> is detached.)  If you just wish to look at files without committing,
> this is fine.  If you wish to make commits and retain them, you may
> create a new branch by running:
> 
>   git checkout -b <new_branch_name>

This gives the impression that any commit you make on a detached HEAD 
are going to be lost, unless you create a new branch first.

And again, it is a good thing to have "detached HEAD" in there so to 
relate to existing documentation easily.

> I think the above wording is fine for both commits (e.g. master^0) and
> remote branches (e.g. origin/pu).  With other wording, we may wish to
> have two slightly different messages depending on what the user typed.

You could have tags too.  So instead of trying to be too smart, it is 
best to simply display the provided name without qualifier.

> Also, I am not a big fan of "local branch head".  How about "not the
> name of a local branch"?  I'm not sure...

The confusion that started this thread was about "master^" which might 
be interpreted as the name of a local branch except for the fact that we 
want one commit back.  So using "local commit head" is more precise.


Nicolas
