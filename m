From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Initial Chinese translation
Date: Sun, 22 Jul 2007 03:35:19 -0400
Message-ID: <20070722073519.GV32566@spearce.org>
References: <11850629362012-git-send-email-xudong.guan@gmail.com> <7vhcnxtgvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xudong Guan <xudong.guan@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Christian Stimming <stimming@tuhh.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 09:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICVyf-0003TZ-8n
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 09:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbXGVHf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 03:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbXGVHf2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 03:35:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41157 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbXGVHf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 03:35:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICVyK-0006iu-OE; Sun, 22 Jul 2007 03:35:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 979D120FBAE; Sun, 22 Jul 2007 03:35:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vhcnxtgvw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53227>

Junio C Hamano <gitster@pobox.com> wrote:
> Xudong Guan <xudong.guan@gmail.com> writes:
> 
> > Simplified Chinese, in UTF-8 encoding.
> >
> > Signed-off-by: Xudong Guan <xudong.guan@gmail.com>
> > ---
> >  po/zh.po |  250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 250 insertions(+), 0 deletions(-)
> 
> This raises another point in the current i18n scheme.  How would
> we allow zh_CN and zh_TW to coexist?

They probably should be po/zh_CN.po and po/zh_TW.po.  Tcl msgcat
loads the file that best matches the user's local preferences, so
zh.po would be the fallback if neither zh_CN and zh_TW were present,
or if the user was using say zh_US as their preferred local.

-- 
Shawn.
