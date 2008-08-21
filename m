From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Bug/problem compile problem with 1.6.0 pn SCO OpenServer 6.0
Date: Thu, 21 Aug 2008 05:00:52 -0600
Message-ID: <alpine.LNX.1.10.0808210456560.24713@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 13:02:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW7vT-0006du-CI
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 13:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbYHULAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 07:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbYHULAz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 07:00:55 -0400
Received: from zenez.com ([166.70.62.2]:11694 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878AbYHULAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 07:00:54 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 19DEC1137A0; Thu, 21 Aug 2008 05:00:52 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 7E3F7113795
	for <git@vger.kernel.org>; Thu, 21 Aug 2008 05:00:52 -0600 (MDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93134>

Hello,

I finally found the time to attempt to build 1.6.0.  

This is what I am seeing.

...
    CC shell.o
    AR compat/lib.a
    LINK git-shell
Undefined                       first referenced
symbol                              in file
hexval_table                        abspath.o
null_sha1                           abspath.o
trust_executable_bit                abspath.o
has_symlinks                        abspath.o
UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
gmake: *** [git-shell] Error 1


I did do some testing prior with my git clone of 1.6.0 and I never saw 
this problem.  Where do I need to start to fix this.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
