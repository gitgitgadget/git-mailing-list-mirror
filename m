From: Yann Droneaud <ydroneaud@opteya.com>
Subject: git merge --date --author
Date: Fri, 07 Mar 2014 11:30:15 +0100
Organization: OPTEYA
Message-ID: <1394188215.3257.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 11:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLs3n-0002QF-PW
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 11:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaCGKbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 05:31:07 -0500
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:54649 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaCGKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 05:31:05 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 2B9EACA982A
	for <git@vger.kernel.org>; Fri,  7 Mar 2014 11:31:00 +0100 (CET)
Received: from [192.168.20.20] (unknown [37.163.154.120])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B4451D48148;
	Fri,  7 Mar 2014 11:30:18 +0100 (CET)
X-Mailer: Evolution 3.10.4 (3.10.4-1.fc20) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243610>

Hi,

I was trying to rebuild some history and found myself trying to use some
options with git merge which are available in git commit:

 git merge \
     --date "2013-12-31 23:59:59 +0000" \
     --author "Happy New Year <happy.new-year@gregorian.calendar>" \
     current-year

But unfortunately, unlike git commit, git merge doesn't support either
--date or --author.

I can work around with environment variables:

 GIT_AUTHOR_DATE="2013-12-31 23:59:59 +0000" \
 GIT_AUTHOR_NAME="Happy New Year" \
 GIT_AUTHOR_EMAIL="happy.new-year@gregorian.calendar"  \
 git merge current-year

But I'd like to know if there's a specific reason for git merge to not
support --date and --author ?

Regards.

-- 
Yann Droneaud
OPTEYA
