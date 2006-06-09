From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [BUG] gitk with few commits
Date: Fri, 9 Jun 2006 09:23:07 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060609072307.GA3487@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 09 09:23:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FobKr-0007eU-Kv
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 09:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWFIHXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 03:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFIHXK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 03:23:10 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:14804 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1750995AbWFIHXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 03:23:08 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FobKl-0007R3-EA
	for git@vger.kernel.org; Fri, 09 Jun 2006 09:23:07 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k597N7K05099
	for git@vger.kernel.org; Fri, 9 Jun 2006 09:23:07 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21529>

Hello,

I started a new repository, for now there are only two commits.  In
gitk the area to display the commits is far from being filled.  I can
scroll up all the same.

Then marking commits by clicking on them fails, I have to click where
they are located, when the canvas is scrolled down completely.  Then the
canvas is redrawn to show the commits at the top again.

I tried shortly to fix this, but my Tcl/Tk knowledge ...

git version 1.4.0.rc2.ga95e
tcl/tk version 8.4.12-1

(Tk is patched with the patch from D. Richard Hipp Paul Mackerras
provided to me.)

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=30+hours+and+4+days+in+seconds
