From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 08:19:54 +0200
Message-ID: <20070521061954.GB8605@xp.machine.xx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com> <20070520163026.GA7387@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon May 21 08:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1MD-0006TT-O0
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbXEUG04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbXEUG04
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:26:56 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:36931 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754563AbXEUG0z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2007 02:26:55 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2007 02:26:55 EDT
Received: (qmail 32357 invoked by uid 0); 21 May 2007 06:19:52 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 21 May 2007 06:19:52 -0000
Mail-Followup-To: Thomas Glanzmann <thomas@glanzmann.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
In-Reply-To: <20070520163026.GA7387@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47970>

On Sun, May 20, 2007 at 06:30:26PM +0200, Thomas Glanzmann wrote:
> Hello,
> 
> > For version information it is far more useful to use --tags or no options 
> > (annotated tags only) instead of --all.
> 
> so this output is useless if you don't have tagged the commit which
> isn't the case. But thanks for the awareness.
> 

No. Just _ONE_ tagged commit should be enough. In a project of mine I
tagged the root commit and as I am the only committer and this project
is so simple that I don't have to do a lot of branching/merging, I get a
single line of history

	t - o1 - o2 - o3 - o4 <- master
	^
	|- tagged root commit

This gives me very nicely enumerated commits like tag-1-g<sha1-abbrev> for
the commit o1 and tag-2-g<sha1-abbrev> for o2 ... you get the idea.

-Peter
