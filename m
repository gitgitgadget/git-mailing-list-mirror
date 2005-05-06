From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: read-only git repositories (ancient history)
Date: Thu, 05 May 2005 23:01:00 -0400
Message-ID: <427ADDEC.3060709@dwheeler.com>
References: <Pine.LNX.4.21.0505041854040.30848-100000@iabervon.org> <200505050709.43307.alan@chandlerfamily.org.uk> <Pine.LNX.4.62.0505050231300.15451@qynat.qvtvafvgr.pbz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 04:52:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTswI-0001Jj-DH
	for gcvg-git@gmane.org; Fri, 06 May 2005 04:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVEFC6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 22:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEFC6N
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 22:58:13 -0400
Received: from aibo.runbox.com ([193.71.199.94]:17285 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262196AbVEFC6K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 22:58:10 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DTt2X-0007gW-E5; Fri, 06 May 2005 04:58:09 +0200
Received: from [70.21.9.158] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DTt2W-0001rX-PL; Fri, 06 May 2005 04:58:09 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0505050231300.15451@qynat.qvtvafvgr.pbz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Lang wrote:
> given that git already treats everything in the object storage as being 
> fixed it occured to me that there may be value in makeing it so that git 
> can make use of more then one pool of storage
...
> there are probably other uses and it seems like a fairly small 
> modification to add a hook to use if the object isn't found initially 
> that I thought I'd mention it to the group.

Reasonable.  Another use would be to have a repository with
"ancient history" (e.g., Linux pre-2.6) that isn't normally
loaded or looked at, but COULD be looked at if you added
that repository.  For that use, though, you'd need a way to
record "the parent of X is Y" since the information creating
connections BETWEEN the repositories might not be stored in
the later repository itself (see the discussions about Linux kernel
history recreation).

--- David A. Wheeler
