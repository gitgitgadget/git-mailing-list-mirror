From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 0/4] RepositoryTestCase cleanups
Date: Sun, 30 Nov 2008 15:18:08 +0100
Message-ID: <200811301518.09075.robin.rosenberg.lists@dewire.com>
References: <1227820410-9621-1-git-send-email-robin.rosenberg@dewire.com> <20081127214916.GD23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, fonseca@diku.dk
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 15:19:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6n8z-0004gh-JM
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 15:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYK3OSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 09:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYK3OSN
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 09:18:13 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:64799 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273AbYK3OSM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Nov 2008 09:18:12 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA95023B56A7; Sun, 30 Nov 2008 15:18:10 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081127214916.GD23984@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101973>

torsdag 27 november 2008 22:49:16 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > Ok, so here is an attempt to improve the ability of the JGit's unit
> > tests to delete temporary repositories. This has probably been seen
> > by many, but Jonas Fonseca raised the issue.
> 
> Hmpph.  This takes 19 seconds to run the suite, where it used to be
> only 2 seconds on the same system.  The slower run isn't something
> I'm too happy about, actually I'd like to make the run even faster
> than 2 seconds.

Ok, that's the GC calls, I added. I'll post a completely new set of patches
disabling mmap by default, overridable using system properties.

-- robin
