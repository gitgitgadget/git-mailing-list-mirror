From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 05:25:53 -0600
Message-ID: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 13:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW8Jg-0007VA-A9
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 13:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbYHULZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 07:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbYHULZ4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 07:25:56 -0400
Received: from zenez.com ([166.70.62.2]:22418 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803AbYHULZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 07:25:55 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 9A28F113901; Thu, 21 Aug 2008 05:25:54 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 3E131113900
	for <git@vger.kernel.org>; Thu, 21 Aug 2008 05:25:54 -0600 (MDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93137>

Hello,

I am having the same problem on UnixWare as I have with the SCO OpenServer 
6. trying to build git-1.6.0.

Here is the error.

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

I need some assistance to track this down.  I did not have any error with 
the tests I did during the testing.  I did not test often on all OS's.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
