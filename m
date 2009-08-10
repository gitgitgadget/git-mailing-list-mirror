From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Limited git-gui to displaying 5000 new files
Date: Mon, 10 Aug 2009 10:08:42 -0700
Message-ID: <20090810170842.GX1033@spearce.org>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <81b0412b0908101006n66672cabi865a980d978c2865@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaYMm-0007xf-A4
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 19:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbZHJRIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbZHJRIm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 13:08:42 -0400
Received: from george.spearce.org ([209.20.77.23]:55831 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbZHJRIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 13:08:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BCE8D381FD; Mon, 10 Aug 2009 17:08:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0908101006n66672cabi865a980d978c2865@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125491>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On Mon, Aug 10, 2009 at 17:38, Shawn O. Pearce<spearce@spearce.org> wrote:
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? set warning "Displaying only $display_limit of "
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? append warning "[llength $to_display] files."
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? info_popup [mc $warning]
> >
> > This needs to be in the translated strings.
> 
> Will do, as soon as this hits git://repo.or.cz/git-gui.git.
> Or should I have looked at the internationalization repo
> git://repo.or.cz/git-gui/git-gui-i18n.git?

No, I meant that the patch needs to use [mc] or whatever it is
to enable the string to be localized.  After its marked with the
necessary code change, I can apply the patch, regenerate the .pot,
and let translators update their .po when they have time.

-- 
Shawn.
