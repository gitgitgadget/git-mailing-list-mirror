From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb wishlist
Date: Mon, 23 May 2005 20:39:30 -0700
Message-ID: <4292A1F2.7020606@zytor.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 05:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaQFj-0008T8-Fa
	for gcvg-git@gmane.org; Tue, 24 May 2005 05:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVEXDkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 23:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEXDkL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 23:40:11 -0400
Received: from terminus.zytor.com ([209.128.68.124]:25511 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261353AbVEXDj6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 23:39:58 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4O3dUNt014288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 May 2005 20:39:31 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Mansfield <david@cobite.com>
In-Reply-To: <4292A08A.5050108@cobite.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Mansfield wrote:
> 
> Ok.  I'll tell you.  It means that the committer uses bad practices in 
> tagging ;-)  It generally means that force tag (cvs tag -F <file>) was 
> used on a specific file.  Here's the scenario:
> 
> cvsps is trying to associate a tag to a specific commit.  But in the cvs 
> world this is not always at all possible.  If, for example, a commit 
> made and  all files are tagged.  Now some random file is modified and 
> committed.  Then, a bug is found in a file from the previously tagged 
> set, say the file 'memdisk/init32.asm'.  The bug is fixed, committed and 
> the tag is MOVED for _just that file_ forward to the new version.  Now 
> there is no commit that can be associated with the tag.  In this case, 
> cvsps believes this to be a 'FUNKY' tag.  There is a more pathological 
> case having to do with 'INVALID' tags...  It's enough to make a grown 
> man cry.
> 

This is only pathological if the tag now represents a state that never 
actually existed in the history of the repository.  I don't believe 
there are any such cases in the syslinux repository; I could be wrong, 
but I am *highly* sceptical.

> 
> I accept patches ;-)  Honestly, handling binary data should be trivial I 
> just haven't had the interest, and surprisingly noone else on the 
> internet ever has.  The only binary file in the kernel appears to be the 
> logo.gif, according to Ingo.
> 
> [ discussion on working around broken handling of binary files in cvsps]
> 

Actually, as long as we can create the tree that exists between each 
changeset, we should be OK.

> 
> Hey, a polished turd is only so shiny...  cvsps is a 99% solution [to 
> the problem of extracting metatdata from cvs] only and cvs makes the 
> other 1% impossible.
> 

No sh*t...

	-hpa
