From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 11:12:21 +0200
Organization: At home
Message-ID: <e735d7$6dq$1@sea.gmane.org>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz> <e72j53$1m1$1@sea.gmane.org> <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com> <e731ai$su1$1@sea.gmane.org> <20060618113052.660e1017.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 18 11:12:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrtKP-0004TA-5T
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 11:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWFRJMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWFRJMS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 05:12:18 -0400
Received: from main.gmane.org ([80.91.229.2]:41915 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932178AbWFRJMR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 05:12:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrtKJ-0004Sm-K8
	for git@vger.kernel.org; Sun, 18 Jun 2006 11:12:16 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 11:12:15 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 11:12:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22065>

Timo Hirvonen wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> 
>> - use ~/.gitconfig, /etc/gitconfig or some other global git configuration 
>>   file, reading values using '$gitexecdir/git-repo-config'.
>>   Problem: bootstraping, namely value of $gitexecdir ($gitbin now)
>>   needs to be set in gitweb.cgi, perhaps during the build process.
> 
> Just use "git command" and you don't have to know $gitexecdir.

First, 'git' might be not in PATH for the webserver user which runs
gitweb.cgi.

Second, I guess that '$gitexecdir/git-repo-config' is/can be faster than
'git repo-config', but if 'git' is in the PATH we can set $gitexecdir from
'git --exec-path'.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
