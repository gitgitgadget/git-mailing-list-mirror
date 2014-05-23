From: Kendall Shaw <kshaw@kendallshaw.com>
Subject: git svn dcommit error 1
Date: Fri, 23 May 2014 09:09:42 -0700
Message-ID: <537F72C6.3060001@kendallshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 18:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnsGQ-0002w1-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 18:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbaEWQYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 12:24:05 -0400
Received: from c.mail.sonic.net ([64.142.111.80]:50783 "EHLO c.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaEWQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 12:24:04 -0400
X-Greylist: delayed 851 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 May 2014 12:24:04 EDT
Received: from [192.168.0.20] (c-67-161-38-155.hsd1.ca.comcast.net [67.161.38.155])
	(authenticated bits=0)
	by c.mail.sonic.net (8.14.4/8.14.4) with ESMTP id s4NG9hVm021599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 23 May 2014 09:09:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Sonic-ID: C;roA2p5Ti4xGyC1dpoNQ8UQ== M;ZPFCq5Ti4xGyC1dpoNQ8UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249996>

I have made a couple of commits. Then:

git svn rebase

For each of my modified files it says they need to be updated. This is 
probably wrong, but I decided it meant that I should commit. So:

git add ...
git commit ...
git svn dcommit

The dcommit reports error 1. I see that subversion was not updated.

I read an article about using git reset and then continuing from before 
the error. But, I made a couple of commits. So, what does this mean? Do 
I save off copies of the different commits and reapply them manually 
after resetting?

What should I do at this point?

Kendall
