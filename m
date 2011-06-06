From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Jabber, question on push,pull and --tags, and no help but
 jabber
Date: Mon, 6 Jun 2011 17:34:05 +0200
Message-ID: <20110606153405.GA15894@victor.terreactive.ch>
References: <20110606130205.GA41674@sherwood.local>
 <9215090.63086.1307370716794.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 17:34:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTbor-0006jH-DQ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 17:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569Ab1FFPeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 11:34:16 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:38067 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab1FFPeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 11:34:15 -0400
Content-Disposition: inline
In-Reply-To: <9215090.63086.1307370716794.JavaMail.trustmail@mail1.terreactive.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175129>

On Mon, Jun 06, 2011 at 04:31:50PM +0200, Michael J Gruber wrote:
> Steffen Daode Nurpmeso venit, vidit, dixit 06.06.2011 15:02:
> > Hello GIT,
> >     first paragraph is reserved for praising your existence.
> >     'Used cvs(1) for long years in small team projects with local
> >     private repos and never felt the need for anything else.  2011
> >     is different.  I first tried you but failed resoundingly.  Due
> >     to vim(1) and mutt(1) i discovered hg(1) and i still love it's
> >     simple usage.  'Talking about the front-end anyway.  It's huge
> >     memory consumption and slow performance forbids it's usage on
> >     our old PCs (e.g. Cyrix 166+) though.  So i came back and
> >     found you still receptive!  And the more i work, the less
> >     i hurt, the greater the knowledge, the smoother the
> >     interaction.  Are you the final word on RC in the end?
> > 
> > I stumbled over one thing i don't understand, because it seems
> > illogical: why do i need to use --tags to force pushing of tags?
> > Because there is even a config option for the latter, i suspect
> > this is because of intention.  It would be nice to get some
> > information on the background of that, like a link to yet existing
> > documentation.  Anyway i was a bit astonished to look at some
> 
> Tags may contain private information. Say you pull some changes from
> your head of group, find a strange commit you want to look at later and
> tag it with "what-is-this-crap"...

You could use the same argument about commit log messages, branch names
and code comments. No go ;)

> More seriously, tags are not part of the "remotes layout", so when you
> push them and others pull them they overwrite their tags if there's a
> name clash.

That's odd - I wouldn't expect anything handled by Git to be simply
overwritten without merging. Is there some technical reason for this, or
is it just not implemented yet?

If it makes more sense to casual users, how about simply making --tags
the default, and --no-tags optional?

Cheers
-- 
Victor
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
