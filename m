From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 22:51:44 -0400
Message-ID: <429539C0.8050609@cobite.com>
References: <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188> <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org> <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <20050524045840.GI12141@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 04:50:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db8Rp-0007m1-L8
	for gcvg-git@gmane.org; Thu, 26 May 2005 04:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVEZCv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 22:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVEZCv5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 22:51:57 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:27522 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261163AbVEZCvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 22:51:54 -0400
Received: from [192.168.0.101] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-02.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j4Q2pmId011184;
	Wed, 25 May 2005 22:51:48 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524045840.GI12141@cip.informatik.uni-erlangen.de>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Thomas Glanzmann wrote:
> Hello,
> 
> 
>>	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
>>	    memdisk/init32.asm:1.3=after, memdisk/Makefile:1.26=before. Treated as 'before'
>>	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
>>	    memdisk/init32.asm:1.3=after, memdisk/e820test.c:1.7=before. Treated as 'before'
>>	...
> 
> 
> actually I think this is the broken upstream version. It can't parse
> dates right. Just look at the exported patches and see if them all from
> 1970. However the debian package has a patch in which solves it:
> 
> maybe you should try with the attached patch or with the version that
> comes with debian sarge. I also reported this problem a while back to
> the original author.
> 

I was about to apply this and I already had in it my cvs tree!  Funny 
how these things go.  I must have gotten it before, applied it and never 
released a new version.  Funny that this one hase the tm.tm_isdst = 0 
that is missing from the version I applied (and fixes an important bug).

Anyway, I'm about to release a new version cumulative with all this, a 
fixed ancestor version, correct ordering for those pesky import commits, 
and a couple other annoying fixes.

BTW: the above warnings are actually legit in this case.

David
