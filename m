From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Fri, 10 Oct 2008 08:58:57 -0700
Message-ID: <48EF7BC1.4000401@zytor.com>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Wang Chen <wangchen@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 18:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoKgE-0001Ml-4I
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 18:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409AbYJJQQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 12:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758428AbYJJQQS
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 12:16:18 -0400
Received: from terminus.zytor.com ([198.137.202.10]:37817 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934AbYJJQQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 12:16:18 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9AFx1jR028761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Oct 2008 08:59:01 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9AFx15Y015812;
	Fri, 10 Oct 2008 08:59:01 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9AFwvFJ016586;
	Fri, 10 Oct 2008 08:58:57 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48EF1902.4070309@cn.fujitsu.com>
X-Virus-Scanned: ClamAV 0.93.3/8407/Fri Oct 10 08:10:59 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97946>

Wang Chen wrote:
>>
>> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
>> 1.5.3.x)
> 
> My git version is 1.5.5.1, although it doesn't matter ;)
> 

http transport requires that "git update-server-info" is done after each 
push.  Otherwise, it ends up in a trainwreck.

Shawn Pierce at Google is working on a long-term solution, but in the 
meantime, if you have to use http transport, murder your IT people.

	-hpa
