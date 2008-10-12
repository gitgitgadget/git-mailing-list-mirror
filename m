From: Ingo Molnar <mingo@elte.hu>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 17:24:27 +0200
Message-ID: <20081012152427.GA4607@elte.hu>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2pa-0008Qe-80
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYJLPYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 11:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbYJLPYx
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:24:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53230 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbYJLPYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:24:53 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1Kp2o6-0000pl-Ex
	from <mingo@elte.hu>; Sun, 12 Oct 2008 17:24:34 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 1E4203E21A3; Sun, 12 Oct 2008 17:24:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F20663.2040407@zytor.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98032>


* H. Peter Anvin <hpa@zytor.com> wrote:

> Ingo Molnar wrote:
>> * H. Peter Anvin <hpa@zytor.com> wrote:
>>
>>> Wang Chen wrote:
>>>>> So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
>>>>> 1.5.3.x)
>>>> My git version is 1.5.5.1, although it doesn't matter ;)
>>>>
>>> http transport requires that "git update-server-info" is done after  
>>> each push.  Otherwise, it ends up in a trainwreck.
>>
>> can i simply put "git update-server-info" into .git/hooks/post-receive  
>> to solve this problem?
>>
>
> post-update, rather than post-receive.
>
> The standard post-update.sample contains it, it just needs a rename.

hm, -tip's .git/hooks/post-update already contained this, for the last 2 
months:

  exec git update-server-info

so ... _despite_ us having this in the git repo, the HTTP protocol still 
does not work. Why?

	Ingo
