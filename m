From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Fri, 12 Aug 2005 16:24:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0508121618140.20901@qynat.qvtvafvgr.pbz>
References: <20050812210611.GF13550@birddog.com><20050812220120.EF075353AED@atlas.denx.de>
 <46a038f905081216013941b2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Wolfgang Denk <wd@denx.de>,
	"Kirby C. Bohling" <kbohling@birddog.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 01:26:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3itd-00041Z-EZ
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 01:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVHLXYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVHLXYx
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 19:24:53 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:26082 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1751245AbVHLXYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 19:24:53 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 12 Aug 2005 16:19:52 -0700
Received: by ATHEXC01 with Internet Mail Service (5.5.2657.72)
	id <QZL4P7WK>; Fri, 12 Aug 2005 19:24:16 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id QT8M4CHJ; Fri, 12 Aug 2005 16:23:12 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
X-X-Sender: dlang@dlang.diginsite.com
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <46a038f905081216013941b2c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 13 Aug 2005, Martin Langhoff wrote:

>>> I don't think he wants sourceforge to host git, I think he'd like
>>> sourceforge to provide access to source trees via git, instead of
>>> cvs.  Read that as, I want to do:
>>
>> Correct, that's what I am looking for. My  hope  is  that  if  enough
>> people ask SF might actually provide such a service.
>
> Ubuntu's 'launchpad' project is trying to do that (a SCM 'proxy' of
> sorts) with Arch/Bazaar/BazaarNG/Whatever. It takes massive ammounts
> of diskpace and computing power to be tracking external cvs/svn repos
> in your SCM format of choice. The talked abundantly about this at the
> last Debconf in nightless helsinki.

Actually, if HPA can (or has) work out the kinks for combining the object 
stores for different projects I think you will find that a site like 
sourceforge could actually find that across all their differnt projects 
git will require significantly less space then first thought. I believe 
that there is a significant number of files that are going to be the same 
in different project (for example COPYING, or if a project is forked, most 
of the files in a project) and therfor will just refer to the same object 
blob.

now when you start makeing packs this sort of thing can make the optimal 
logic for deciding what's in each pack 'interesting', but as long as each 
pack is self contained the rest of the git tools will handle things just 
fine.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
