From: Wang Chen <wangchen@cn.fujitsu.com>
Subject: Re: tip tree clone fail
Date: Wed, 15 Oct 2008 11:43:00 +0800
Message-ID: <48F566C4.2050905@cn.fujitsu.com>
References: <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz> <20081012165954.GA2317@elte.hu> <48F3178A.50106@cn.fujitsu.com> <48F37073.1030808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Petr Baudis <pasky@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 05:48:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpxMz-0006JW-UM
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 05:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYJODqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 23:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbYJODqJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 23:46:09 -0400
Received: from cn.fujitsu.com ([222.73.24.84]:57446 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbYJODqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 23:46:08 -0400
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id C1CF8170138;
	Wed, 15 Oct 2008 11:46:02 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id m9F3jxW5011756;
	Wed, 15 Oct 2008 11:45:59 +0800
Received: from [10.167.141.111] (unknown [10.167.141.111])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 651B6D429E;
	Wed, 15 Oct 2008 11:51:01 +0800 (CST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48F37073.1030808@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98230>

H. Peter Anvin said the following on 2008-10-13 23:59:
> Wang Chen wrote:
>>
>> Ingo, thank you for your work.
>> I can clone more, but error still occurs:
>>
>> Getting alternates list for
>> http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
>> Also look at
>> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>> Also look at
>> http://www.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git/
>> Getting pack list for
>> http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
>> error: transfer closed with 8280 bytes remaining to read
>> Getting pack list for
>> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>> Getting pack list for
>> http://www.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git/
>> error: Unable to find 95630fe2917f805a26f8d8beaafb80cd2f729eb5 under
>> http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
>> Cannot obtain needed object 95630fe2917f805a26f8d8beaafb80cd2f729eb5
> 
> I cleaned it up and it should work now.
> 

Yes. My clone is successful. Thanks, Peter.
But, after cloning, git-pull failed because of conflict.
I think maybe because Ingo rebased his tree?
---
Auto-merged init/main.c
CONFLICT (content): Merge conflict in init/main.c
Auto-merged scripts/bootgraph.pl
CONFLICT (add/add): Merge conflict in scripts/bootgraph.pl
Removed sound/soc/at91/eti_b1_wm8731.c
Automatic merge failed; fix conflicts and then commit the result.
---
