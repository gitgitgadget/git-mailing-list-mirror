From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Test failures on cygwin (v1.6.0)
Date: Tue, 26 Aug 2008 18:41:50 +0100
Message-ID: <48B4405E.2020507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2u6-0006eN-DN
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180AbYHZSDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758258AbYHZSDX
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:03:23 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2634 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757719AbYHZSDW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 14:03:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.67)
	id 1KY2ke-0003yB-5N
	for git@vger.kernel.org; Tue, 26 Aug 2008 17:54:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93789>

Hi *,

Having upgraded to v1.6.0, via tar-ball as usual, I must note a new
"make test" failure, namely t9700-perl-git.sh.  In order to pass, I
need to run:

GIT_SKIP_TESTS='t0004 t3700.2[1234] t9700' make test

I haven't had time to look into the new failure yet; I'll report back
when I know more. (I will send a couple of minor patches related to
the 1.6.0 build)

Also, the new test summary shows (on Linux and cygwin):

          Linux    Cygwin
fixed     1        3
success   3748     3511
failed    0        0
broken    2        2
total     3751     3520
[time:    5m47s    47m]

Note the number of fixed on cygwin. It took some time to find, but it
appears that the additional FIXED where t0050-filsystem.sh tests
5 "merge (case change)" and 6 "add (with different case)".  Again, I
haven't investigated yet.

ATB,

Ramsay Jones
