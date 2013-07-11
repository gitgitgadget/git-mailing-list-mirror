From: Stephen & Linda Smith <ischis2@cox.net>
Subject: merging commit history
Date: Thu, 11 Jul 2013 16:43:56 -0700
Message-ID: <3186432.VaN86YJOtL@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 01:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxQeW-0007tb-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 01:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab3GKXv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 19:51:56 -0400
Received: from fed1rmfepi207.cox.net ([68.230.241.152]:45982 "EHLO
	fed1rmfepi207.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430Ab3GKXvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 19:51:54 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2013 19:51:54 EDT
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.09 201-2260-151-124-20120717) with ESMTP
          id <20130711234348.IIJL3894.fed1rmfepo103.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Thu, 11 Jul 2013 19:43:48 -0400
Received: from thunderbird ([24.251.82.172])
	by fed1rmimpo210 with cox
	id zBjn1l00U3j4oj401BjnBe; Thu, 11 Jul 2013 19:43:47 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020207.51DF4333.013D,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=drIF/Sc4 c=1 sm=1
 a=+a/fVzVtFbLp+jmGrq7Gkg==:17 a=k0fhm0m3bZ4A:10 a=G8Uczd0VNMoA:10
 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=Rc-Yn71QuswA:10 a=EPTyID1168AA5OgxylYA:9
 a=CjuIK1q_8ugA:10 a=+a/fVzVtFbLp+jmGrq7Gkg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 0949F13F880;
	Thu, 11 Jul 2013 09:43:57 -0700 (MST)
User-Agent: KMail/4.10.4 (Linux/3.8.0-26-generic; KDE/4.10.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230153>

I'm working on a project that used to use a proprietary CM system (aka oldCM).   At a point in time, the state of the code was frozen and used as the basis for commits in SVN.

What I would like to to do is take the individal commits from the oldCM and place them into git knowing that the time/date stamps won't match.  Then I want to do whatever is necessary to
setup git so that I can run "svn rebase" to pull in the commits from the SVN repository.

What is the easy way to do this?
