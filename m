From: Wang Chen <wangchen@cn.fujitsu.com>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 19:28:42 +0800
Message-ID: <48F1DF6A.4000900@cn.fujitsu.com>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 13:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KozCP-0005WS-Ox
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 13:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYJLLcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 07:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbYJLLcL
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 07:32:11 -0400
Received: from cn.fujitsu.com ([222.73.24.84]:56726 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbYJLLcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 07:32:11 -0400
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 773D9170028;
	Sun, 12 Oct 2008 19:31:51 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id m9CBVh9t023523;
	Sun, 12 Oct 2008 19:31:43 +0800
Received: from [10.167.141.111] (unknown [10.167.141.111])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 9B619D4283;
	Sun, 12 Oct 2008 19:36:24 +0800 (CST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48EF7BC1.4000401@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98013>

H. Peter Anvin said the following on 2008-10-10 23:58:
> Wang Chen wrote:
>>>
>>> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
>>> 1.5.3.x)
>>
>> My git version is 1.5.5.1, although it doesn't matter ;)
>>
> 
> http transport requires that "git update-server-info" is done after each
> push.  Otherwise, it ends up in a trainwreck.
> 
> Shawn Pierce at Google is working on a long-term solution, but in the
> meantime, if you have to use http transport, murder your IT people.
> 


So, the current solutions are:
1. Waiting for Shawn fixing it.
2. Asking Ingo to "git update-server-info" after each push.
3. Murdering our IT people.

I'd rather to do the second solution than the third one :)

Ingo, will you do "git update-server-info" after each push before
Shawn fix this problem?
