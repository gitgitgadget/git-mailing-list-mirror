From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 07:15:52 -0700
Message-ID: <48F20698.4090105@zytor.com>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <48F1DF6A.4000900@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Wang Chen <wangchen@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 16:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1lV-0004d8-Ef
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 16:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbYJLOQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 10:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbYJLOQi
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 10:16:38 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40882 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYJLOQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 10:16:37 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9CEFrQu007080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Oct 2008 07:15:53 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9CEFrUN001707;
	Sun, 12 Oct 2008 07:15:53 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9CEFqh7017995;
	Sun, 12 Oct 2008 07:15:52 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48F1DF6A.4000900@cn.fujitsu.com>
X-Virus-Scanned: ClamAV 0.93.3/8414/Sat Oct 11 20:30:50 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98023>

Wang Chen wrote:
> 
> So, the current solutions are:
> 1. Waiting for Shawn fixing it.
> 2. Asking Ingo to "git update-server-info" after each push.
> 3. Murdering our IT people.
> 
> I'd rather to do the second solution than the third one :)
> 

Actually, the third solution is the proper one given the circumstances 
you find yourself in.  None of this would be a problem if there wasn't a 
bunch of companies with incompetent network management.

	-hpa
