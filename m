From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 08:51:24 +0200
Message-ID: <20080828065124.GB16186@elte.hu>
References: <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com> <alpine.LFD.1.10.0808271420210.3363@nehalem.linux-foundation.org> <48B5E822.1020901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Andi Kleen <andi@firstfloor.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 08:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYbOb-0005FB-Cs
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 08:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYH1GxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 02:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYH1GxN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 02:53:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60921 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbYH1GxM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 02:53:12 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KYbMN-0001Ir-UZ
	from <mingo@elte.hu>; Thu, 28 Aug 2008 08:52:06 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 811603E219B; Thu, 28 Aug 2008 08:51:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48B5E822.1020901@pobox.com>
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


* Jeff Garzik <jgarzik@pobox.com> wrote:

> > Yeah, the "much nicer" obviously does mean "different". If you 
> > _rely_ on the fact that you don't get a pager (you just want to 
> > scroll youself), or you really don't want to see what the commit 
> > message was all about, then 'git diff-tree' is obviously "better".
> 
> 'git show' is quite sufficient, as long as I can pipe its output into 
> patch(1) or write it to a foo.patch file, which appears to be the 
> case.

the only time git show is not sufficient for me in practice, the 
following one is:

  git log --pretty=email -p -1

that's when i want to do precise import/export of patches from/to email. 
(but it's rare)

	Ingo
