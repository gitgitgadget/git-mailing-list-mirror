From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 6 Aug 2008 13:15:45 +0200
Message-ID: <20080806111545.GD32184@machine.or.cz>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807231852.10206.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231356540.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 06 13:16:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQh0j-0007yZ-HE
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 13:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbYHFLPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 07:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756888AbYHFLPv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 07:15:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48880 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756739AbYHFLPu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 07:15:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E1C28393B224; Wed,  6 Aug 2008 13:15:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231356540.8986@racer>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91504>

  Hi,

On Wed, Jul 23, 2008 at 01:57:54PM +0100, Johannes Schindelin wrote:
> Note that you will have to do your digging using msysGit (i.e. the 
> developer's pack, not the installer for plain Git), since git-svn will be 
> removed from the next official "Windows Git" release, due to lack of 
> fixers.

  is there any other problem with git-svn on Windows than the CRLF
issue? I couldn't find anything significant in the issue tracker.

  If not, why do you want to drop git-svn from Windows Git? It seems
that the CRLF issue has trivial workaround to set autocrlf=false;
this will make git-svn-tracked repositories useful only on Windows,
but I'd bet this is fine for large majority of Windows git-svn users?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
