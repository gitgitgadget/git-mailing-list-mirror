From: Ingo Molnar <mingo@elte.hu>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 14:41:05 +0200
Message-ID: <20081012124105.GA26988@elte.hu>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 14:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp0Hi-0000lx-08
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 14:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbYJLMl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYJLMl3
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 08:41:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35334 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbYJLMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 08:41:28 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1Kp0G2-0003cY-JV
	from <mingo@elte.hu>; Sun, 12 Oct 2008 14:41:17 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A7A4D3E21A3; Sun, 12 Oct 2008 14:41:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48EF7BC1.4000401@zytor.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.5 required=5.9 tests=BAYES_20,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-0.5 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1571]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98016>


* H. Peter Anvin <hpa@zytor.com> wrote:

> Wang Chen wrote:
>>>
>>> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
>>> 1.5.3.x)
>>
>> My git version is 1.5.5.1, although it doesn't matter ;)
>>
>
> http transport requires that "git update-server-info" is done after 
> each push.  Otherwise, it ends up in a trainwreck.

can i simply put "git update-server-info" into .git/hooks/post-receive 
to solve this problem?

	Ingo
