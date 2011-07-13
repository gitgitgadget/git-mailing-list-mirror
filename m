From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Coming from SVN world - need help
Date: Wed, 13 Jul 2011 18:30:56 +0530
Message-ID: <20110713183056.1cde5b61@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 15:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgzA4-0002J6-BM
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 15:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab1GMNHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 09:07:22 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:46439
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752520Ab1GMNHV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 09:07:21 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jul 2011 09:07:21 EDT
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 683603804001
	for <git@vger.kernel.org>; Wed, 13 Jul 2011 15:00:51 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177037>

Dear list,

Greetings !!

I have come from SVN world and totally new to GIT. I have managed to set gitweb and git; based on https:// along with authentication ( both for read and right ). And now I like to do the rest of the svn related thing in GIT. Just see the script below. This script first create an empty repo, built the structure; then checkout in a directory to map trunk with it and add contents to the repo.

```````````````````
svnadmin create ${svn_path}/<repo>

svn mkdir file:///${svn_path}/<repo>/trunk  \
         file:///${svn_path}/<repo>/tags  \
         file:///${svn_path}/<repo>/branches \
         -m "creating repo structure"

# map a directory with trunk 

cd mydir
mydir $> svn --username ${admin_svn} --password ${admin_svn_pass} co  file:///${svn_path}/${name_site}/trunk ./

#add and commit
mydir $> svn  add dir1 dir2

##commit
mydir $> svn  commit -m "adding dir1  dir2"
mydir $> svn up
````````````````````````````````

And now the issues when I am trying to do the same with git

[1] git init ${git_path}/<repo>.git  >>> ok , it is working

[2] Problem with mapping a dir with this repo

mydir $> git --username <username> --password <password> clone file:///${git_path}/<repo>.git 

Not working --username and --password .

Also git clone file:///${git_path}/<repo>.git creates a folder <repo>.git where I like map  the working directory with the contents of <repo>.git

[3] git commit -m also not commit into master.

Could any one please give me some clue ?

Thanks
