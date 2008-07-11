From: Petr Baudis <pasky@suse.cz>
Subject: [StGIT] Failure to install on RHELWS4
Date: Fri, 11 Jul 2008 19:03:56 +0200
Message-ID: <20080711170356.GF32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 19:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHM3N-0007aH-E4
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 19:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbYGKREH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 13:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbYGKREG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 13:04:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39573 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbYGKREF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 13:04:05 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 528A72C4C037; Fri, 11 Jul 2008 19:03:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88146>

  Hi,

  I wanted to install latest HEAD of StGIT on a rather ancient-feeling
RHEL4, however, when doing python setup.py install, I'm getting

	  File "setup.py", line 31
	    pyver = '.'.join(str(n) for n in sys.version_info)
	                              ^
SyntaxError: invalid syntax

I don't really know python and the ^ is rather curiously-positioned, so
I don't have much clue on what is going on. Python version is 2.3.4 -
maybe that's too old, but I didn't find any word on the minimal Python
version nowhere in the documentation.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
