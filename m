From: Federico Mena Quintero <federico@novell.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 09:53:00 -0500
Message-ID: <1193064780.4522.142.camel@cacharro.xalalinux.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se>
	 <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>  <471C586A.9030900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjycW-0003mo-P8
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbXJVOu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXJVOu6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:50:58 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:39255 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbXJVOu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:50:57 -0400
Received: from [164.99.195.83] ([164.99.195.83])
	by jericho.provo.novell.com with ESMTP; Mon, 22 Oct 2007 08:50:46 -0600
In-Reply-To: <471C586A.9030900@op5.se>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62017>

On Mon, 2007-10-22 at 09:59 +0200, Andreas Ericsson wrote:

> I doubt many people on this list regularly use git-blame but it's a 
> command that's definitely non-trivial to script out using only the 
> "proper" commands, and CVS/SVN users expect it to be there, so it's 
> probably worth listing anyhow.

Hmmm, I don't really want to turn the "summary" thread into oodles of
sub-threads, but here goes :)

Personally I find git-blame *EXTREMELY* useful.  The workflow is:

1. Bug #12345 for FooApp gets assigned to you.

2. git-svn clone fooapp's repository

3. git checkout -b my-bugfix-branch-for-12345

4. debug debug debug

5. "WTF?  Who wrote this crappy code?"

6. git blame culprit-file.c

7. "Oh, it was $person with $commit_id... what were they thinking at the
time?"

8. git show $commit_id

9. "Oh, I see their intentions now... what was going on at that time?"

10. git log <date range around $commit_id>

11. etc.

Git-blame is very nice for code archaeology (long explanation at
http://mail.gnome.org/archives/desktop-devel-list/2007-September/msg00238.html).

> Similarly, it might be helpful to have help topics the gdb way, like 
> "git help patches".

This would be simply fantastic.  If those help topics suggested
workflows, I'd be delighted :)  Feel free to poke me if you write up
some text; I'd love to help on this.

  Federico
