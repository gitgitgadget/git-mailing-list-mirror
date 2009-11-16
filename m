From: Lorenzo Bettini <bettini@dsi.unifi.it>
Subject: Re: pushing remote branches
Date: Mon, 16 Nov 2009 16:27:32 +0100
Message-ID: <hdrr1e$oub$1@ger.gmane.org>
References: <hdneuv$nc8$2@ger.gmane.org>	 <2e24e5b90911141645n59680856ja21f2f3c7063f7c0@mail.gmail.com>	 <hdoko1$s78$1@ger.gmane.org> <2e24e5b90911150304i1472ed13k6c60611ef2e9ba19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 16:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA3VP-00074I-Jo
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 16:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZKPP21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 10:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZKPP20
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 10:28:26 -0500
Received: from lo.gmane.org ([80.91.229.12]:60067 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbZKPP20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 10:28:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NA3Uz-0006kP-6P
	for git@vger.kernel.org; Mon, 16 Nov 2009 16:28:13 +0100
Received: from nat2.di.unito.it ([130.192.156.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:28:13 +0100
Received: from bettini by nat2.di.unito.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:28:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat2.di.unito.it
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <2e24e5b90911150304i1472ed13k6c60611ef2e9ba19@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133009>

Sitaram Chamarty wrote:
> 
>> Thus, if I had
>>
>> [remote "origin"]
>>            fetch = +refs/heads/*:refs/remotes/origin/*
>>            url = git@...
>> [branch "master"]
>>            remote = origin
>>            merge = refs/heads/master
>> [branch "experiments"]
>>            remote = origin
>>            merge = refs/heads/experiments
>>
>> instead of
>>
>> [remote "origin"]
>>            fetch = +refs/heads/*:refs/remotes/origin/*
>>            url = git://...
>> [branch "master"]
>>            remote = origin
>>            merge = refs/heads/master
>> [branch "experiments"]
>>            remote = origin
>>            merge = refs/heads/experiments
>>
>> I would have been able to push also to branch experiments?   Without having
>> to add
>>
>> [remote "experiments"]
>>            url = git@...
>>            fetch = +refs/heads/experiments:refs/remotes/experiments/experiments
>>
>> ?
> 
> (by the way: do you mean refs/remotes/origin/experiments in that last
> line above?)
> 

no, it's just like I wrote it...

you mean in

[remote "experiments"]
         url = git@gitorious.org...
         fetch = 
+refs/heads/experiments:refs/remotes/experiments/experiments

or in

[branch "experiments"]
         remote = origin
         merge = refs/heads/experiments


?

> Anyway to answer your question, I do not see the refspec line as the issue
> here, but the URL for the repo, which determines how you access it.

so this would have been enough:

 >> [remote "origin"]
 >>            fetch = +refs/heads/*:refs/remotes/origin/*
 >>            url = git://...
 >> [branch "master"]
 >>            remote = origin
 >>            merge = refs/heads/master
 >> [branch "experiments"]
 >>            remote = origin
 >>            merge = refs/heads/experiments

?

thanks
	Lorenzo

-- 
Lorenzo Bettini, PhD in Computer Science, DI, Univ. Torino
HOME: http://www.lorenzobettini.it MUSIC: http://www.purplesucker.com
BLOGS: http://tronprog.blogspot.com  http://longlivemusic.blogspot.com
