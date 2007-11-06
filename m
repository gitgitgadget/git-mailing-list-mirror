From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 08:38:41 +0100
Message-ID: <20071106073841.GB3021@steel.home>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <7vd4uomfn8.fsf@gitster.siamese.dyndns.org> <18223.46848.109961.552827@lisa.zopyra.com> <20071106004601.GS8939@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, Bill Lear <rael@zopyra.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 08:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJ1h-0002qY-DJ
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbXKFHir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 02:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbXKFHir
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 02:38:47 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:49557 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbXKFHiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 02:38:46 -0500
Received: from tigra.home (Facbb.f.strato-dslnet.de [195.4.172.187])
	by post.webmailer.de (fruni mo23) (RZmta 14.0)
	with ESMTP id I0219fjA674m6H ; Tue, 6 Nov 2007 08:38:41 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9595C277AE;
	Tue,  6 Nov 2007 08:38:41 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 73A3A56D22; Tue,  6 Nov 2007 08:38:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071106004601.GS8939@artemis.corp>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz5CxQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63633>

Pierre Habouzit, Tue, Nov 06, 2007 01:46:01 +0100:
> On Tue, Nov 06, 2007 at 12:36:16AM +0000, Bill Lear wrote:
> > On Monday, November 5, 2007 at 15:33:31 (-0800) Junio C Hamano writes:
> > > Stop thinking like "I need to integrate the changes from upstream
> > > into my WIP to keep up to date."
> > >
> > > [...]
> > >
> > > Once you get used to that, you would not have "a dirty directory"
> > > problem.
> > 
> > I respectfully beg to differ.  I think it is entirely reasonable, and
> > not a sign of "centralized" mindset, to want to pull changes others
> > have made into your dirty repository with a single command.
> 
>   I agree, I have such needs at work.  Here is how we (very informally)
> work: people push things that they believe could help other (a new
> helper function, a new module, a bug fix) in our master ASAP, but
> develop big complex feature in their repository and merge into master
> when it's ready.
> 
>   Very often we discuss some bugfix that is impeding people, or a
> most-wanted-API. Someone does the work, commits, I often want to merge
> master _directly_ into my current work-branch, because I want the
> fix/new-API/... whatever.

How about merging just that "fix/new-API/... whatever" thing and not
the whole master, which should be a complete mess by now?

The way you explained it it looks like typical centralized workflow.
