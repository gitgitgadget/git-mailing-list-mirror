From: Ittay Dror <ittayd@tikalk.com>
Subject: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 17:10:24 +0300
Message-ID: <4819CF50.2020509@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 16:11:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrZVE-0007ev-9I
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 16:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYEAOK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 10:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYEAOK2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 10:10:28 -0400
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173]:47037 "HELO
	smtp104.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753109AbYEAOK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 10:10:28 -0400
Received: (qmail 98490 invoked from network); 1 May 2008 14:10:23 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp104.biz.mail.re2.yahoo.com with SMTP; 1 May 2008 14:10:23 -0000
X-YMail-OSG: j8LHaqkVM1nzeWnlsw1P9C79A2x8xaDedj32BVvJl7Y5.daiq59FrZiaQAcQnbVgkY4rXNkuFeaXWw3Xt57.JeS4wkTiO3JzaDXhgpLdMf.cUEoxhWpVgIcFzR5zsov6pgFIow60SEvpoGPOup3D4l0j
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80912>

Hi,

Say I have a file A, I rename to 'B', commit, then change file B and 
commit. Does 'git diff -M HEAD^^..' detect that? From what I see now, it 
will show 'B' as new (all of it with '+' prefix in the output). Am I right?

Thank you,
Ittay

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
