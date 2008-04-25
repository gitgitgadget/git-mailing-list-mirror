From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui hangs on read
Date: Thu, 24 Apr 2008 21:02:45 -0400
Message-ID: <20080425010245.GZ29771@spearce.org>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com> <20080422001311.GS29771@spearce.org> <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com> <20080422232530.GK29771@spearce.org> <480EF84A.4020308@isy.liu.se> <b3889dff0804230716n1b5dde1ctb7b0c1dd83f2d1ff@mail.gmail.com> <480F4C6E.9070400@isy.liu.se> <20080424010015.GS29771@spearce.org> <48102E92.3090601@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Collins <ben.collins@acm.org>, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Apr 25 03:03:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpCLk-0007jW-9R
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 03:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYDYBCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 21:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbYDYBCx
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 21:02:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39747 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbYDYBCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 21:02:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JpCKk-0003b6-Dj; Thu, 24 Apr 2008 21:02:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 748C520FBAE; Thu, 24 Apr 2008 21:02:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48102E92.3090601@isy.liu.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80319>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> On 04/24/2008 03:00 AM, Shawn O. Pearce wrote:
> >Just turn the d**n spell checker off:
> >
> >	git config --global gui.spellingdictionary none
> >
> >That will keep us from evening trying to launch aspell, and since
> >its global (in your ~/.gitconfig) it should default into every
> >repository you have, or create.
> 
> Thanks, even better!  Though, I can't seem to find this option (and 
> other ones indicated by the source) documented anywhere.  Where would be 
> the place to put such information?  For git options the place seems to 
> be the git config help, but given that the git gui is maintained 
> independently the choice is less obvious to me.

Indeed.  The git-gui options dialog lets you select this value,
but you can't get into git-gui far enough to open that dialog.

As far as documenting the git-gui options, maybe they should go into
either Documentation/git-gui.txt or into Documentation/config.txt
in the main git.git project.  The latter almost makes sense because
git-gui does store its preferences in the same config file, and that
file describes the valid keys and what they mean.

-- 
Shawn.
