From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org rsync processes
Date: Wed, 21 Sep 2005 08:48:08 -0700
Message-ID: <433180B8.5000400@zytor.com>
References: <4331537F.8060402@gmail.com> <Pine.LNX.4.58.0509210808080.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: A Large Angry SCM <gitzilla@gmail.com>, webmaster@kernel.org,
	git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 17:49:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI6pe-0005Sy-5Z
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 17:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVIUPsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 11:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVIUPsX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 11:48:23 -0400
Received: from terminus.zytor.com ([209.128.68.124]:39335 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751102AbVIUPsW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 11:48:22 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8LFmAJS027189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Sep 2005 08:48:13 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509210808080.2553@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9051>

Linus Torvalds wrote:
> 
> On Wed, 21 Sep 2005, A Large Angry SCM wrote:
> 
>>Did the kernel.org rsync processes get stuck again?
> 
> 
> It may still see the effect of a disk failure.. According to hpa as of 
> Monday evening:
> 
> 
>>zeus2.kernel.org is coming back online after a severe disk failure.
>>It's pretty out of date (in particular, it's missed the daily --checksum
>>syncs), and I think it's still rebuilding its RAID, so it's running slow.
> 
> 
> So it looks like kernel.org just had a few difficult days (fist the move
> of master, then some problems at the outer fringes).
> 

Yep.  I'm actually a bit puzzled over just how long it seems to be 
taking to rebuild the RAID on zeus2, and the level of slowdown it seems 
to carry with it, especially not since we have turned off user traffic 
to that host completely.

	-hpa
