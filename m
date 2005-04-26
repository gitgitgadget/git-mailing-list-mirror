From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 11:15:06 -0700
Message-ID: <426E852A.40904@zytor.com>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <426DA7B5.2080204@timesys.com> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org> <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:11:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUWL-0006H2-8Q
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDZSPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZSPs
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:15:48 -0400
Received: from terminus.zytor.com ([209.128.68.124]:26498 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261539AbVDZSPi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 14:15:38 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3QIFC3Z003406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Apr 2005 11:15:13 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> And don't try to make me explain why the patchbomb has any IO time at all,
> it should all have fit in the cache, but I think the writeback logic
> kicked in.

The default log size on ext3 is quite small.  Making the log larger 
probably would have helped.

	-hpa
