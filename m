From: Gelonida <gelonida@gmail.com>
Subject: export one commit id from a repository
Date: Sat, 22 May 2010 15:41:26 +0200
Message-ID: <ht8mu6$hjo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 22 15:41:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFoxS-0002IA-QR
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 15:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab0EVNlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 09:41:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:39544 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab0EVNlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 09:41:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OFoxL-0002EZ-Ab
	for git@vger.kernel.org; Sat, 22 May 2010 15:41:35 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 May 2010 15:41:35 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 May 2010 15:41:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147525>

Hi,

I'm having a bare git repository on a server.

I'd like to be able to concurrently (multiuser) create tar files from
certain commmit ids.

How can I do this most efficiently.


How I do this today:
- ssh to the server.
- clone the bare repository to a temp directory.
- checkout a certain version.
- remove the .git directory
- tar it up
- scp it to my local host
- remove the temp directory and the tar file

svn had the command 'export'


Thanks a lot for help or pointing me to existing scripts / tools.
