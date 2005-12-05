From: Petr Baudis <pasky@suse.cz>
Subject: Re: announce: git browser
Date: Mon, 5 Dec 2005 01:42:38 +0100
Message-ID: <20051205004238.GE22159@pasky.or.cz>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 05 01:43:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej4R0-0005XX-8G
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 01:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVLEAmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 19:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVLEAmX
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 19:42:23 -0500
Received: from w241.dkm.cz ([62.24.88.241]:48075 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932359AbVLEAmW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 19:42:22 -0500
Received: (qmail 19562 invoked by uid 2001); 5 Dec 2005 01:42:38 +0100
To: Artem Khodush <greenkaa@gmail.com>
Content-Disposition: inline
In-Reply-To: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13207>

  Hello,

Dear diary, on Mon, Dec 05, 2005 at 01:23:24AM CET, I got a letter
where Artem Khodush <greenkaa@gmail.com> said that...
> I'd like to announce experimental web interface for git,
> complementary to gitweb. It visualizes commit history graph
> and shows commit diffs.
> 
> See http://straytree.com/git-browser/GitBrowser.html?r=git

  quite interesting! I always dreamt (not intensively enough to go
myself and do it) about gitweb having gitk-like visualization, possibly
this might help. ;-)

  Couple of initial notes:

  * I would find it much nicer if you wouldn't "squeeze" all the day's
(except merge) commits together, but left them separate. Possibly a
switch to squeeze them, but I'm really not sure if it's even useful to
have.

  * The line graphics etc. might be more colourful and prettier. ;-)

  * Then it could have a "gitk mode" where the time flows vertically and
author+title+time is shown in each line. It turns out that this might
not be the prettiest, but it's really the most informative and useful
view, IMHO.

  * When I click on the little black box, the commit window disappears
before I manage to click on anything inside; I would intuitively expect
the reverse behaviour - that this happens when I don't click on the box.
Or that clicking on the box does not matter. *shrug* The web interface
with those windows popping up admitelly makes my mind somewhat
uncomfortable, but it's hard to pin-point down why.

  * Possibly, the commit information could be shown in a dedicated
screen area altogether. It also wouldn't obscure the view of the actual
diagram, and it would be more visible that it cutely highlights the
appropriate box based on the current commit you have your cursor on.

  * It looks too much like Feynman diagrams when the merge arrow
points slightly backwards; perhaps you could try to avoid that.

  * It doesn't seem to handle the UTF8 characters properly.

  Quite nice for starters, though! The diff viewer looks pretty slick,
too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
