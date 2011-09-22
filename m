From: Chris Friesen <chris.friesen@genband.com>
Subject: any way to "re-sync" a bare repository against another bare repository?
Date: Thu, 22 Sep 2011 11:22:37 -0600
Message-ID: <4E7B6EDD.1040106@genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 19:33:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6n9m-00081S-Jv
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab1IVRdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:33:50 -0400
Received: from exprod7og127.obsmtp.com ([64.18.2.210]:42784 "EHLO
	exprod7og127.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1IVRdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:33:49 -0400
X-Greylist: delayed 648 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Sep 2011 13:33:49 EDT
Received: from mail.genband.com ([63.149.188.88]) (using TLSv1) by exprod7ob127.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTntxfOgneBqhirnxzKskJkTTpD0UcTPO@postini.com; Thu, 22 Sep 2011 10:33:49 PDT
Received: from gbausmail.genband.com ([172.16.21.62]) by mail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Sep 2011 12:22:38 -0500
Received: from [1.220.36.114] ([1.220.36.114]) by gbausmail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Sep 2011 12:22:39 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.14
X-OriginalArrivalTime: 22 Sep 2011 17:22:39.0476 (UTC) FILETIME=[3A9D3B40:01CC794C]
X-TM-AS-Product-Ver: SMEX-8.0.0.4160-6.500.1024-18402.000
X-TM-AS-Result: No--8.825300-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181905>

Suppose I have a parent bare repository.  I do a "git clone --bare" to 
create a child repository, and then clone the child to create a 
grandchild repository.

If changes get pushed into the parent repository, is there any way to 
cause the child to be updated?

Just a "git fetch <parent>" doesn't seem to help.  If I set up parent as 
a remote branch I can fetch it, but then it shows all the branches as 
"parent/<branch>" rather than updating the child.

I just tried a "git clone --mirror" to create the child and it seems to 
allow me to pick up changes in the parent via "git fetch".  Is that the 
proper way to handle this?

Thanks,
Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
