From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Q about the date format in "git commit --date=..." and such
Date: Sun, 06 Mar 2011 17:07:52 +0100
Message-ID: <4D73B158.5040409@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 06 17:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwGlN-00023K-3R
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 17:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab1CFQYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 11:24:42 -0500
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:59320 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab1CFQYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 11:24:41 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Mar 2011 11:24:41 EST
Received: from [84.176.37.97] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1PwGUq-0006L3-Uc
	for git@vger.kernel.org; Sun, 06 Mar 2011 17:07:53 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.14) Gecko/20110221 Lightning/1.0b2 Thunderbird/3.1.8
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168521>

Hello,

I frequently change a file in my repo and commit it with
"git commit -a -C deadbeef", i.e. using an older commit message. The
"-C" switch also re-uses the author timestamp of the given SHA1, which
is not what I want. So I tried the "--date=..." switch in addition,
which works fine.

Instead of giving an exact timestamp (like "--date='06.03.2011 16:50'")
I'd prefer to just say "--date=now". Is that somehow possible? If not:
would the community appreciate it, if I would try to implement this?

I imagine to translate "now" to "localtime(time(0))". Would that be good?

Dirk
