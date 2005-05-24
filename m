From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 13:08:38 -0400
Message-ID: <42935F96.8030205@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 19:14:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DacwM-00007p-T6
	for gcvg-git@gmane.org; Tue, 24 May 2005 19:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEXRMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVEXRL3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 13:11:29 -0400
Received: from iris.cobite.com ([208.222.83.2]:25069 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S261292AbVEXRIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 13:08:42 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 351BF9888E; Tue, 24 May 2005 13:08:35 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07740-07; Tue, 24 May 2005 13:08:35 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id ED00A988A1; Tue, 24 May 2005 13:08:34 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id DDDB39888E; Tue, 24 May 2005 13:08:31 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Linus Torvalds wrote:
> 
>>It has the logic for branches, but it doesn't work, and I'm fed up enough
>>with CVS and RCS for the moment that I'm not going to work on it any more
>>tonight.
> 
> 
> I'm back, and yes, it was a really stupid thing.
> 
> However, David, I need more help deciphering "cvsps" output..
> 
> Fixing the branch handling shows that cvsps does some really strange
> things with the newly added "Ancestor grpah". Here's one example:
> 

Yes.  While not falling asleep last night I realized that the 
quick-and-dirty approach was bogus.  I need to track what the ancestor 
is as I'm building up the data structure, not while outputting it.  So 
I'm working on a correct version which puts ancestor_branch into the 
PatchSet structure itself.

It's completely done now except for that it segfaults instantly.

BTW where did you get the cvsroot for syslinux?  Could I get a copy 
somewhere?

David


