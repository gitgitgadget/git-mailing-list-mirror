From: Adam Panayis <adam@movency.com>
Subject: Re: Strange branch merging.
Date: Thu, 12 Feb 2009 12:40:04 +0000
Message-ID: <499418A4.9060401@movency.com>
References: <49940D93.6000204@movency.com> <E65A809A-65AD-4755-8AA7-32AA11C9AB5A@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXatx-0001SC-O6
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 13:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438AbZBLMkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759139AbZBLMkQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:40:16 -0500
Received: from august.movency.com ([87.194.169.126]:51212 "EHLO
	august.movency.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759170AbZBLMkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 07:40:15 -0500
Received: from [192.168.1.68] (bashful.movency.com [192.168.1.68])
	(authenticated bits=0)
	by august.movency.com (8.14.2/8.13.8) with ESMTP id n1CCc8DM024876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Feb 2009 12:38:09 GMT
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <E65A809A-65AD-4755-8AA7-32AA11C9AB5A@frim.nl>
X-Virus-Scanned: ClamAV 0.93.3/8981/Thu Feb 12 00:28:11 2009 on march.movency.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on march.movency.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109610>

Pieter, thanks for your advice.

I am never using the push command here.

Box A has branches master and blah.
On Box B I just want to pull branch master.

When I try to do that on box B I get the master branch from box A but I 
get the changes made to branch blah on box A.

I do not understand why, on box B, the master branch is showing changes 
made to the blah branch on box A. (Yet on box A the changes to the blah 
branch are not shown in the master)

Apologies for my babbling.

Adam

Pieter de Bie wrote:
>
> On Feb 12, 2009, at 11:52 AM, Adam Panayis wrote:
>
>> Once this is done I double check my branches and it shows I still 
>> only have the master. Perfect. However, when I check the file I 
>> edited on my local machine on the blah branch, the changes are there.
>>
>> Am I fundamentally misunderstanding the correct usage of git? Is this 
>> result expected?
>
> Yes, git pull will never change anything on the remote side. You 
> should use 'git push' for that. But, you shouldn't push to repository 
> with a working directory unless you know what you're doing -- read 
> http://git.or.cz/gitwiki/GitFaq#non-bare for that.
>
> - Pieter
