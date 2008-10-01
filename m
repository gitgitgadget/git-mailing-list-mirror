From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 1 Oct 2008 11:42:05 -0400
Message-ID: <20081001154205.GD4962@coredump.intra.peff.net>
References: <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net> <48E3312E.4090601@op5.se> <20081001151011.GA21310@spearce.org> <20081001152546.GB4962@coredump.intra.peff.net> <20081001153637.GC21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:43:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3rN-00081J-6T
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYJAPmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYJAPmK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:42:10 -0400
Received: from peff.net ([208.65.91.99]:4973 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbYJAPmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:42:08 -0400
Received: (qmail 19526 invoked by uid 111); 1 Oct 2008 15:42:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 11:42:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 11:42:05 -0400
Content-Disposition: inline
In-Reply-To: <20081001153637.GC21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97240>

On Wed, Oct 01, 2008 at 08:36:37AM -0700, Shawn O. Pearce wrote:

> I briefly considered a format like this while replying above, but
> at prior day-job I used rather long branch names (sometimes with
> common prefixes) so it would truncate alot:
> 
>   normal case
>   On i386           abc9056 (i386: Snib the sprock)

I don't like this purely for the reason that it wastes horizontal space,
which is one of the problems that started this discussion.

Also, there is no verb, which I think is worse. :)

> *sigh*  And I just took up the #@*#@!&!*!@ paintbrush myself.
> Dammit.  I'm putting it down now.  Really.  :-)

Heh. I don't want to stir up trouble or drag you into a discussion you
don't want to be in. But it seems like you are saying "OK, this is
silly, let's just go with what is in next." But I think Andreas raised a
good point about "stuff the user should check should go on the left"
which is not consistent with what is in next. So I just want to confirm
that you either disagree with that, or simply think it is not important
enough to keep the discussion going.

-Peff
