From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [msysGit] [GIT GUI PATCH] git-gui: fix open explorer window on Windows 7
Date: Thu, 25 Feb 2010 23:23:12 +0100
Message-ID: <201002252323.13240.markus.heidelberg@web.de>
References: <20100223225243.GC11271@book.hvoigt.net> <a5b261831002240415l5447ac94wd80c162fc9492fd5@mail.gmail.com> <20100225202949.GA12637@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:22:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkm6b-0006PR-HB
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 23:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934248Ab0BYWWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 17:22:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:50929 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934190Ab0BYWWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 17:22:43 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7C62A1402EDE4;
	Thu, 25 Feb 2010 23:22:42 +0100 (CET)
Received: from [91.19.8.97] (helo=pluto.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Nkm6U-0000G5-00; Thu, 25 Feb 2010 23:22:42 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
In-Reply-To: <20100225202949.GA12637@book.hvoigt.net>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/AozezAzHTmkg27fHu7PKi957wKI0SHUKZpIgn
	Kwo02Nf1QNzT52Opv/HFl1cnE3afqgC39ox9VJUWPEV7y2CUPF
	LsMQABVGlSAElyIua8PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141073>

Heiko Voigt, 2010-02-25 21:30:
> On Wed, Feb 24, 2010 at 12:15:03PM +0000, Pat Thoyts wrote:
> > On 23 February 2010 22:52, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > > It seems that Windows 7's explorer is not capable to cope with paths
> > > that contain forward slashes as path seperator. We thus substitute slash
> > > with the platforms native backslash.
> > >
> > 
> > What bug are you actually addressing here? How can I reproduce it? My
> > experience on Windows 7 is that there is no problem but I assume I'm
> > doing a different operation. If I use the git-gui  "Explore working
> > copy" it opens the Windows explorer for me just fine.
> 
> Very strange, again another inconsistency between Windowses? I can
> reproduce this even on Windows XP. I am using the current devel branches
> of msysgit (msysgit and git). It happens when using the
> "Repository->Explore working copy" menu item. The Windows 7 I tested
> this on is 32-bit Professional. Which Windows 7 are you using?

You should tell, how exactly you start git-gui, because this makes the
difference in this bug.

Markus
