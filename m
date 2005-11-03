From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 19:30:28 +0000
Message-ID: <200511031930.28929.alan@chandlerfamily.org.uk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <200511031848.58040.alan@chandlerfamily.org.uk> <20051103191652.GA28273@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 20:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXknA-00086D-T7
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 20:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbVKCTaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 14:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbVKCTaa
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 14:30:30 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:54473
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030455AbVKCTa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 14:30:29 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EXkn6-0006Ir-Ks
	for git@vger.kernel.org; Thu, 03 Nov 2005 19:30:28 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051103191652.GA28273@bohr.gbar.dtu.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11087>

On Thursday 03 Nov 2005 19:16, Peter Eriksen wrote:

>
> Perhaps something like this is better (now I actually tried it out):
>
> ]rm -rf linux-2.6/.git
> ]cp -r linux-2.6 peter-2.6
> ...Initialize a repo in linux-2.6 with cg-init or similar and commit.
> ...Remove, add and change files in peter-2.6.
> ]mv linux-2.6/.git peter-2.6/.git
> ]cd peter-2.6/
> ]git-status
>
> How does this work for you?

This is the same as before.  It lists the modified files, but it doesn't tell 
you about any added or deleted files.

[I have done this manually now - originally I thought that there were quite a 
few files - but once I had stripped out things like "tags" and some spurious 
directories that were empty it ended up being only three files:-).  So its 
only an intellectual exercise now:-)]

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
