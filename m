From: Marius Seritan <mseritan@decodeideas.com>
Subject: Re: hot to fix git svn import or just discard 'branches' folder
Date: Wed, 4 Feb 2009 11:05:21 -0800
Message-ID: <5713EFD1-E6E7-4FD5-BF17-FDA5FF6F7C6B@decodeideas.com>
References: <7E976223-6794-4E87-94A5-DEA224759700@decodeideas.com> <D92EB2AE-392D-4F05-8DF3-999BE78C80FF@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUn64-000865-Mk
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762357AbZBDTFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762298AbZBDTFc
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:05:32 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:56107 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762304AbZBDTF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:05:28 -0500
Received: by an-out-0708.google.com with SMTP id c2so1084266anc.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:05:25 -0800 (PST)
Received: by 10.64.153.7 with SMTP id a7mr1798872qbe.110.1233774324565;
        Wed, 04 Feb 2009 11:05:24 -0800 (PST)
Received: from ?192.168.2.201? ([72.14.241.159])
        by mx.google.com with ESMTPS id s30sm3227735qbs.20.2009.02.04.11.05.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 11:05:23 -0800 (PST)
In-Reply-To: <D92EB2AE-392D-4F05-8DF3-999BE78C80FF@silverinsanity.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108412>

Thanks Brian,


On Feb 4, 2009, at 10:39 AM, Brian Gernhardt wrote:

>
> On Feb 4, 2009, at 12:03 PM, Marius Seritan wrote:
>
>> I imported over night an svn repository with the command:
>>
>> git svn clone --prefix svn/ -r 860  http://svn.some.com/svn/someproject
>>
>> The svn repository uses the usual trunk, branches, tag so I  
>> (wrongly?) assumed I do not need to pass any command switches  
>> regarding the structure of the repo.
>
> "git svn clone URL" attempts to act like "svn co URL", but with  
> history.  If you only want to download the trunk, then you should  
> add "/trunk" to the end of the URL.  If you want to capture all the  
> branches, tags, etc you should use "--stdlayout" (also spelled "-s").

I want to capture the current trunk and any new branches. It seems the  
-s is required if I do a reimport.


>
>
>> I obviously did something wrong because now I have a git repository  
>> with just one remote branch and it contains the folders trunk,  
>> branches and tag. I do not want to reimport because it is taking  
>> lots of time and bandwidth.
>
> I believe fixing this without reimporting requires using "git filter- 
> branch".  I'm unfamiliar with it, so I can't help you with that part.

Thanks, I will look into it. From the first read this seems to be  
pretty advanced.

>
>
> However, I'm curious as to why this took a lot of time because the "- 
> r 860" on the command line should tell git-svn to only download a  
> single revision.  Is it a particularly repository?

All of the repository was imported including branches in spite of the - 
r. This is private repository for a company's web site, it has your  
usual assortment of jars and the history has a dozen branches and a  
couple of tags.  The size on the disk is about 3GB, I was a bit  
surprised by it.

Marius

>
>
> ~~ Brian
