From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 23 Jun 2008 17:22:48 +0200
Message-ID: <20080623152248.GB28394@elte.hu>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080623094906.GA8284@elte.hu> <20080623151201.GB20902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Chris Mason <chris.mason@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAnuT-0005Wa-9u
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbYFWPXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756021AbYFWPXp
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:23:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:43967 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755543AbYFWPXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:23:44 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KAnsZ-0004gI-E2
	from <mingo@elte.hu>; Mon, 23 Jun 2008 17:23:00 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5DB4F3E21DD; Mon, 23 Jun 2008 17:22:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623151201.GB20902@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85872>


* Jeff King <peff@peff.net> wrote:

> > ( and if i could configure git-commit to outright reject a commit like 
> >   that - i never want to commit lines with <<<<<< or >>>>> markers)
> 
> The right place for this is in a pre-commit hook, which can look at 
> what you are about to commit and decide if it is OK. In fact, the 
> default pre-commit hook that ships with git performs this exact check. 
> You just need to turn it on with:
> 
>   chmod +x .git/hooks/pre-commit

cool, thanks :-)

	Ingo
