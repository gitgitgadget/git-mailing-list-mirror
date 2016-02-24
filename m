From: Olga Pshenichnikova <olga@ip-5.ru>
Subject: Some strange behavior of git
Date: Thu, 25 Feb 2016 01:43:04 +0300
Message-ID: <56CE31F8.7090706@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 23:50:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiGc-0005fp-0K
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbcBXWul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:50:41 -0500
Received: from [178.62.228.239] ([178.62.228.239]:52992 "EHLO server.ip-5.ru"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbcBXWul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:50:41 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2016 17:50:41 EST
Received: from [10.143.46.73] (unknown [31.40.132.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by server.ip-5.ru (Postfix) with ESMTPSA id DE42B100E93
	for <git@vger.kernel.org>; Thu, 25 Feb 2016 01:43:05 +0300 (MSK)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287240>

Hello,
we use git in our project.
What can be cause for further confusing behavior?

     git@ip5server:~$ git status
     On branch master
     Untracked files:
       (use "git add <file>..." to include in what will be committed)

         app/addons/arliteks/

     nothing added to commit but untracked files present (use "git add" 
to track)
     git@ip5server:~$ git clean -dn
     Would remove app/addons/arliteks/
     Would remove design/
     Would remove js/
     Would remove var/langs/en/

Why I don't see all 4 directories in first command?
