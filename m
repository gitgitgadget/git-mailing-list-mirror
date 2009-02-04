From: Marius Seritan <mseritan@decodeideas.com>
Subject: Re: hot to fix git svn import or just discard 'branches' folder
Date: Wed, 4 Feb 2009 11:24:49 -0800
Message-ID: <06C1D783-D51B-49E9-92A2-C1EA035BE3D6@decodeideas.com>
References: <7E976223-6794-4E87-94A5-DEA224759700@decodeideas.com> <D92EB2AE-392D-4F05-8DF3-999BE78C80FF@silverinsanity.com> <5713EFD1-E6E7-4FD5-BF17-FDA5FF6F7C6B@decodeideas.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:26:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUnO9-0006z5-Ua
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbZBDTY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbZBDTYz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:24:55 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:10982 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbZBDTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:24:54 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1000834yxm.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:24:53 -0800 (PST)
Received: by 10.64.242.4 with SMTP id p4mr2544115qbh.84.1233775492961;
        Wed, 04 Feb 2009 11:24:52 -0800 (PST)
Received: from ?192.168.2.201? ([72.14.241.159])
        by mx.google.com with ESMTPS id s12sm2414212qbs.29.2009.02.04.11.24.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 11:24:52 -0800 (PST)
In-Reply-To: <5713EFD1-E6E7-4FD5-BF17-FDA5FF6F7C6B@decodeideas.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108414>


On Feb 4, 2009, at 11:05 AM, Marius Seritan wrote:
>>
>> I believe fixing this without reimporting requires using "git  
>> filter-branch".  I'm unfamiliar with it, so I can't help you with  
>> that part.
>
> Thanks, I will look into it. From the first read this seems to be  
> pretty advanced.

Ok, I think I killed it :-/

I did
git filter-branch --subdirectory-filter trunk -- --all

This cleaned up git and I have just the trunk for 218MB, that's much  
more acceptable. Unfortunately 'git svn rebase' now returns:

Unable to determine upstream SVN information from working tree history

I went into the .git/config and added a trunk but no luck. I also  
edited .git/svn/.metadata in the same way.

As another data point git svn log is still working.


Marius
