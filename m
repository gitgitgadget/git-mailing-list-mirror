From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 16:53:14 -0400
Message-ID: <20080827205314.GA3198@sigill.intra.peff.net>
References: <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Willy Tarreau <w@1wt.eu>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYS22-0000TL-LU
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbYH0UxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYH0UxR
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:53:17 -0400
Received: from peff.net ([208.65.91.99]:4032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbYH0UxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:53:17 -0400
Received: (qmail 16512 invoked by uid 111); 27 Aug 2008 20:53:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 27 Aug 2008 16:53:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 16:53:14 -0400
Content-Disposition: inline
In-Reply-To: <48B5BB35.8090606@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93949>

On Wed, Aug 27, 2008 at 04:38:13PM -0400, Jeff Garzik wrote:

> I use it to spit out a patch for a specific commit:
>
> 	git-diff-tree -p $COMMIT
>
> Though probably someone will now come along and tell me I'm am old-timer, 
> and there is a shorter command that accomplishes the same thing :)

Actually, that is something that diff-tree does better (a single
tree-ish with git-diff is "compare against working tree"). To do it with
git-diff you would have to use the obscure (and not very shell-friendly)
syntax:

  git diff $COMMIT^!

Although interactively, I tend to use "git show" for this purpose,
though perhaps you intentionally don't want to see the commit message.

Anyway, thank you for satisfying my curiosity.

-Peff
