From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] send-pack: assign remote errors to each ref
Date: Wed, 14 Nov 2007 02:01:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711140159550.4362@racer.site>
References: <20071113102500.GA2767@sigill.intra.peff.net>
 <20071113113710.GC15880@sigill.intra.peff.net> <7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 03:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is7ah-0000LG-Mh
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 03:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbXKNCBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 21:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756361AbXKNCBf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 21:01:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41446 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754704AbXKNCBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 21:01:34 -0500
Received: (qmail invoked by alias); 14 Nov 2007 02:01:32 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 14 Nov 2007 03:01:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wVApUC7gwVHoBXV1P2pJGt+0s8UCWm0OUt1W3pa
	kQiYTDvc03KS9s
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64945>

Hi,

On Tue, 13 Nov 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. the status parsing is not foolproof. We get a line like
> >
> >          ng refs/heads/master arbitrary msg
> >
> >      which cannot be parsed unambiguously in the face of
> >      refnames with spaces.

Since when can refnames contain spaces?  In my copy of git, bad_ref_char() 
in refs.c returns 1 if ch <= ' '.  It's the first error path, even.

Ciao,
Dscho
