From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: How to "git add ." when some files are not accessible (permission
 denied)?
Date: Sat, 01 Mar 2008 14:46:28 +0100
Message-ID: <47C95E34.1050306@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVS9G-0001F1-UY
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257AbYCANwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbYCANwf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:52:35 -0500
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:44505 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246AbYCANwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:52:34 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Mar 2008 08:52:34 EST
Received: from [84.176.112.170] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JVS2m-0004Rq-LK
	for git@vger.kernel.org; Sat, 01 Mar 2008 14:46:28 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75676>

Hello --

First of all: I'm using Git with Windows. Most of the time it works 
*very* good, but now I've a problem that might appear to Unix users as 
well. I had the idea to use Git to track changes in my C:\WINDOWS 
directory. I thought the following would work:

$ cd /c/WINDOWS             (1)
$ git init                  (2)
$ git add .                 (3)
$ git commit -m "Initial"   (4)

And then issue "git status" or so to see the differences after 
installing or running some software.

However, when issueing (3) "git add ." it adds hundreds and thousands of
files and then stops with

     error: open("foo"): Permission denied: foo
     fatal: unable to index file foo

The file "foo" is not accessible for me, even though I'm administrator.
This might occur to Windows and Linux persons as well, I guess. The 
adding stops overall.

The question is: is there a way to tell "git add ." to add all files but
ignore those that cannot be added due to lack of authorization?

Or, more generally spoken: can I tell "git add" to add only those files 
it can handle and ignore the rest? The "-f" switch doesn't work and some
exclude lists on a per file basis are not applicable for my purpose as I
don't know the files in advance.

I'm aware that I could do it with some fancy shell commands, but very 
often I was surprised how many really cool commands Git offers to "do 
what I mean". Wished other software would be so usable :-).


Cheers,
  -- Dirk
