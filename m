From: chris <christian@anorasolutions.com>
Subject: git remote repo using http
Date: Fri, 18 Feb 2011 11:28:20 -0600
Message-ID: <4D5EAC34.3060504@anorasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 19:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqUuK-0005ja-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 19:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab1BRSSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 13:18:15 -0500
Received: from bazzar.lunarbreeze.com ([216.97.239.25]:48875 "EHLO
	bazaar.lunarbreeze.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1BRSSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 13:18:13 -0500
X-Greylist: delayed 2993 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Feb 2011 13:18:13 EST
Received: from pool-96-226-230-44.dllstx.fios.verizon.net ([96.226.230.44] helo=[192.168.1.130])
	by bazaar.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <christian@anorasolutions.com>)
	id 1PqU7o-0007BL-RQ
	for git@vger.kernel.org; Fri, 18 Feb 2011 09:28:12 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bazaar.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - anorasolutions.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167221>

Hello,

I have been trying this for about 1 day, with no luck so far.
I have a git repo on a server that is hosting our company's website (the 
hosting company name is LunarPages, and the server is Bazaar i believe). 
Thing is when i try the following command from my local machine this is 
what i get:
-----------[code]-----------
$ git clone http://website.com/public_fpt/repos/proj.git
Cloning into proj ...
fatal: http://website.com/public_ftp/repos/proj.git/info/refs not found: 
did you run the git update-server-info on the server?
-----------[/code]--------------


Because of this, i tried starting all over again, and i even ran the 
command:
-----------[code]---------------
Chris@anora-1271823183291 z/public_ftp/repos/proj.git
$ git update-server-info
-----------[/code]---------------

before trying to clone, and i still have this problem. I have searched 
online, I even found this tutorial:
http://blog.wekeroad.com/2009/11/23/deploying-a-web-application-with-git-and-ftp
but i still get the same error message. At this point I'm out of ideas. 
Is there anything else I need to try?

Thanks.
