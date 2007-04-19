From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [BUG] cvsserver triggers (probably harmless) cvs warnings
Date: Thu, 19 Apr 2007 13:54:03 +0200
Message-ID: <20070419115402.GH7085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 13:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeVDJ-0004fv-FA
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 13:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993243AbXDSLyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 07:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993240AbXDSLyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 07:54:09 -0400
Received: from planck.djpig.de ([85.10.192.180]:2989 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993243AbXDSLyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 07:54:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 4F53888003
	for <git@vger.kernel.org>; Thu, 19 Apr 2007 13:54:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClOfqld8kNSL for <git@vger.kernel.org>;
	Thu, 19 Apr 2007 13:54:03 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 2E5A68801B; Thu, 19 Apr 2007 13:54:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45003>

Something I just observed during git-cvsserver tests but which I don't
have the time to track down right now:

If during "cvs update" a new file is sent in a subdirectory of a
subdirectory which both don't exist, this triggers a warning from
the CVS CLI client:

Example:
cvs update: warning: server is not creating directories one at a time
U board/westel/amx860/Makefile

(where boards/westel and board/westel/amx860 both didn't exist before).

Doesn't seem to do any harm but perhaps someone has more time and
motivation than me to fix this annoyance :)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
