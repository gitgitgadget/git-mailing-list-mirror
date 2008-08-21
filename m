From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Typo in implementation of pack protocol
Date: Thu, 21 Aug 2008 08:02:14 -0700
Message-ID: <20080821150214.GQ3483@spearce.org>
References: <1219314971-13445-1-git-send-email-mike@abacus.co.uk> <20080821145012.GN3483@spearce.org> <20080821170042.457e62f1@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike@abacus.co.uk>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Aug 21 17:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBh4-0004Zz-A9
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbYHUPCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbYHUPCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:02:16 -0400
Received: from george.spearce.org ([209.20.77.23]:55819 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbYHUPCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 11:02:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EE31138376; Thu, 21 Aug 2008 15:02:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080821170042.457e62f1@pc09.procura.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93162>

"H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
> On Thu, 21 Aug 2008 07:50:12 -0700, "Shawn O. Pearce"
> <spearce@spearce.org> wrote:
> 
> > Mike Ralphson <mike@abacus.co.uk> wrote:
> > > cgit's receive-pack.c has never had the corresponding typo.
> > > Fix up method and member names to match.
> > 
> > Whoops.  Thanks.
> >  
> > > -				if (line.equals("capabilties^{}")) {
> > > +				if (line.equals("capabilities^{}")) {
> > >  					// special line from git-receive-pack to show
> > >  					// capabilities when there are no refs to advertise
> 
> Wouldn't it be nice to stick to ANSI Comments?
> I bet AIX xlc will fall over very very fast here

AIX xlc compiles Java code?

This is JGIT, written in Java, not git.git, written in ANSI C...

-- 
Shawn.
