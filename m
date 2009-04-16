From: Lucas Sandery <lucas@wallcann.com>
Subject: Re: releasing your work
Date: Thu, 16 Apr 2009 17:10:40 +0930
Message-ID: <49E6E0F8.4050506@wallcann.com>
References: <49E6B9E3.30707@wallcann.com> <20090416064602.GA3668@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 09:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMEl-0007fx-Oo
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 09:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbZDPHkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 03:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbZDPHkq
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 03:40:46 -0400
Received: from carbon.wallcanndns.com ([202.174.106.50]:60543 "EHLO
	host.carbon.wallcanndns.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648AbZDPHkp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2009 03:40:45 -0400
Received: from 219-90-196-119.static.adam.com.au ([219.90.196.119] helo=[192.168.1.102])
	by host.carbon.wallcanndns.com with esmtpa (Exim 4.69)
	(envelope-from <lucas@wallcann.com>)
	id 1LuM6l-0006xs-OQ
	for git@vger.kernel.org; Thu, 16 Apr 2009 17:34:03 +1000
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090416064602.GA3668@lars.home.noschinski.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.carbon.wallcanndns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - wallcann.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116680>


Lars Noschinski wrote:
> * Lucas Sandery [09-04-16 06:53]:
>   
>> How do I make a "release" a copy (not a clone) of the repository that contains 
>> only tracked files without .gitignore files? I am using git archive but the 
>> resulting zip file still contains .gitignore files.
>>     
> Have a look at the git-archive man page. You can exclude such files by
> adding the export-ignore attribute to gitattributes.
>   
Thanks Lars,

For anyone else out there with the same problem...

I made a .gitattributes file and it contains only 2 lines:
.gitignore export-ignore
.gitattributes export-ignore

I make my release with:
git archive --format=zip -9 master > ../release.zip
(after right-clicking on my repos root folder and selecting "git bash", 
i'm on a windoze machine at work)
the "../" puts the archive next to the repository folder not in it
e.g. for
c:\path\to\repos\
i get
c:\path\to\release.zip
