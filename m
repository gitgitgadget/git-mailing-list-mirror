From: Adam Panayis <adam@movency.com>
Subject: Re: Strange branch merging.
Date: Thu, 12 Feb 2009 12:59:56 +0000
Message-ID: <49941D4C.80502@movency.com>
References: <49940D93.6000204@movency.com> <E65A809A-65AD-4755-8AA7-32AA11C9AB5A@frim.nl> <499418A4.9060401@movency.com> <FADBCA93-6742-43E8-A4A6-0090FBFF8BAB@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Thu Feb 12 14:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXbCD-0007xJ-G8
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 14:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbZBLNAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 08:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbZBLNAI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 08:00:08 -0500
Received: from august.movency.com ([87.194.169.126]:53050 "EHLO
	august.movency.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbZBLNAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 08:00:07 -0500
Received: from [192.168.1.68] (bashful.movency.com [192.168.1.68])
	(authenticated bits=0)
	by august.movency.com (8.14.2/8.13.8) with ESMTP id n1CCw1tV024911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Feb 2009 12:58:01 GMT
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <FADBCA93-6742-43E8-A4A6-0090FBFF8BAB@frim.nl>
X-Virus-Scanned: ClamAV 0.93.3/8981/Thu Feb 12 00:28:11 2009 on march.movency.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on march.movency.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109614>

Pieter de Bie wrote:
> Hey,
>
> [ Please don't top-post here, it makes following the discussion harder ]
>
> On Feb 12, 2009, at 12:40 PM, Adam Panayis wrote:
>> When I try to do that on box B I get the master branch from box A but 
>> I get the changes made to branch blah on box A.
>>
>> I do not understand why, on box B, the master branch is showing 
>> changes made to the blah branch on box A. (Yet on box A the changes 
>> to the blah branch are not shown in the master)
>
> You probably pulled in the 'blah' branch rather than the 'master' 
> branch because that was
> the branch that is checked out on box A. You can verify this by 
> looking at 'git log' and
> see that the commit on the blah branch is also there. To pull the 
> master branch, specify
> it explicitly, like this:
>
>     git pull boxA:path/to/repo master
>
> - Pieter
Pieter, thank you very much. Looks like that is indeed the mistake I was 
making.
