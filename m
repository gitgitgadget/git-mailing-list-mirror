From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 18:36:48 +0300
Message-ID: <877i8dx1tb.fsf@iki.fi>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu>
	<20081010083720.GA32069@elte.hu>
	<alpine.LFD.2.00.0810101040200.3271@apollo>
	<48EF14FC.1000801@cn.fujitsu.com>
	<alpine.LFD.2.00.0810101046260.3271@apollo>
	<48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com>
	<20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com>
	<20081012152427.GA4607@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp324-00045Q-UW
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbYJLPhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbYJLPhq
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:37:46 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:48586 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbYJLPhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:37:46 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48DA2F8900F19A76; Sun, 12 Oct 2008 18:36:55 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Kp2zw-0000th-CF; Sun, 12 Oct 2008 18:36:48 +0300
In-Reply-To: <20081012152427.GA4607@elte.hu> (Ingo Molnar's message of "Sun\, 12 Oct 2008 17\:24\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98033>

Ingo Molnar <mingo@elte.hu> writes:

> * H. Peter Anvin <hpa@zytor.com> wrote:
>> post-update, rather than post-receive.
>>
>> The standard post-update.sample contains it, it just needs a rename.
>
> hm, -tip's .git/hooks/post-update already contained this, for the last 2 
> months:
>
>   exec git update-server-info
>
> so ... _despite_ us having this in the git repo, the HTTP protocol
> still does not work. Why?

I don't know why but I have experienced the same: post-update hook just
doesn't work. I described it here:

    http://thread.gmane.org/gmane.comp.version-control.git/82351

Fortunately post-receive hooks works, so you could to try it instead.
