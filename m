From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 18:06:28 -0700
Message-ID: <425F1394.5020709@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org> <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com> <20050414214756.GA31249@outpost.ds9a.nl> <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bert hubert <ahu@ds9a.nl>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 03:04:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMFFb-0007tJ-Mw
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 03:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDOBG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 21:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDOBG6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 21:06:58 -0400
Received: from terminus.zytor.com ([209.128.68.124]:30619 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261692AbVDOBGr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 21:06:47 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3F16X3n016208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 18:06:33 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> Even something as simple as "ls -l" has been known to have O(n**2)  
> behaviour for big directories.
> 

For filesystems with linear directories, sure.  For sane filesystems, it 
should have O(n log n).

	-hpa
