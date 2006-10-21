From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 20:58:25 +0200
Message-ID: <20061021185825.GC29927@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE> <4535345C.6090905@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 20:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbM3D-0000En-JI
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWJUS6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWJUS6U
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:58:20 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:16593 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964773AbWJUS6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:58:19 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 9159B4A86; Sat, 21 Oct 2006 20:58:25 +0200 (CEST)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <4535345C.6090905@utoronto.ca>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29658>

On Tue, Oct 17, 2006 at 03:51:56PM -0400, Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Sean wrote:
> > On Tue, 17 Oct 2006 00:24:15 -0400
> > Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> >>- - you can use a checkout to maintain a local mirror of a read-only
> >>  branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
> > 
> > 
> > I'm not sure what you mean here.  A bzr checkout doesn't have any history
> > does it?
> 
> By default, they do.  You must use a flag to get a checkout with no history.

If I can add some clarification: There is a lightweight checkout and
heavyweight checkout. The former contains no history and does everything
(except status and I am not sure about diff) by accessing the remote
data. The later contains mirror of the history data and does
write-through on commit (and otherwise behaves like normal branch with
repository)

What would be really useful would be a checkout, or even a branch (ie.
with ability to commit locally), that would only contain history data
since some point. This would allow downloading very little data when
branching, but than working locally as with normal repository clone.

In bzr this was already discussed and the storage supports so called
"ghost" revisions, whose existence is known, but not their data. There
are even repositories around that contain them (created by converting
data from arch), but to my best knowledge there is no user interface to
create branches or checkouts with partial data.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
