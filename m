From: Eric Wong <normalperson@yhbt.net>
Subject: Re: A note from the interim Git maintainer
Date: Tue, 16 Oct 2007 23:31:32 -0700
Message-ID: <20071017063132.GA458@soma>
References: <20071016055448.GA13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Eygene Ryabinkin <rea-git@codelabs.ru>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 08:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii2RV-000735-6r
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 08:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbXJQGbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 02:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbXJQGbe
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 02:31:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47367 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbXJQGbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 02:31:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id AB3187DC0FE;
	Tue, 16 Oct 2007 23:31:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071016055448.GA13801@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61337>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> As most folks are probably now well aware, Junio has been offline
> for about 11 days and may still be offline for a little while more.
> Before he dropped offline Junio shared why he left on such a short
> notice with both Dscho and myself, as it meant cancelling the
> "git together" we were planning to have last weekend in San Jose.
> 
> I'm not going to get into the specific details as it is Junio's
> business and not mine.  But I can say that my thoughts and prayers
> to $DEITY are with him and his family at this time, and I don't
> expect him to be rushing back to git work tomorrow.  However I'm
> quite certain that Junio will return when he can.
> 
> I've decided to step up and try to fill Junio's shoes.  To that end
> I am publishing a maint, master, next (and soon) pu branch from a
> new fork on repo.or.cz:

Thanks for doing this, Shawn.  I hope Junio is doing OK.

I've pushed out Benoit's and Eygene's latest git-svn changes to master
on http://git.bogomips.org/git-svn.git  These changes are against
spearce/master.

I've amended Benoit's commit messages a bit and fixed one bug in
git svn propget (also amended).

Benoit Sigoure (5):
      git-svn: add a generic tree traversal to fetch SVN properties
      git-svn: implement git svn create-ignore
      git-svn: add git svn propget
      git-svn: add git svn proplist
      git-svn: simplify the handling of fatal errors

Eygene Ryabinkin (2):
      git-svn: respect Subversion's [auth] section configuration values
      git-svn: use "no warnings 'once'" to disable false-positives

-- 
Eric Wong
