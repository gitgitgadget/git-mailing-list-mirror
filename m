From: Jens Otten <j.otten@plusserver.de>
Subject: Feature or a bug: git aliases are executed in git-root directory
Date: Wed, 14 Apr 2010 13:18:27 +0200
Message-ID: <4BC5A483.6060206@plusserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 14:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O21PM-0002i8-J6
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 14:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab0DNMJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 08:09:23 -0400
Received: from mailout.intergenia.de ([217.172.171.6]:38049 "EHLO
	mailout.intergenia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab0DNMJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 08:09:22 -0400
X-Greylist: delayed 1795 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2010 08:09:22 EDT
Received: from [172.16.11.42] (helo=CA2.win.privatnetz.org)
	by mailout.intergenia.de with esmtp (Exim 4.69)
	(envelope-from <J.Otten@plusserver.de>)
	id 1O20cG-00032x-DR
	for git@vger.kernel.org; Wed, 14 Apr 2010 11:18:44 +0000
Received: from [192.168.100.103] (92.79.156.138) by owa.privatnetz.org
 (172.16.11.44) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 14 Apr
 2010 13:18:44 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144866>

Hi,

i started to use git (version is 1.6.3.3 (ubuntu)) and it is really great!

but i have one problem when using aliases. maybe i made a mistake, but 
here is my problem.

i set up my ~/.gitconfig as follows:
----------
...
[alias]
    meld = !GIT_EXTERNAL_DIFF='git-diff-to-meld-redirect' git diff
...
----------

now when i work in a subdirectory of my git-root dir and want to make a 
diff, this works perfectly:
$ cd ~/git-root/subdir
$ git diff some_file

but when doing the same using the alias i get an error:
$ cd ~/git-root/subdir
$ git meld some_file
fatal: ambiguous argument 'some_file': unknown revision or path not in 
the working tree.
Use '--' to separate paths from revisions

whereas using the relative path starting from the git-root directory works
$ cd ~/git-root/subdir
$ git meld subdir/some_file

is there a way to solve this problem?

thanks for your help
jens
