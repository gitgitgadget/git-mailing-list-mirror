From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: gitweb doesn't work with bare repositories
Date: Sat, 29 Nov 2008 16:24:00 -0800
Message-ID: <4931DD20.6020603@eaglescrag.net>
References: <4931D23A.10402@gmail.com> <20081130000115.GB20403@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Evgeniy Ivanov <lolkaantimat@gmail.com>, git@vger.kernel.org
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 01:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6a6y-00075z-DN
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 01:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYK3AXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 19:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbYK3AXP
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 19:23:15 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:48814 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbYK3AXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 19:23:15 -0500
Received: from [172.19.0.11] (c-67-164-30-157.hsd1.ca.comcast.net [67.164.30.157])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id mAU0M5QU022347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 29 Nov 2008 16:22:05 -0800
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081130000115.GB20403@frsk.net>
X-Virus-Scanned: ClamAV 0.88.7/8696/Sat Nov 29 00:01:59 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sat, 29 Nov 2008 16:22:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101937>

As a note kernel.org uses, predominantly, bare repositories and it works 
fine there....

- John 'Warthog9' Hawley
Chief Kernel.org Administrator

Fredrik Skolmli wrote:
> On Sun, Nov 30, 2008 at 02:37:30AM +0300, Evgeniy Ivanov wrote:
>   
>> Hi,
>>     
>
> Hi.
>
> Just checking now, but are the following corrections right?
>
>   
>> In projects I have created bare repo:
>> mkdir some
>>     
>
> mkdir some.git
>
>   
>> cd some.git
>> git --bare init
>> cd /some_git_repo
>> git push /srv/www/gamekeeper/htdocs/projects master
>>     
>
> git push /srv/www/gamekeeper/htdocs/projects/some.git master
>
>   
>> Permissions are ok, virtual host is ok since I get main page and have
>> access to cloned repo.
>>     
>
> You're sure the user the webserver is running as has access to the repo as
> well?
>
> - Fredrik
>
>   
