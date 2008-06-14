From: Petr Baudis <pasky@suse.cz>
Subject: git.or.cz, repo.or.cz down
Date: Sat, 14 Jun 2008 16:48:45 +0200
Message-ID: <20080614144844.GL18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 16:49:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7X4f-0006zM-BI
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 16:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbYFNOsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 10:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbYFNOsr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 10:48:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36764 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbYFNOsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 10:48:46 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0B6311E4C037; Sat, 14 Jun 2008 16:48:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85019>

  Hi,

  FYI, the server running git.or.cz and repo.or.cz crashed and will
probably stay down until Monday - please bear with us; repo.or.cz
users may enjoy trying out some alternative development models than
central-server based ones. ;-)

  The oops happenned once before already, but this time I figured out
more details thanks to the good ol' netconsole. For the more technically
inclined, the crash is due to an IPv6 kernel bug:

	http://www.spinics.net/lists/netdev/msg65854.html

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
