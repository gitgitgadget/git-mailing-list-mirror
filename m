From: Wang Chen <wangchen@cn.fujitsu.com>
Subject: Re: tip tree clone fail
Date: Fri, 10 Oct 2008 16:57:38 +0800
Message-ID: <48EF1902.4070309@cn.fujitsu.com>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 10 11:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoDtP-0000pr-AM
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 11:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYJJJBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 05:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbYJJJBD
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 05:01:03 -0400
Received: from cn.fujitsu.com ([222.73.24.84]:59945 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756436AbYJJJBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 05:01:00 -0400
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 44F50170117;
	Fri, 10 Oct 2008 17:00:57 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id m9A90uaF018665;
	Fri, 10 Oct 2008 17:00:56 +0800
Received: from [10.167.141.111] (unknown [10.167.141.111])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 79F0CD4298;
	Fri, 10 Oct 2008 17:05:04 +0800 (CST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <alpine.LFD.2.00.0810101046260.3271@apollo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97918>

Thomas Gleixner said the following on 2008-10-10 16:56:
> On Fri, 10 Oct 2008, Wang Chen wrote:
>> Thomas Gleixner said the following on 2008-10-10 16:40:
>>> On Fri, 10 Oct 2008, Ingo Molnar wrote:
>>>
>>>> Cc:-ed Thomas too - Thomas just ran a clean git clone and that succeeded 
>>>> for him, both over the http and over the git protocols.
>>> No, I did ssh and git. Will start a http one now.
>> OK. I will wait.
>> Thanks, Thomas :)
> 
> git clone http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git 
> 
> fails here as well. 
> 
> Getting pack 7c461fa5d92f9e047ae07b70eb30828a63a803f5
>  which contains 874e848aefc2d5952b00593c9fd23d748259eec7
> walk 874e848aefc2d5952b00593c9fd23d748259eec7
> Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/sfr/linux-next.git/
> error: Unable to find 85ba94ba0592296053f7f2846812173424afe1cb under http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
> Cannot obtain needed object 85ba94ba0592296053f7f2846812173424afe1cb
> while processing commit 874e848aefc2d5952b00593c9fd23d748259eec7.
> fatal: Fetch failed.
> 
> The needed object 85ba94ba0592296053f7f2846812173424afe1cb is a commit
> in linus tree.
> 
> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
> 1.5.3.x)
> 

My git version is 1.5.5.1, although it doesn't matter ;)

> Junio, can you please have a look ? I know it's http again, but we can
> not sanitze the corporate firewall folks by any means.
> 
