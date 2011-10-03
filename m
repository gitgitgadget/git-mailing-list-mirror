From: Chris Friesen <chris.friesen@genband.com>
Subject: strange behaviour, default branch on clone not as expected
Date: Mon, 03 Oct 2011 10:50:41 -0600
Message-ID: <4E89E7E1.4000907@genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 18:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAljM-0007Zm-Va
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 18:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab1JCQvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 12:51:00 -0400
Received: from exprod7og109.obsmtp.com ([64.18.2.171]:57137 "EHLO
	exprod7og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab1JCQu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 12:50:59 -0400
Received: from mail.genband.com ([63.149.188.88]) (using TLSv1) by exprod7ob109.postini.com ([64.18.6.12]) with SMTP;
	Mon, 03 Oct 2011 09:50:59 PDT
Received: from gbausmail.genband.com ([172.16.21.62]) by mail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 3 Oct 2011 11:50:42 -0500
Received: from [1.220.38.209] ([1.220.38.209]) by gbausmail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 3 Oct 2011 11:50:42 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.14
X-OriginalArrivalTime: 03 Oct 2011 16:50:42.0350 (UTC) FILETIME=[967644E0:01CC81EC]
X-TM-AS-Product-Ver: SMEX-8.0.0.4160-6.500.1024-18424.000
X-TM-AS-Result: No--9.796600-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182671>

Hi,

I have a bare repository on a server with (among others) branches 
"atca6900-ecgl" and "ncgl".  The "HEAD" file in the bare repository 
contains "ref: refs/heads/ncgl" and "git branch" in the bare repository 
shows an asterisk beside "ncgl".

However, if I clone the bare repository I get "atca-6900-ecgl" as the 
default branch.  ".git/HEAD" contains "ref: refs/heads/atca6900-ecgl".

Something that might be relevent--currently both of these branches 
actually point to the same commit (Don't ask, it's a vendor thing.) thus 
"refs/heads/atca6900-ecgl" and "refs/heads/ncgl" have the same contents. 
  I find it suspicious that atca6900-ecgl is alphabetically before ncgl 
and that they point to the same commit ID...but I don't know how it 
works internally so this may be just coincidence.

Any ideas what's going on?  I'm using git 1.7.3.2 if it makes any 
difference.

Chris



-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
