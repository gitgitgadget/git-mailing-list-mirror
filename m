From: "David Ho" <davidkwho@gmail.com>
Subject: Pulling tags from git.git
Date: Mon, 6 Mar 2006 13:44:45 -0500
Message-ID: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Mar 06 23:59:57 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1FGLAI-0004Iq-00
	for <gcvg-git@gmane.org>; Mon, 06 Mar 2006 20:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbWCFSor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 13:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWCFSor
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 13:44:47 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:17938 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752398AbWCFSoq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 13:44:46 -0500
Received: by wproxy.gmail.com with SMTP id 71so1211925wra
        for <git@vger.kernel.org>; Mon, 06 Mar 2006 10:44:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sLjWNIczyDMEgsixJm/oW2pxXjvm28wORFJFvqIKWrBJrsvNrJrhiGcC++mqvZbPaa0Sn2MbCsMqJuIPKin2HGUGihvpOrE4YheJM4vLGWnmz72/v40e/vGMaj8BWqsrkN/Tno2fZLz0kVvjeNEIFtQhjtiCD5H9mNZxK+dDqjY=
Received: by 10.65.20.17 with SMTP id x17mr2696086qbi;
        Mon, 06 Mar 2006 10:44:45 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Mon, 6 Mar 2006 10:44:45 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17309>

Hi,

I have been trying to pull from the git repo via rsync. 
(rsync://rsync.kernel.org/pub/scm/git/git.git)  I got all the commits
up to today but the tags since my initial cloning are missing.

I tried git pull --tags, I still only have old tags.
I switched to using the git protocol but that failed too.

git ls-remotes --tags showed, as expected, all the tags up to 1.2.4.

Is there a switch I missed?

Regards,
David
