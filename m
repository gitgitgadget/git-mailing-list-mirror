From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-daemon: path validation, export all option
Date: Tue, 27 Sep 2005 08:36:18 -0700
Message-ID: <433966F2.3090304@zytor.com>
References: <4338AACC.1050305@zytor.com> <Pine.LNX.4.58.0509270802140.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 17:41:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKHVJ-0000pc-KA
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 17:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVI0PgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVI0PgX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 11:36:23 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:11219 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S964974AbVI0PgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 11:36:22 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8RFaIJv025357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2005 08:36:19 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509270802140.3308@g5.osdl.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9401>

Linus Torvalds wrote:
> 
> Removing the "chdir(".git")" thing is very wrong, though. Why do it?
> 
> It's very much on purpose: you can export even "regular" git trees (ie 
> trees you have checked out) without the other side having to say
> 
> 	git clone machine.com:/home/torvalds/v2.6/linux/.git
> 
> where the final "/.git" is just stupid.
> 

Agreed.  I wasn't thinking too hard about it, and it doesn't do any harm 
since failure is ignored.

	-hpa
