From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 15:43:18 -0400
Message-ID: <429383D6.6010908@cobite.com>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:44:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafHm-0003Cb-4E
	for gcvg-git@gmane.org; Tue, 24 May 2005 21:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVEXTn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 15:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVEXTn3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 15:43:29 -0400
Received: from iris.cobite.com ([208.222.83.2]:9346 "EHLO email-pri.cobite.com")
	by vger.kernel.org with ESMTP id S261963AbVEXTnX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 15:43:23 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id D14C698039; Tue, 24 May 2005 15:43:15 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12386-01; Tue, 24 May 2005 15:43:15 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id A14EC9855B; Tue, 24 May 2005 15:43:15 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id EA5AB98039; Tue, 24 May 2005 15:43:11 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Glanzmann wrote:
> Hello,
> 
> 
>>And if this doesn't work for you, point me to the CVS archive that causes 
>>you trouble.
> 
> 
> you should try the mutt cvs repository[1].

Sounds good.  I'll give it a try.  I'm testing the branch ancestor 
logic, which seems to be working better now.  The version I sent to the 
list yesterday was pretty bogus for some cases, as well as reporting the 
ancestor multiple times for any give branch.

> 
> I have the following issues all seem easy to fix:
> 
> 	- PatchSet 1 depends on PatchSet 2 (but cvsps gets the ordering wrong;
> 	  should be easy fixable) (I just swichted the two before
> 	  running cvs2git)
> 

There is something strange about 'cvs import' I believe which causes 
various bizarre things to happen to the first cvsps patchset.  I haven't 
looked at mutt cvs yet, but this could be the cause.  If you see a lot 
of version numbers 1.1.1.1 then this is indeed the problem.

> I used the attached patch against cvsps-2.0rc1 which fixes date
> covnersion problems and of course includes the ancestor thing.

I'll look at taking these patches upstream.  The 'MT' fix is already in 
my cvs of cvsps, and the rest looks pretty good.

Do you know where I can get attribution information for these changes? 
Are they all from you? (I'm not familiar with debian at all)

David
