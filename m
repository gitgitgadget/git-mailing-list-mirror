From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 22:13:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182211510.23902@racer.site>
References: <20071217110322.GH14889@albany.tokkee.org>
 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218154211.GB12549@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ki1-0008RI-Fa
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbXLRWOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXLRWOK
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:14:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:56151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753101AbXLRWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:14:08 -0500
Received: (qmail invoked by alias); 18 Dec 2007 22:14:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 18 Dec 2007 23:14:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187XC5CGks7fFbVF9Gu7qUh2fGmJImeGb/2g+S/gi
	1taIuPSMCOBx+d
X-X-Sender: gene099@racer.site
In-Reply-To: <20071218154211.GB12549@alea.gnuu.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68830>

Hi,

[please do not cull me from the Cc list, should you reply to this]

On Tue, 18 Dec 2007, J?rg Sommer wrote:

> Junio C Hamano schrieb am Mon 17. Dec, 16:31 (-0800):
> > Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> > 
> > >> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> > >>
> > >>> ...  The current behavior of git stash is very
> > >>> dangerous ...
> > > ...
> > >> This is a plain FUD, isn't it?  The first Oops should not happen 
> > >> these days.
> > 
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
> When it should go quick why don't use an alias. git stash can print the 
> list and everyone who wants a quick stash can create an alias for this.
> 
> I vote for stash print the list, because I dropped in the pitfall.

And in a fresh clone, this list is empty, showing nothing at all.  Leading 
the other half of the users to believe that the stash succeeded.

If stashing as the default operation of stash is ill-advised, showing the 
list is even more so.

Ciao,
Dscho
