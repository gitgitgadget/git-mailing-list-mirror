From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 21:09:19 -0700
Message-ID: <48F2C9EF.4020203@zytor.com>
References: <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz> <20081012165954.GA2317@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Oct 13 06:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpElq-0000x1-Tw
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 06:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYJMEJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 00:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYJMEJv
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 00:09:51 -0400
Received: from terminus.zytor.com ([198.137.202.10]:45280 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYJMEJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 00:09:51 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9D49Kdi013964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Oct 2008 21:09:20 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9D49J6V006516;
	Sun, 12 Oct 2008 21:09:19 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9D49J88023869;
	Sun, 12 Oct 2008 21:09:19 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20081012165954.GA2317@elte.hu>
X-Virus-Scanned: ClamAV 0.93.3/8416/Sun Oct 12 20:12:39 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98079>

Ingo Molnar wrote:
> 
> Soapbox: in fact it would be outright stupid to limit the kernel 
> source's availability artificially by not making HTTP a tier-one access 
> method.
> 
> Fighting against HTTP-only firewalls is like constantly pointing it out 
> to the popular press that they should say 'cracker' instead of 'hacker'. 
> It is pointless and only hurts the availability our own project.
> 	

Yes, and Shawn Pierce is working on making HTTP a proper "smart" access 
method, based on a proposal I submitted.  That is the proper solution, 
since it avoids all the braindamage of "dumb" access methods.  We 
[kernel.org] intend to deploy it as soon as it is available.

	-hpa
