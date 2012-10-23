From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 22:47:28 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210232232070.2756@ionos>
References: <20121016223508.GR2616@ZenIV.linux.org.uk> <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com> <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com> <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 23 22:48:13 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TQlOW-0001qL-F0
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Oct 2012 22:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315Ab2JWUr4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Oct 2012 16:47:56 -0400
Received: from www.linutronix.de ([62.245.132.108]:46942 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965259Ab2JWUrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Oct 2012 16:47:41 -0400
Received: from localhost ([127.0.0.1])
	by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <tglx@linutronix.de>)
	id 1TQlNp-0007VP-HK; Tue, 23 Oct 2012 22:47:29 +0200
In-Reply-To: <20121023184122.GZ2616@ZenIV.linux.org.uk>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208247>

On Tue, 23 Oct 2012, Al Viro wrote:
> On Tue, Oct 23, 2012 at 01:30:26PM -0400, Chris Metcalf wrote:
> 
> > I fetched the series from your arch-tile branch and built it, and it works
> > fine.  It looks good from my inspection:
> > 
> > Acked-by: Chris Metcalf <cmetcalf@tilera.com>
> 
> Thanks; Acked-by applied, branch pushed and put into no-rebase mode.
> 
> BTW, something like detached Acked-by objects might be a good idea - i.e.
> commit-like git object with amendment to commit message of a given ancestor.
> The situation when ACKs come only after the commit has been pushed is quite
> common.  Linus, what do you think about usefulness of such thing?  Ability
> to append ACKed-by/Tested-by of an earlier commit to a branch instead of
> git commit --amend + possibly some cherry-picks + force-push, that is.

I agree that this is a common issue. Acked-by/Reviewed-by mails come
in after the fact that the patch has been committed to an immutable
(i.e no-rebase mode) branch or if the change in question already hit
Linus tree.

Still it would be nice to have a recording of that in the git tree
itself.

Something like: "git --attach SHA1 <comment>" would be appreciated!

Thanks,

	tglx
