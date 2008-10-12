From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 07:14:59 -0700
Message-ID: <48F20663.2040407@zytor.com>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Oct 12 16:16:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1kW-0004LF-Q3
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 16:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbYJLOPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 10:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYJLOPg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 10:15:36 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40875 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbYJLOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 10:15:36 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9CEF39n007002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Oct 2008 07:15:03 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9CEF22a001702;
	Sun, 12 Oct 2008 07:15:02 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9CEExn3017988;
	Sun, 12 Oct 2008 07:15:00 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20081012124105.GA26988@elte.hu>
X-Virus-Scanned: ClamAV 0.93.3/8414/Sat Oct 11 20:30:50 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98022>

Ingo Molnar wrote:
> * H. Peter Anvin <hpa@zytor.com> wrote:
> 
>> Wang Chen wrote:
>>>> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
>>>> 1.5.3.x)
>>> My git version is 1.5.5.1, although it doesn't matter ;)
>>>
>> http transport requires that "git update-server-info" is done after 
>> each push.  Otherwise, it ends up in a trainwreck.
> 
> can i simply put "git update-server-info" into .git/hooks/post-receive 
> to solve this problem?
> 

post-update, rather than post-receive.

The standard post-update.sample contains it, it just needs a rename.

	-hpa
