From: Michael Cronenworth <mike@cchtml.com>
Subject: git-cvsserver strips exec bit
Date: Tue, 10 Sep 2013 10:23:42 -0500
Message-ID: <522F397E.6080709@cchtml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 17:58:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJQKL-0001hS-3K
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 17:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab3IJP6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 11:58:00 -0400
Received: from que21.charter.net ([209.225.8.22]:51137 "EHLO que21.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab3IJP57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 11:57:59 -0400
X-Greylist: delayed 1894 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2013 11:57:59 EDT
Received: from imp09 ([10.20.200.9]) by mta31.charter.net
          (InterMail vM.8.01.05.02 201-2260-151-103-20110920) with ESMTP
          id <20130910152344.NSSR24708.mta31.charter.net@imp09>
          for <git@vger.kernel.org>; Tue, 10 Sep 2013 11:23:44 -0400
Received: from cchtml.com ([97.93.199.156])
	by imp09 with smtp.charter.net
	id PTPk1m00F3NxN1505TPkkS; Tue, 10 Sep 2013 11:23:44 -0400
X-Authority-Analysis: v=2.0 cv=ZL6PAgHb c=1 sm=1
 a=lo8auXNu6Mom74z6dLD8eg==:17 a=7E2d2x4H2BEA:10 a=qUy_l7r3NdoA:10
 a=qYDZOxW1f6MA:10 a=8nJEP1OIZ-IA:10 a=XT0ipqFZAAAA:8 a=Ly8dnpfblpIA:10
 a=mI2T93aJBIhPBygY_2oA:9 a=wPNLvfGTeEIA:10 a=lo8auXNu6Mom74z6dLD8eg==:117
Received: by cchtml.com (Postfix, from userid 500)
	id 26C1F15402A0; Tue, 10 Sep 2013 10:23:44 -0500 (CDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on balthasar.cchtml.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcronenworth.nhsrx.com (unknown [67.130.187.94])
	by cchtml.com (Postfix) with ESMTPSA id 4F92315400E8
	for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:23:43 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234436>

Hello,

On git 1.8.1.x (Fedora 18) I was able to use the git-cvsserver to checkout code
to package into a tarball. Script files that were in git with 755 masks were
checked-out with the same mask. After upgrading the git repository machine to
Fedora 19 (1.8.3.1) the behaviour has changed. When I checkout the same script
files their mask is now 644. The mask has not changed in git.

I understand I can use git-archive to perform the same functionality, but I'd
like to report this issue here.

Thanks,
Michael
