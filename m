From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 20:35:41 -0700
Message-ID: <20070716033540.GB29521@muzzle>
References: <469A2B1D.2040107@alum.mit.edu> <20070715120149.3271b736.seanlkml@sympatico.ca> <7vd4ytebsw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAHNB-00019O-Lx
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759459AbXGPDfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760046AbXGPDfm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:35:42 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42452 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759038AbXGPDfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:35:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 38F8F2DC08D;
	Sun, 15 Jul 2007 20:35:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd4ytebsw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52631>

Junio C Hamano <gitster@pobox.com> wrote:
> Sean <seanlkml@sympatico.ca> writes:
> >> 2. It appears that author/committer require an email address.  How
> >> important is a valid email address here?
> >
> > It's not necessary for the operation of Git itself; it's up to you to
> > decide how important the information is to your project.  You should
> > be able to set an empty email address for author or committer in
> > git fast-import as "name <>".
> 
> Don't do this; git-cvsimport and git-svn uses "name <name>"
> which is a saner compromise.  This way, you can add .mailmap to
> help later "git shortlog" to map using "<name>" part to more
> human friendly name.  Mapping at conversion time would also be
> good and git-cvsimport knows about it (I do not know about
> git-svn).

git-svn can do this, too.

I don't use it myself, but I remember the file format is the
same as the one git-svnimport and git-cvsimport use.

-- 
Eric Wong
