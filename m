From: Wink Saville <wink@saville.com>
Subject: Re: git-svn segmetation fault
Date: Fri, 01 Feb 2008 19:55:20 -0800
Message-ID: <47A3E9A8.1060102@saville.com>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 04:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL9Ty-00019l-Ns
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 04:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbYBBDzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 22:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbYBBDzY
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 22:55:24 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:4681 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbYBBDzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 22:55:23 -0500
Received: by an-out-0708.google.com with SMTP id d31so335404and.103
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 19:55:23 -0800 (PST)
Received: by 10.100.249.9 with SMTP id w9mr9001242anh.44.1201924522918;
        Fri, 01 Feb 2008 19:55:22 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id 34sm356165agc.32.2008.02.01.19.55.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Feb 2008 19:55:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080202034258.GA27814@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72218>

Steven Walter wrote:
> On Fri, Feb 01, 2008 at 04:50:55PM -0800, Wink Saville wrote:
>   
>> Wink Saville wrote:
>>     
>>> I was doing an git-svn dcommit and got a seg fault. The first
>>> phase of updating svn completed and then it seg faulted on the
>>> second. So I suspect I'm out of sync and need to recover,
>>> any guidance appreciated.
>>>       
>
> Can you show the contents of .git/config ?
>   
wink@ic2d1:$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://async-msgcomp.googlecode.com/svn/trunk
        fetch = :refs/remotes/git-svn
[gui]
        geometry = 999x958+1767+172 407 407
[remote "origin"]
        url = git://192.168.0.8/async-msgcomp.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[merge]
        tool = kdiff3
wink@ic2d1:$
