From: John Freeman <jfreeman@cs.tamu.edu>
Subject: Re: clone fails: Could not get the current working directory
Date: Sun, 21 Sep 2008 17:18:10 -0500
Message-ID: <48D6C822.7050602@cs.tamu.edu>
References: <48D59A30.5020403@cs.tamu.edu> <d3a045300809211012l35b1ec2dq39f4174170d8c926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Johnston <pcj127@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 00:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhXGV-0005X8-JU
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 00:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYIUWRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 18:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYIUWRn
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 18:17:43 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:29213 "EHLO
	sr-3-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752369AbYIUWRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 18:17:42 -0400
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-3-int.cis.tamu.edu (Postfix) with ESMTP id 972C41F604;
	Sun, 21 Sep 2008 17:17:41 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from b2.local (c-98-195-114-24.hsd1.tx.comcast.net [98.195.114.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-3-int.cis.tamu.edu (Postfix) with ESMTPSA id 4E1251F5F3;
	Sun, 21 Sep 2008 17:17:40 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <d3a045300809211012l35b1ec2dq39f4174170d8c926@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96442>

Paul Johnston wrote:
> On the server, where is git installed? I had a similar problem with
> clone when my git installation was not in a PATH known to ssh. 
It is installed in a non-standard directory, /opt/csg/bin.  This is part 
of the system-wide PATH defined in /etc/bashrc.  I also added it to my 
~/.bashrc before I discovered that fact. 
> Try
> creating symlinks from usr/bin (for example) to your git executables
> to see if this solves the problem.
I did create symlinks in $HOME/local/bin which is in the PATH defined in 
my ~/.bashrc.  I do not have administrator privileges, so I cannot put 
symlinks in /usr/bin.  I think it is finding the executable just fine, 
but that there is some issue with accessing the repo directory.  I have 
tested with

 > ssh user@remote.system.edu -- "git-upload-pack"

and it works as expected.
>   Also, search the archives for
> git-upload-pack.
>   
I've skimmed it, and I see nothing related to my problem.  Specifying 
--upload-pack explicitly gives the same error.

Thank you for the response, though.  Are there any other ideas?

- John
