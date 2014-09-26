From: Ajay <ajay.dadgas@galaxyweblinks.in>
Subject: bug reporting
Date: Fri, 26 Sep 2014 19:11:35 +0530
Message-ID: <54256D0F.4000003@galaxyweblinks.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 15:47:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXVrk-0007oa-97
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 15:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbaIZNrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 09:47:12 -0400
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:44055 "EHLO
	smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754808AbaIZNrL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 09:47:11 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2014 09:47:11 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp3.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 858A9180654
	for <git@vger.kernel.org>; Fri, 26 Sep 2014 09:41:38 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp3.relay.ord1c.emailsrvr.com (Authenticated sender: ajay.dadgas-AT-galaxyweblinks.in) with ESMTPSA id D517A18078A
	for <git@vger.kernel.org>; Fri, 26 Sep 2014 09:41:37 -0400 (EDT)
X-Sender-Id: ajay.dadgas@galaxyweblinks.in
Received: from [192.168.1.3] (static-15-66-210.rpnspl.com [103.15.66.210])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:587 (trex/5.2.13);
	Fri, 26 Sep 2014 13:41:38 GMT
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257546>

Hello,

          I have faced a git bug. When I try to clone a git repo it 
shows an error "protocol error: bad pack header".

          This is the full error message which I got while cloning git 
project :

Clone: protocol error: bad pack header
     $ git clone -v --progress 
http://dev.galaxylipl.com:88/galaxygit/privatenovator.git 
/home/lipl/privateschoolinnovator
     Cloning into '/home/lipl/privatenovator'...
     POST git-upload-pack (190 bytes)
     remote: error: Could not read e9a6c4c684a5e8758026e8b0e25867c03332fe7c
     remote: fatal: bad tree object 
e9a6c4c684a5e8758026e8b0e25867c03332fe7c
     remote: aborting due to possible repository corruption on the 
remote side.
     protocol error: bad pack header

I tried everything to resolve this error, I have run some commands on 
server side like :

# git fsck
# git-fsck --full
# git fsck --lost-found
# git repack
# git gc

         But nothing worked for me and the error is still same. I tried 
to find the corrupt file but I was unable to find.

         Please check this issue and provide me proper solution for this.

Thanks & Regards,
Ajay Dadgas
