From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 05/24] Added WorkTree class which can be constructed over Repository.
Date: Tue, 13 May 2008 20:35:45 -0400
Message-ID: <20080514003545.GI29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-6-git-send-email-florianskarten@web.de> <20080513000405.GZ29038@spearce.org> <200805132313.33217.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Florian Koeberle <florianskarten@web.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 14 02:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw4zG-0002qM-6E
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 02:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbYENAfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 20:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756189AbYENAfu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 20:35:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37907 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbYENAfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 20:35:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jw4y0-0007QM-Vb; Tue, 13 May 2008 20:35:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2990020FBAE; Tue, 13 May 2008 20:35:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200805132313.33217.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82056>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdagen den 13 maj 2008 02.04.05 skrev Shawn O. Pearce:
> > This is actually making me reconsider how the WindowCache is handled.
> > Maybe we should have a single WindowCache instance down inside
> > of jgit, but allow the higher level UI (like Eclipse) to tune it
> > on the fly.  Then we don't have to worry about passing it down to
> > utility routines like this anytime we open a Repository.
> 
> A singleton WindowCache makes more sense yes.

Yea, OK.  I'll add it to my list of things to fix real-soon-now.

Right now I'm trying to finish automated tag following, since it
is not implemented.

-- 
Shawn.
