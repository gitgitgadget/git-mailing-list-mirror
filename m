From: Tomasz Pajor <nikon@puffy.pl>
Subject: git commit return code
Date: Mon, 09 Aug 2010 17:32:43 +0200
Message-ID: <4C601F9B.6040102@puffy.pl>
Reply-To: Tomasz Pajor <nikon@puffy.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 17:42:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiUUx-0003OF-9N
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 17:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0HIPmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 11:42:39 -0400
Received: from rix.pl ([82.115.86.117]:50103 "EHLO h1.rix.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab0HIPmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 11:42:38 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2010 11:42:38 EDT
Received: from [77.254.148.235] (helo=sql.office)
	by h1.rix.pl with esmtpa (Exim 4.71 (FreeBSD))
	(envelope-from <nikon@puffy.pl>)
	id 1OiULF-000MZw-5E
	for git@vger.kernel.org; Mon, 09 Aug 2010 17:32:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h1.rix.pl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [26 6] / [0 0]
X-AntiAbuse: Sender Address Domain - puffy.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152976>

Hello,

Is this proper behaviour:

root# su <username> -c "git commit --quiet -a -m \"templates generation\";"
# On branch master
nothing to commit (working directory clean)
root# echo $?
1

root# git --version
git version 1.7.1
