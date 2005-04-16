From: Mike Taht <mike.taht@timesys.com>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 12:42:23 -0700
Message-ID: <42616A9F.1030302@timesys.com>
References: <20050416131528.GB19908@elte.hu>	<Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>	<7vmzry7ev5.fsf@assigned-by-dhcp.cox.net>	<42615B00.6090106@timesys.com> <7v8y3i7cn9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 16 21:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMt7x-0000lg-Gm
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVDPTm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVDPTm3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:42:29 -0400
Received: from mail.timesys.com ([65.117.135.102]:20781 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262743AbVDPTmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 15:42:25 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 16 Apr 2005 15:37:49 -0400
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v8y3i7cn9.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 16 Apr 2005 19:37:49.0578 (UTC) FILETIME=[C5DC16A0:01C542BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"MT" == Mike Taht <mike.taht@timesys.com> writes:
> 
> 
> MT> alternatively, "git-archive-torrent" to create a list of files for a
> MT> bittorrent feed....
> 
> That is certainly good for establishing the baseline, but you
> still need to leverage the inherent delta-compressibility
> between related blobs/trees by also doing something like what I
> described as "diff package", don't you?

Yes... yes you could have files and diffs generated statically...

although something like a bittorrent server/client/frontend, call it 
"gittorrent" (I hate being the first to make this pun) could walk the 
hashes dynamically (
Ihave: sha,sha,sha,sha... Sendme: shaxxxxxxxxxxxxxxxxxxx
Hereswhatyouneedfromgit: file,file,file,diff,diff,diff,...)

-- 

Mike Taht


   "It looks like blind screaming hedonism won out."
