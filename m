From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 01:16:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711060115130.4362@racer.site>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org> <18223.46848.109961.552827@lisa.zopyra.com>
 <472FBB3F.8080307@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpD4U-0007Mc-2x
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbXKFBRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 20:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbXKFBRX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:17:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:36271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755469AbXKFBRX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 20:17:23 -0500
Received: (qmail invoked by alias); 06 Nov 2007 01:17:21 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp035) with SMTP; 06 Nov 2007 02:17:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/a08AYtJXam/eUBzTZ5hzHiyMF8cfH3oWP1IGo/v
	h726SqexTvTBQ1
X-X-Sender: gene099@racer.site
In-Reply-To: <472FBB3F.8080307@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63607>

Hi,

On Tue, 6 Nov 2007, Andreas Ericsson wrote:

> Bill Lear wrote:
> > On Monday, November 5, 2007 at 15:33:31 (-0800) Junio C Hamano writes:
> > > Aghiles <aghilesk@gmail.com> writes:
> > > 
> > > > Is there an "easier" way to pull into a dirty directory ? I am
> > > > asking this to make sure I understand the problem and not
> > > > because I find it annoying to type those 4 commands to perform
> > > > a pull (although some of my colleagues do find that annoying :).
> > > You need to switch your mindset from centralized SVN workflow.
> > > 
> > > The beauty of distributedness is that it redefines the meaning
> > > of "to commit".  In distributed systems, the act of committing
> > > is purely checkpointing and it is not associated with publishing
> > > the result to others as centralized systems force you to.
> > > 
> > > Stop thinking like "I need to integrate the changes from
> > > upstream into my WIP to keep up to date."  You first finish what
> > > you are currently doing, at least to the point that it is
> > > stable, make a commit to mark that state, and then start
> > > thinking about what other people did.  You may most likely do a
> > > "git fetch" followed by "git rebase" to update your WIP on top
> > > of the updated work by others.
> > > 
> > > Once you get used to that, you would not have "a dirty
> > > directory" problem.
> > 
> > I respectfully beg to differ.  I think it is entirely reasonable, and
> > not a sign of "centralized" mindset, to want to pull changes others
> > have made into your dirty repository with a single command.
> > 
> 
> I find it much more convenient to just fetch them. I'd rather see
> git-pull being given a --rebase option (which would ultimately mean
> teaching git-merge about it) to rebase already committed changes on
> top of the newly fetched tracking branch. It's being worked on, but
> rather slowly.

git-pull learning about --rebase does not mean teaching git-merge about 
it.  See my patch, which you (and others) failed to enthusiastically 
embrace, which is the sole reason it is stalled.

Ciao,
Dscho
