From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT RFC PATCH 3/3] Rate limit warnings spewed by
	RepositoryTestCase.recursiveDelete
Date: Thu, 30 Oct 2008 11:46:20 +0100
Message-ID: <20081030104620.GB17131@diku.dk>
References: <20081022083420.GC17940@diku.dk> <200810240110.21755.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 11:47:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvV3x-00033K-82
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 11:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYJ3KqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 06:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYJ3KqX
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 06:46:23 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:56110 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbYJ3KqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 06:46:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 55E6352C31F;
	Thu, 30 Oct 2008 11:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdLiI8gf8iBG; Thu, 30 Oct 2008 11:46:20 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3D61252C346;
	Thu, 30 Oct 2008 11:46:20 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D0FC46DF845; Thu, 30 Oct 2008 11:44:52 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 27D501A4001; Thu, 30 Oct 2008 11:46:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200810240110.21755.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99456>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote Fri, Oct 24, 2008:
> onsdagen den 22 oktober 2008 10.34.20 skrev Jonas Fonseca:
> > On Windows XP / NTFS / NetBeans 6.1 / Java 5 a lot of warnings are
> > printed. In most cases the path is in fact deleted and it seems to
> > just be a timing bug or something Windows or NTFS specific.
>
> The problem is actually flaws in the unit tests and in the supporting
> RepositoryTestCase.  I think I'll fix that instead.

Thanks. Any progress on this? Can I help in any way?

-- 
Jonas Fonseca
