From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Yet another base64 patch
Date: Sun, 17 Apr 2005 13:51:52 -0400
Message-ID: <4262A238.3050207@dwheeler.com>
References: <425DEF64.60108@zytor.com>	<20050414022413.GB18655@64m.dyndns.org>	<425E0174.4080404@zytor.com>	<20050414024228.GC18655@64m.dyndns.org>	<425E0D62.9000401@zytor.com>	<Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>	<425EA152.4090506@zytor.com>	<Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>	<20050414191157.GA27696@outpost.ds9a.nl>	<425EC3B4.6090908@zytor.com>	<20050414214756.GA31249@outpost.ds9a.nl>	<Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>	<425F13C9.5090109@zytor.com>	<20050414205831.01039ee8.pj@engr.sgi.com>	<4261DDBC.3050706@dwheeler.com>	<20050416210513.1ba26967.pj@sgi.com>	<42620452.4080809@dwheeler.com> <20050417011615.3e7dfb29.pj@sgi.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 19:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNDqp-0000c7-OR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 19:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVDQRuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 13:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDQRuN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 13:50:13 -0400
Received: from cujo.runbox.com ([193.71.199.138]:4794 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261376AbVDQRt6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 13:49:58 -0400
Received: from [10.9.9.16] (helo=lassie.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNDu8-0000w2-Ba; Sun, 17 Apr 2005 19:49:56 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by lassie.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNDu7-0001pp-NO; Sun, 17 Apr 2005 19:49:56 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050417011615.3e7dfb29.pj@sgi.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson wrote:
> David wrote:
> 
>>My list would be:
>>ext2, ext3, NFS, and Windows' NTFS (stupid short filenames,
>>case-insensitive/case-preserving).
> 
> 
> I'm no mind reader, but I'd bet a pretty penny that what you have in
> mind and what Linus has in mind have no overlaps in their solution sets.

Sadly, I lack the mind reading ability as well.

Our goals are, I suspect, somewhat different.
Linus wants to build a tool that meets his specific needs
(managing kernel development), and he has particular requirements
(such as fast simple merging when working at large scales).
In contrast, I'm hoping for a more
general OSS/FS SCM tool that many others can use as well.

But I think there's heavy overlap in the solution space.
The Linux kernel project is, to my knowledge, the largest
project using a truly distributed SCM process.
Anyone else who is considering a distributed SCM process
would at _least_ want to think about how the Linux kernel
project works, and if they're doing so, they
might also want to reuse the development tools.

I'm just taking a peek, and
looking for situations where a design decision is irrelevant
for his purposes, but a particular direction would be of
particular help to other projects.  I'm more worried about the
storage format; if the code doesn't support some particular
feature but it could be added later without great pain, no big deal.
If something would imply a complete rewrite, that's undesirable.

--- David A. Wheeler
