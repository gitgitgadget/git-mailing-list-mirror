From: Mike McCormack <mike@codeweavers.com>
Subject: pushing patches to an imap folder
Date: Tue, 15 Nov 2005 17:20:55 +0900
Organization: CodeWeavers
Message-ID: <43799A67.9030705@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 09:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebw6x-0005qX-8T
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVKOIXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVKOIXv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:23:51 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:36538 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751374AbVKOIXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 03:23:50 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1Ebw6U-0005Q2-9E
	for git@vger.kernel.org; Tue, 15 Nov 2005 02:23:50 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: git list <git@vger.kernel.org>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11887>

Hi,

I hacked up git-format-patch and isync to create a program to push 
patches from git into an imap folder.  This improve my workflow with git 
quite a bit.

It's pretty Wine specific at the moment, but I'd be happy to try and 
create a patch for git if I had a little advice on where to store the 
configuration... an imap server (host/port/name/pass or ssh command) 
with a mail header/template thrown in.

http://mandoo.dyndns.org/mm-send-patch-0.1.tar.gz

Comments and flames welcome :)

Mike
