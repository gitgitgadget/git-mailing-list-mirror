From: Johannes Schneider <mailings@cedarsoft.com>
Subject: Push to origin failed
Date: Tue, 19 Jan 2010 15:41:19 +0100
Message-ID: <4B55C48F.2090005@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 15:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXFGt-0007Ew-7e
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 15:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0ASOlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 09:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366Ab0ASOlV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 09:41:21 -0500
Received: from hosting.cedarsoft.com ([188.40.238.168]:53481 "EHLO
	cedarsoft.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0ASOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 09:41:21 -0500
Received: from [192.168.0.36] (HSI-KBW-095-208-171-090.hsi5.kabel-badenwuerttemberg.de [95.208.171.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cedarsoft.eu (Postfix) with ESMTP id B30DE10CBE54
	for <git@vger.kernel.org>; Tue, 19 Jan 2010 15:41:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091215 Lightning/1.0b2pre Shredder/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137461>

Hi,

my Hudson isn't able to push master back to origin under some special 
circumstances:

The git-push command failed.
Command output:
To ssh://git.cedarsoft.com/git/com.cedarsoft.open
  ! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 
'ssh://git.cedarsoft.com/git/com.cedarsoft.open'


When I delete the .git directory and let Hudson do the same thing again, 
everything works well.
Of course I have verified the obvious first:


git push
To ssh://git.cedarsoft.com/git/com.cedarsoft.open
  ! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 
'ssh://git.cedarsoft.com/git/com.cedarsoft.open'

git log
commit 1e3d3d2c1a38cae75d60bbcd8bc739ed00597ad3
Author: Hudson <hudson@cedarsoft.com>
Date:   Tue Jan 19 15:25:10 2010 +0100

     [maven-release-plugin] prepare release open-2.0.6

commit 9b8b395a4f9f725aa82be61474835fd1f7d009a7
Author: Johannes Schneider <js@cedarsoft.com>
Date:   Tue Jan 19 12:00:14 2010 +0100

     license-plugin: added excludes



On my local computer, I have called "git pull" on master and then tried 
git log with that result:


git log
commit 9b8b395a4f9f725aa82be61474835fd1f7d009a7
Author: Johannes Schneider <js@cedarsoft.com>
Date:   Tue Jan 19 12:00:14 2010 +0100

     license-plugin: added excludes



So I don't see any reason why the push failed. Any ideas? How can I 
investigate this issue further?
Obviously I don't know enough about Git, so any hints are welcome...


Thanks,

Johannes
