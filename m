From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-gui/Makefile: Replace libdir with gitgui_libdir
Date: Fri, 7 Sep 2007 01:01:48 -0400
Message-ID: <20070907050148.GA18160@spearce.org>
References: <20070905232153.GA331@nomad.office.altlinux.org> <20070906023227.GH18160@spearce.org> <20070906100012.GC6665@basalt.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 07:01:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVyh-0004Cb-6p
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 07:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbXIGFBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 01:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbXIGFBy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 01:01:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58323 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbXIGFBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 01:01:54 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ITVyY-0001tV-J8; Fri, 07 Sep 2007 01:01:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E640A20FBAE; Fri,  7 Sep 2007 01:01:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070906100012.GC6665@basalt.office.altlinux.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57978>

"Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > > On GNU/Linux, libdir is used to mean "/usr/lib or /usr/lib64"
> > > depending on architecture.  Different libdir meaning breaks
> > > idiomatic expressions like rpm specfile "make libdir=%_libdir".
> 
> The idea is that git-gui's libdir is not a traditional arch-dependent
> libdir's subdirectory, but rather arch-independent datadir's subdirectory.
> That is, I see no reason to call it libdir even in standalone project.

Call it datadir then?  I see you point, and now agree with you.
Mind resending a patch to call it 'datadir'?
 
-- 
Shawn.
