From: Rajkumar S <rajkumars@asianetindia.com>
Subject: git merge in FreeBSD
Date: Wed, 15 Mar 2006 20:22:44 +0530
Message-ID: <44182A3C.80701@asianetindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 15 15:53:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJXMy-0001kZ-UD
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 15:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWCOOwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 09:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWCOOwx
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 09:52:53 -0500
Received: from vhs2.linuxense.com ([64.34.173.90]:1453 "EHLO
	vhs1.asianetindia.com") by vger.kernel.org with ESMTP
	id S1750884AbWCOOwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 09:52:53 -0500
Received: (qmail 13454 invoked by uid 1014); 15 Mar 2006 14:52:49 -0000
Received: from rajkumars@asianetindia.com by vhs2.linuxense.com by uid 1003 with qmail-scanner-1.22 
 (clamdscan: 0.74. spamassassin: 2.63.  Clear:RC:0(202.88.239.86):SA:0(0.0/6.5):. 
 Processed in 0.41272 secs); 15 Mar 2006 14:52:49 -0000
X-Spam-Status: No, hits=0.0 required=6.5
Received: from tarpit.linuxense.com (HELO [192.168.3.49]) (raj@linuxense.com@[202.88.239.86])
          (envelope-sender <rajkumars@asianetindia.com>)
          by vhs1.asianetindia.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 15 Mar 2006 14:52:48 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17610>

Hi,

I get a "git-merge-recursive: not found" error when I try to do a merge in FreeBSD. Same 
command in Linux does not give an error.

# git merge "Merging from updates" RELENG_1 RELENG_1_origin
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
/usr/local/bin/git-merge: git-merge-recursive: not found
No merge strategy handled the merge.

I am using git version 1.2.4.gea75 in FreeBSD 6

raj
