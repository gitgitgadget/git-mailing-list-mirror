From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: git-1.6.2-rc2 problems on t4034-diff-words.sh
Date: Fri, 27 Feb 2009 11:06:29 -0700
Message-ID: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 19:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld780-0007uL-Uj
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 19:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZB0SGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 13:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZB0SGc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 13:06:32 -0500
Received: from suse104.zenez.com ([198.60.105.164]:40049 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZB0SGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 13:06:31 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 508A26C1A7B; Fri, 27 Feb 2009 11:06:29 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 38468938174
	for <git@vger.kernel.org>; Fri, 27 Feb 2009 11:06:29 -0700 (MST)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111690>

Hello,

I just download and started to test this on SCO OpenServer 6.0.mp4

They just released a new Maintianence Patch for the OS.  This is what I 
get while running gmake test.

*** t4034-diff-words.sh ***
*   ok 1: setup
*   ok 2: word diff with runs of whitespace
*   ok 3: word diff with a regular expression
*   ok 4: set a diff driver
*   ok 5: option overrides .gitattributes
* FAIL 6: use regex supplied by driver


                 word_diff --color-words


*   ok 7: set diff.wordRegex option
*   ok 8: command-line overrides config
* FAIL 9: .gitattributes override config

                 word_diff --color-words

*   ok 10: remove diff driver regex
*   ok 11: use configured regex
* FAIL 12: test parsing words for newline


                 word_diff --color-words="a+"



* FAIL 13: test when words are only removed at the end


                 word_diff --color-words=.


* failed 4 among 13 test(s)
gmake[2]: *** [t4034-diff-words.sh] Error 1


-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
