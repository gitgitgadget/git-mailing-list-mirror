From: Petr Baudis <pasky@suse.cz>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 21:55:27 +0100
Message-ID: <20060214205527.GF31278@pasky.or.cz>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org> <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org> <20060214202728.GE31278@pasky.or.cz> <Pine.LNX.4.63.0602142136250.23659@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:54:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97C8-0004ke-BH
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWBNUym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWBNUym
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:54:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:24013 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161085AbWBNUyl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 15:54:41 -0500
Received: (qmail 7764 invoked by uid 2001); 14 Feb 2006 21:55:27 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602142136250.23659@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16173>

  Hi,

Dear diary, on Tue, Feb 14, 2006 at 09:37:39PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Tue, 14 Feb 2006, Petr Baudis wrote:
> 
> > [...]
> >
> > It works by creating a new branch cg-seek-point and storing the seeked
> > point there; if HEAD is already on the branch, it merely changes the
> > seek point and resets the working tree appropriately. cg-seek without
> > any arguments will then return to your original head, whose name was
> > stored in .git/head-name.
> 
> And if you want to prevent accidental commit, just "chmod a-w 
> $GIT_DIR/index".

  currently, Cogito has a generic "blocking" mechanism which will
prevent you to do operations mutating the history (mostly committing and
mergnign) - seeking is the only user now.

  Note that this is not very flexible and I consider this legacy stuff;
I will replace that by a specific check for a seek when I have some time
(which will also make it compatible with the git-bisect-using-headname).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
