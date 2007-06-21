From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui cannot find share/git-gui under cygwin
Date: Wed, 20 Jun 2007 23:30:30 -0400
Message-ID: <20070621033030.GE8477@spearce.org>
References: <4677CBD7.9050606@gmail.com> <20070619144928.GA8477@spearce.org> <4678236A.9000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 05:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1DNT-0000pT-VT
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 05:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbXFUDae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 23:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbXFUDae
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 23:30:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35232 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbXFUDae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 23:30:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1DNE-00062N-7j; Wed, 20 Jun 2007 23:30:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D790D20FBAE; Wed, 20 Jun 2007 23:30:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4678236A.9000606@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50588>

Mark Levedahl <mlevedahl@gmail.com> wrote:
> Shawn O. Pearce wrote:
> >Yuck.  I'm considering applying the following.  It works ok on Mac
> >OS X where the bug isn't triggered anyway.  ;-) I won't be able to
> >test on Cygwin until tomorrow.
>  
> sorry, no joy. The problem is that gitexecdir=/usr/bin, but...

Thanks for the feedback.

> I don't think there is a portable solution here. Maybe just say
> 
>    if test "$(uname_O)" = Cygwin; then \
>        GITGUI_RELATIVE=; \
> 
> and be done with it.

Yup.  Done.  Now in my `maint`, `master` and `pu` branches.

-- 
Shawn.
