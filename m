From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Tue, 4 Oct 2011 06:16:10 -0400
Message-ID: <20111004101610.GA11236@sigill.intra.peff.net>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
 <20110930221111.GB9384@sigill.intra.peff.net>
 <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
 <20111003105908.GF16078@sigill.intra.peff.net>
 <CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB231-0007Gi-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab1JDKQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 06:16:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52063
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690Ab1JDKQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 06:16:19 -0400
Received: (qmail 6522 invoked by uid 107); 4 Oct 2011 10:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 06:21:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 06:16:10 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182751>

On Mon, Oct 03, 2011 at 09:13:12AM -0400, Jay Soffian wrote:

> > Yeah. I was thinking the ACL prompt would come up more often, but I
> > guess most people would hit "allow always", since it would get annoying
> > pretty quickly otherwise (I didn't, because I was testing).
> 
> In the normal case, the keychain entry would be added via the
> credential helper, so they'd never even see the prompt since the
> binary which adds an entry is automatically on that entry's ACL.

Ah, that makes sense. That wasn't what happened for me; the first time I
ran it, before I had ever given it a password, it asked if it could
access the login keychain. But that was because I _already_ had an entry
there from the GitHub for Mac client.

So I assume it was typical that most users would see it at least that
first time. But it's probably not.

> > Side note: do you know how to edit those ACLs? I couldn't find it in the
> > keychain manager. It would be helpful for testing to be able to tweak it
> > (as a workaround, I just modified the binary, which apparently the
> > keychain code cares about).
> 
> Double-click on the entry in Keychain Access, then click the "Access
> Control" tab.

Thanks. For some reason I was thinking the ACL was based on the
keychain, but of course having it per-entry makes much more sense. So I
was just looking in the wrong place.

-Peff
