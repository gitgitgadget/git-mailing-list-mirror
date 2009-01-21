From: Daniel Barkalow <barkalow@iabervon.org>
Subject: GUI and detatched HEAD (was Re: Deleting remote branch pointed by
 remote HEAD)
Date: Wed, 21 Jan 2009 17:56:43 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901211705280.19665@iabervon.org>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <slrngnedkm.apk.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2068634625-1232578603=:19665"
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:58:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPm1R-0002YC-Sk
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbZAUW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZAUW4p
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:56:45 -0500
Received: from iabervon.org ([66.92.72.58]:49699 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbZAUW4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:56:44 -0500
Received: (qmail 4565 invoked by uid 1000); 21 Jan 2009 22:56:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2009 22:56:43 -0000
In-Reply-To: <slrngnedkm.apk.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106696>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2068634625-1232578603=:19665
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jan 2009, Sitaram Chamarty wrote:

> On 2009-01-21, Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
> 
> > I deleted a remote branch which was pointed by HEAD, this way: "git
> > push origin :master"
> >
> > Then for almost every git command, I get this error: "error:
> > refs/remotes/origin/HEAD points nowhere!".
> >
> > I found this situation non-friendly. Fortunately, I could understand
> > what's going on. But a new user might be confused.
> 
> That's a pretty advanced command for a beginner.  I have
> people who're only using the GUI (in the presumption that it
> will be less confusing or less powerful or whatever) and
> have managed to right click on a remote branch, choose
> "checkout this branch" and have made commits on it without
> knowing they're not on any branch!

I wonder if the GUI could handle this in a way that users would 
understand. This is qualitively like following a link to a spreadsheet in 
your web browser, having the browser launch your office suite and load the 
spreadsheet off the web; now you're interacting with a spreadsheet where 
you obviously can't save to the original location (which is some web site) 
and haven't provided a local filename to save as.

I think the right thing would be to show it as "(Untitled)" and have a 
prominant button to make a real saved branch out of it. There's nothing 
all that strange about having a current "document" that has no filename 
yet; the strange thing is that a version control system has this 
capability.

	-Daniel
*This .sig left intentionally blank*
--1547844168-2068634625-1232578603=:19665--
