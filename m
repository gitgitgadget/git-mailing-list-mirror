From: Andy_BN <isalexandru@gmail.com>
Subject: Git not uploading all files
Date: Wed, 16 May 2012 13:28:58 -0700 (PDT)
Message-ID: <1337200138323-7559420.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 22:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUkqG-0001wl-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 22:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965986Ab2EPU27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 16:28:59 -0400
Received: from sam.nabble.com ([216.139.236.26]:46376 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965833Ab2EPU26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 16:28:58 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <isalexandru@gmail.com>)
	id 1SUkqA-0002qw-Ax
	for git@vger.kernel.org; Wed, 16 May 2012 13:28:58 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197899>

Hi, i have setup my server using the instructions from :
http://danbarber.me/using-git-for-deployment/
I have a bare repo thats pushing changes to web . It work ok, except for
some issues.
I noticed that some files were not uploades, although they look fine
according to gitweb:

261 files changed:
www/sites/all/modules/contrib/jquery_update/CHANGELOG.txt	[new file with
mode: 0644]	blob
www/sites/all/modules/contrib/jquery_update/LICENSE.txt	[new file with mode:
0644]	blob
www/sites/all/modules/contrib/jquery_update/README.txt	[new file with mode:
0644]	blob

I notice that in /var/www i did not have the jquery_update folder or any
files within that folder. The path was not included in .gitignore and all
other files were uploaded fine.
I checked the logs on server and nothing happenned at that time , no errors
from server.

Do you have any ideeas why this could happend? 

Thank you
Andy

--
View this message in context: http://git.661346.n2.nabble.com/Git-not-uploading-all-files-tp7559420.html
Sent from the git mailing list archive at Nabble.com.
