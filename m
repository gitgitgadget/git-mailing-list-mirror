From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git and file name case on cygwin
Date: Sun, 4 Feb 2007 16:01:31 +0100
Message-ID: <20070204150131.GA15726@uranus.ravnborg.org>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com> <Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org> <7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Niklas =?iso-8859-1?Q?H=F6glund?= <nhoglund@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 16:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDjNg-0002eY-G6
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 16:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbXBDPeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 10:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbXBDPeI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 10:34:08 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:56444 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbXBDPeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 10:34:07 -0500
X-Greylist: delayed 1939 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Feb 2007 10:34:07 EST
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 63A22800A67;
	Sun,  4 Feb 2007 16:01:13 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id D33EB580D2; Sun,  4 Feb 2007 16:01:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38693>

On Sat, Feb 03, 2007 at 05:38:16PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 3 Feb 2007, Junio C Hamano wrote:
> > 
> > Are there plans to "fix" the confusion by renaming them to
> > reduce chances of name clashes on such suboptimal filesystems?
> 
> I don't think so. Nobody really does development on such broken 
> filesystems, and I kind of have this nagging suspicion that Niklas noticed 
> just because he wanted to test git, not because he really wanted to do 
> Linux development under Windows ;)

At my present work we do all development under Windows and this is what
we have used since day one. Shifting the underlying OS to Linux last
year should not and did not trigger a development environment revolution
(read: change to Linux).

But it would still be preferable to actually build the Linux kernel on
Windows so there is no need to do a remote build for part of the
system and the rest on the Windows host.
Or in other words to make the kernel build able on Windows does not imply
the desire to actually do kernel development on Windows.

	Sam
