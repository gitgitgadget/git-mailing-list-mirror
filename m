From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] git-svn: fix symlink-to-file changes when using command-line svn 1.4.0
Date: Tue, 24 Oct 2006 15:09:37 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061024130937.GA16617@cepheus.pub>
References: <20061018085948.GA27357@cepheus.pub> <20061024095037.GA15936@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 15:03:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcLvx-0002zO-C9
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 15:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWJXNDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 09:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWJXNDG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 09:03:06 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:29093 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1161002AbWJXNDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 09:03:03 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GcLvp-0000oA-VO; Tue, 24 Oct 2006 15:03:02 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k9OD2xDS015700;
	Tue, 24 Oct 2006 15:02:59 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k9OD2xtA015699;
	Tue, 24 Oct 2006 15:02:59 +0200 (MEST)
To: Eric Wong <normalperson@yhbt.net>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Eric Wong <normalperson@yhbt.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061024095037.GA15936@soma>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29975>

Eric Wong wrote:
> I incorrectly thought this was hopelessly broken in svn 1.4.0,
> but now it's just broken in that the old method didn't work.  It
> looks like svn propdel and svn propset must be used now and the
> (imho) more obvious svn rm --force && svn add no longer works.
> 
> make -C t full-svn-test should now work
works for me, so ...
 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
Acked-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

BTW: make -C t full-svn-test ran the test suite several times, which is
fine.  But if I read correctly, half of the runs are superfluous if the
perl SVN libraries are not installed.  Probably it's not worth fixing...

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=0+degree+Celsius+in+kelvin
