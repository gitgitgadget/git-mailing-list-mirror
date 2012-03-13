From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: checkout -q not quiet enough
Date: Tue, 13 Mar 2012 11:19:03 -0700
Message-ID: <86aa3k5ppk.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 19:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7WU7-0000cr-NC
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 19:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab2CMSaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 14:30:05 -0400
Received: from lax-gw02.mailroute.net ([199.89.0.102]:40420 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753332Ab2CMSaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 14:30:04 -0400
X-Greylist: delayed 659 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2012 14:30:04 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by lax-gw02.mroute.net (Postfix) with ESMTP id 0742B1DF476
	for <git@vger.kernel.org>; Tue, 13 Mar 2012 18:19:05 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw02.mroute.net (Postfix) with ESMTP id B82041DF474
	for <git@vger.kernel.org>; Tue, 13 Mar 2012 18:19:03 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 96A1A12D9; Tue, 13 Mar 2012 11:19:03 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.3.17; tzolkin = 7 Caban; haab = 5 Cumku
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193055>


checkout without -q:

  Switched to a new branch 'projects/DUH-11'
  Branch projects/DUH-11 set up to track remote branch projects/DUH-11 from origin.

checkout with -q:

  Branch projects/DUH-11 set up to track remote branch projects/DUH-11 from origin.


Bug or feature?  If feature, how do I get it "more q'ey"?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
