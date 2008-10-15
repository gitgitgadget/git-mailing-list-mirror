From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Tue, 14 Oct 2008 22:25:43 -0700
Message-ID: <48F57ED7.1090305@zytor.com>
References: <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz> <20081012165954.GA2317@elte.hu> <48F3178A.50106@cn.fujitsu.com> <48F37073.1030808@zytor.com> <48F566C4.2050905@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Petr Baudis <pasky@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Wang Chen <wangchen@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 07:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpyvO-00080f-R4
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 07:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYJOF0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 01:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYJOF0q
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 01:26:46 -0400
Received: from terminus.zytor.com ([198.137.202.10]:54937 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbYJOF0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 01:26:46 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9F5PpVt032719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Oct 2008 22:25:52 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9F5Pnfb025455;
	Tue, 14 Oct 2008 22:25:49 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9F5PhBa020470;
	Tue, 14 Oct 2008 22:25:43 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48F566C4.2050905@cn.fujitsu.com>
X-Virus-Scanned: ClamAV 0.93.3/8426/Tue Oct 14 17:11:44 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98232>

Wang Chen wrote:
> 
> Yes. My clone is successful. Thanks, Peter.
> But, after cloning, git-pull failed because of conflict.
> I think maybe because Ingo rebased his tree?
> ---
> Auto-merged init/main.c
> CONFLICT (content): Merge conflict in init/main.c
> Auto-merged scripts/bootgraph.pl
> CONFLICT (add/add): Merge conflict in scripts/bootgraph.pl
> Removed sound/soc/at91/eti_b1_wm8731.c
> Automatic merge failed; fix conflicts and then commit the result.
> ---

Yes, the master branch on tip is not rebase-free.

	-hpa
