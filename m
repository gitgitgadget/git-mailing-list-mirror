From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: pushing specific branches to a public mirror repos
Date: Fri, 17 Jul 2009 11:11:59 +0200
Message-ID: <h3pf9d$mo7$1@ger.gmane.org>
References: <h3pcrg$ekk$1@ger.gmane.org> <4A603B7A.6050208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 11:12:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRjUc-0003Am-Px
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 11:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934259AbZGQJMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 05:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934253AbZGQJMa
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 05:12:30 -0400
Received: from main.gmane.org ([80.91.229.2]:34308 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934252AbZGQJMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 05:12:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MRjUP-0005Iu-CI
	for git@vger.kernel.org; Fri, 17 Jul 2009 09:12:25 +0000
Received: from 41.177.101.200 ([41.177.101.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 09:12:25 +0000
Received: from graemeg by 41.177.101.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 09:12:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.101.200
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A603B7A.6050208@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123454>

Johannes Sixt wrote:
> 
> You can have more than one push line in the config:
> 
>     push = +refs/remotes/trunk:refs/heads/trunk
>     push = +refs/remotes/fixes_2_2:refs/heads/fixes_2_2


Excellent, thanks. I thought about that, but wasn't sure and did not 
want to try because I already screwed up the GitHub mirror once before.


 >     push = +refs/remotes/trunk:refs/heads/trunk

Must this stay as is, or must I push 'remotes/trunk' to 'heads/master'?


      push = +refs/remotes/trunk:refs/heads/trunk
vs
      push = +refs/remotes/trunk:refs/heads/master


 From my server...
$ git ls-remote github
6b9b6460aa79a4b86c6bb1535b78e4fc555f89d5	HEAD
6b9b6460aa79a4b86c6bb1535b78e4fc555f89d5	refs/heads/master


My local "master" branch is currently tracking the refs/remotes/trunk, 
but for some reason (which I don't understand), if I do a 'git svn 
fetch' by default master branch is not updated. I still have to run 'git 
svn rebase -l' to get master in sync. Is there something I can change in 
the config to automate that as well?



Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
