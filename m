From: Andreas Ericsson <ae@op5.se>
Subject: Re: still unclear on setting up a repository
Date: Sun, 20 Nov 2005 03:10:47 +0100
Message-ID: <437FDB27.1030709@op5.se>
References: <86br0g883v.fsf@blue.stonehenge.com> <437FCC60.3090100@op5.se> <86y83k6ry0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 03:11:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdefM-0007Gw-SR
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 03:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVKTCKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 21:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVKTCKu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 21:10:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59880 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751152AbVKTCKt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 21:10:49 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 358606BD00; Sun, 20 Nov 2005 03:10:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86y83k6ry0.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12365>

Randal L. Schwartz wrote:
>>>And then, another "go-boom" problem:
>>>% cg-fetch
>>>Hard links don't work - using copy
>>>Fetching head...
>>>cp: illegal option -- d
> 
> 
> Andreas> I think this was resolved some weeks ago. Perhaps you could try the
> Andreas> latest cogito from git://git.kernel.org/pub/scm/cogito/cogito.git ?
> 
> I'm grabbing nearly hourly.
> 
>     localhost:~/MIRROR/cogito-GIT % cg-status
>     Heads:
>        >master      22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f
>       R origin      22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f
> 
> Error with this version.
> 

You're right. It was the '-b' option that was removed earlier (which you 
reported as well, ten days ago).

> Andreas> As for rsync; From the output you posted above, you were setting up
> Andreas> both the repositories on your local machine. Using rsync for those
> Andreas> cases would be pretty stupid.
> 
> rsync instead of cp if you really need "-d".
> 

There are other problems with rsync. It would actually be faster to use 
the git-daemon on localhost than using rsync for operations between two 
local repositories.

> Andreas> On a side-note, could you please turn off your spamvertising
> Andreas> auto-reply? It sends me some info about your perl-expertise and
> Andreas> contact-numbers every now and then. It's getting a bit annoying.
> 
> If you email me directly, you'll get that note no more than once per
> month.  Some day, I'll create a system to whitelist people that never
> want to see it again.  Damn TUIT shortage. :)
> 

It's not the amount of mail that annoys me. It's the principle of the 
thing. Perhaps you can use a different email when participating in list 
discussions? It's not exactly right to ask others to tell you they don't 
want your spam after all.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
