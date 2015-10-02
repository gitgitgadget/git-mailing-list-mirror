From: Spencer Graves <spencer.graves@prodsyse.com>
Subject: can't install on OS X
Date: Fri, 2 Oct 2015 01:50:30 -0500
Message-ID: <560E2936.6020101@prodsyse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 09:10:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhuU6-0000ay-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 09:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbbJBHKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 03:10:22 -0400
Received: from cuda.garlic.com ([216.139.0.68]:54488 "EHLO Cuda.garlic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbbJBHKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 03:10:21 -0400
X-Greylist: delayed 1187 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2015 03:10:20 EDT
X-ASG-Debug-ID: 1443768631-089ede16d1609360001-QuoKaX
Received: from nake.garlic.com (nake.garlic.com [216.139.50.102]) by Cuda.garlic.com with ESMTP id zIvYEieAhHHuF1uT for <git@vger.kernel.org>; Thu, 01 Oct 2015 23:50:31 -0700 (PDT)
X-Barracuda-Envelope-From: spencer.graves@prodsyse.com
X-Barracuda-Apparent-Source-IP: 216.139.50.102
Received: from cpe-75-87-186-149.kc.res.rr.com ([75.87.186.149] helo=Spencer-Bryce-Gravess-MacBook-Pro.local)
	by nake.garlic.com with esmtpsa (UNKNOWN:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <spencer.graves@prodsyse.com>)
	id 1ZhuAp-0007RW-Gr
	for git@vger.kernel.org; Thu, 01 Oct 2015 23:50:31 -0700
X-ASG-Orig-Subj: can't install on OS X
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
X-Barracuda-Connect: nake.garlic.com[216.139.50.102]
X-Barracuda-Start-Time: 1443768631
X-Barracuda-URL: https://cuda.garlic.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at garlic.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using per-user scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.23108
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278909>

What's the procedure for installing Git under OS X 10.11?


I downloaded "git-2.5.3-intel-universal-mavericks.dmg" per 
instructions.  When I tried to install it, I first had trouble because 
it wasn't from the Mac App Store nor an "identified developer".  I 
ultimately found "System Preferences" > "Security & Privacy" > "Click 
the lock to make changes" > entered password > AND clicked to "Allow 
apps downloaded from: Anywhere".  Then the install appeared to run and  
proclaimed, "The installation was successful."  However, git is not 
listed under "Applications", and RStudio says, "Git was not detected on 
the system path."


"README.txt" says I need "sudo mv /usr/bin/git /usr/bin/git-system".  I 
tried that and got, "mv: rename /usr/bin/git to /usr/bin/git-system: 
Operation not permitted" (after entering my password).  [My directory 
now includes "/usr/local/git", and "/usr/bin" includes git, 
git-cvsserver, git-receive-pack, git-shell, git-upload-archive, and 
git-upload-pack.]


Suggestions?  Thanks, Spencer Graves
