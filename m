From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:11:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_7L8lV6FqO/MEokXICJot5Q)"
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 04:11:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3kF-0003np-23
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214Ab0A3DL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 22:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756213Ab0A3DL1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 22:11:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17331 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0A3DL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 22:11:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX1002SXI6LLH80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 22:11:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138432>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_7L8lV6FqO/MEokXICJot5Q)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 29 Jan 2010, Mark Lodato wrote:

> On Fri, Jan 29, 2010 at 8:22 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 29 Jan 2010, Mark Lodato wrote:
> >
> >> Still, I find it slightly confusing and unfriendly.  How about the following?
> >
> > It is slightly inaccurate.
> 
> Is the following the only inaccuracy?  Do you have any other feedback?
> 
> >> Checking out commit 'master^0'.
> >>
> >> Since this is not a local branch head, any commits you make will be lost
> >> when you check out another branch or commit.  (In git terminology, HEAD
> >> is detached.)  If you just wish to look at files without committing,
> >> this is fine.  If you wish to make commits and retain them, you may
> >> create a new branch by running:
> >>
> >>   git checkout -b <new_branch_name>
> >
> > This gives the impression that any commit you make on a detached HEAD
> > are going to be lost, unless you create a new branch first.
> 
> What about "...you may want to create..."?  This does not imply that
> creating a new branch now is the *only* way, just the most likely.  If
> a user knows another way, that user probably does not need this
> warning in the first place.

Still, you don't know what way the unsuspected user will take to get 
there.

Do you still have a problem with the latest version of the text from 
Junio?  Looks like you based your modification on an earlier version.


Nicolas

--Boundary_(ID_7L8lV6FqO/MEokXICJot5Q)--
