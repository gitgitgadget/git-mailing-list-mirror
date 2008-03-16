From: Petr Baudis <pasky@suse.cz>
Subject: Re: Repository corruption
Date: Mon, 17 Mar 2008 00:01:51 +0100
Message-ID: <20080316230151.GB6803@machine.or.cz>
References: <20070903165255.6CEC78B8B2@rover.dkm.cz> <20070903174142.GK10749@pasky.or.cz> <20070910212550.GN1935@nan92-1-81-57-214-146.fbx.proxad.net> <20080315121903.GY10335@machine.or.cz> <20080315130441.GF4079@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:02:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1sG-0003m6-Ij
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 00:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYCPXBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbYCPXBz
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 19:01:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33706 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbYCPXBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 19:01:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3333B1E4C049; Mon, 17 Mar 2008 00:01:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080315130441.GF4079@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77399>

On Sat, Mar 15, 2008 at 02:04:41PM +0100, Yann Dirson wrote:
> On Sat, Mar 15, 2008 at 01:19:03PM +0100, Petr Baudis wrote:
> >   Hi,
> > 
> > On Mon, Sep 10, 2007 at 11:25:50PM +0200, Yann Dirson wrote:
> > > Not sure if you saw my note in IRC: it looks like tagua/ydirson.git is
> > > definitely corrupted - not sure it would be useful to keep a copy
> > > around for investigation, but I'd appreciate if you could nuke the
> > > contents, so I can push again to it.
> > 
> >   I have nuked it now. :-)
> 
> Thanks :)
> 
> Any idea what caused the corruption ?

My idea I got few days ago when looking at the borken repositories is
that it was caused by interrupted git-repack, since there were stale
tmp_pack* files left in the repository - it seems like it removed old
"redundant" packs even though the new one weren't properly completed.
But that is just a speculation, and I did not get around to look at the
script yet whether this could really happen, or if something like this
got fixed recently.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
