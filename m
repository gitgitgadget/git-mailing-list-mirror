From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: git-show vs git-log (or: git show vs git log)
Date: Thu, 28 Aug 2008 09:46:34 +0200
Message-ID: <20080828074634.GA2862@isilmar.linta.de>
References: <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com> <alpine.LFD.1.10.0808271420210.3363@nehalem.linux-foundation.org> <48B5E822.1020901@pobox.com> <20080828065124.GB16186@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Kristian H??gsberg <krh@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Andi Kleen <andi@firstfloor.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Aug 28 09:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYcEP-0001ky-Vx
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 09:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbYH1Hqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 03:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYH1Hqh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 03:46:37 -0400
Received: from isilmar.linta.de ([213.133.102.198]:49684 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753055AbYH1Hqh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 03:46:37 -0400
Received: (qmail 3158 invoked by uid 1000); 28 Aug 2008 07:46:34 -0000
Content-Disposition: inline
In-Reply-To: <20080828065124.GB16186@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 08:51:24AM +0200, Ingo Molnar wrote:
> > 'git show' is quite sufficient, as long as I can pipe its output into 
> > patch(1) or write it to a foo.patch file, which appears to be the 
> > case.
> 
> the only time git show is not sufficient for me in practice, the 
> following one is:
> 
>   git log --pretty=email -p -1
> 
> that's when i want to do precise import/export of patches from/to email. 
> (but it's rare)

git show --pretty=email

Best,
	Dominik
