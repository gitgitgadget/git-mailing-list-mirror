From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Mon, 13 Oct 2008 08:59:47 -0700
Message-ID: <48F37073.1030808@zytor.com>
References: <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz> <20081012165954.GA2317@elte.hu> <48F3178A.50106@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Petr Baudis <pasky@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Wang Chen <wangchen@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpPs7-0000oE-Sx
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 18:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbYJMQBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 12:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbYJMQBA
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 12:01:00 -0400
Received: from terminus.zytor.com ([198.137.202.10]:42905 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842AbYJMQA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 12:00:59 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9DFxoJ8025533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Oct 2008 08:59:50 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9DFxnH9011382;
	Mon, 13 Oct 2008 08:59:49 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9DFxliK029887;
	Mon, 13 Oct 2008 08:59:48 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48F3178A.50106@cn.fujitsu.com>
X-Virus-Scanned: ClamAV 0.93.3/8417/Mon Oct 13 00:34:29 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98118>

Wang Chen wrote:
> 
> Ingo, thank you for your work.
> I can clone more, but error still occurs:
> 
> Getting alternates list for http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
> Also look at http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> Also look at http://www.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git/
> Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
> error: transfer closed with 8280 bytes remaining to read
> Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git/
> error: Unable to find 95630fe2917f805a26f8d8beaafb80cd2f729eb5 under http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
> Cannot obtain needed object 95630fe2917f805a26f8d8beaafb80cd2f729eb5

I cleaned it up and it should work now.

	-hpa
