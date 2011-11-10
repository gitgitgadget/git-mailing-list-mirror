From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: "make quick-install-man" on git.git HEAD has failed for two days
Date: Thu, 10 Nov 2011 08:17:20 -0800
Message-ID: <861utgymsv.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 17:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROXPD-0003de-N3
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 17:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935691Ab1KJQXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 11:23:05 -0500
Received: from lax-gw18.mailroute.net ([199.89.0.118]:50981 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935003Ab1KJQXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 11:23:04 -0500
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Nov 2011 11:23:04 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by lax-gw18.mroute.net (Postfix) with ESMTP id A2DCC583A648
	for <git@vger.kernel.org>; Thu, 10 Nov 2011 16:17:21 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw18.mroute.net (Postfix) with ESMTP id 3D8C55839787
	for <git@vger.kernel.org>; Thu, 10 Nov 2011 16:17:21 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 4C3496EAA; Thu, 10 Nov 2011 08:17:20 -0800 (PST)
x-mayan-date: Long count = 12.19.18.15.13; tzolkin = 13 Ben; haab = 1 Ceh
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185236>


Known issue?  Should I have done something differently?

"make install quick-install-man" ends with:

    make[2]: `GIT-VERSION-FILE' is up to date.
    git-manpages repository must exist at ../../git-manpages
    make[1]: *** [require-manrepo] Error 1
    make: *** [quick-install-man] Error 2


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
