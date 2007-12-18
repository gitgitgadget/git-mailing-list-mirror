From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 12:33:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181231420.23902@racer.site>
References: <20071217110322.GH14889@albany.tokkee.org>
 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218105941.GA17251@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sebastian Harl <sh@tokkee.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4be3-0004yh-OT
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbXLRMdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbXLRMdT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:33:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:43801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755992AbXLRMdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:33:17 -0500
Received: (qmail invoked by alias); 18 Dec 2007 12:33:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 18 Dec 2007 13:33:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MxloppplMniXRKM/IbazJqf5Ja4VFNf1FCbJKqS
	6n6xzWdCuK2nzo
X-X-Sender: gene099@racer.site
In-Reply-To: <20071218105941.GA17251@albany.tokkee.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68738>

Hi,

On Tue, 18 Dec 2007, Sebastian Harl wrote:

> On Mon, Dec 17, 2007 at 04:31:12PM -0800, Junio C Hamano wrote:
> > But the original point by Sebastian hasn't been answered.  He wanted 
> > to make the command list the stash without arguments.
> > 
> > This was discussed already in the early days of stash and there indeed 
> > was a suggestion to do so (I think I sided with that), but the users 
> > did not want it.  IIRC, the argument went like: "when I say 'stash', 
> > that is because I want a quick and immediate way to stash, and I do 
> > not want a list.  If I do not have to have a quick way, I would create 
> > a temporary commit on the current branch, or switch to a temporary 
> > branch and commit there."
> 
> Well, "git stash save" is just five characters more - I really don't see 
> why this would be less comfortable (and for the really lazy people there 
> are still aliases...). On the other hand (if "list" is the default), 
> we'd get a more consistent interface which imho is imho more important 
> than typing five characters less.

It's more about what you're used to.  I had an alias named 'stash' long 
before it became a git command.  And now guess how _annoying_ it would be 
to type "git stash<Return><Curse out loud at my mouse>git stash 
save<Return>".

As you see, it is more than five characters more.

Ciao,
Dscho
