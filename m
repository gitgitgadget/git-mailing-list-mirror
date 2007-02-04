From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sat, 3 Feb 2007 21:38:18 -0500
Message-ID: <20070204023818.GA27644@coredump.intra.peff.net>
References: <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com> <b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com> <20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net> <7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net> <20070204014945.GA18357@coredump.intra.peff.net> <7vzm7uy8ng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 03:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDXGr-0002hV-IG
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 03:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbXBDCiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 21:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbXBDCiV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 21:38:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2042 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751953AbXBDCiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 21:38:20 -0500
Received: (qmail 25339 invoked from network); 3 Feb 2007 21:38:19 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Feb 2007 21:38:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Feb 2007 21:38:18 -0500
Content-Disposition: inline
In-Reply-To: <7vzm7uy8ng.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38637>

On Sat, Feb 03, 2007 at 06:10:59PM -0800, Junio C Hamano wrote:

> I do not think it is wrong to have a separate mechanism (and it
> might end up being called as "mergelocal" which you said might
> be a terrible name) for that.  I just think it is probably a
> wrong thing to do to use branch.*.merge for that. As you said,
> operations you are interested in like format-patch (and perhaps
> rebase) of a local branch relative to another locally available
> ref (be it another branch or a tracking branch) do not involve
> fetching (hence pulling) necessarily.

Good, it looks like we are mostly agreeing on this then (the feature
might have some use, but it should _not_ be tacked onto branch.*.merge).
I will give it some thought until v1.5.0 has settled, and then hopefully
submit some patches.

-Peff
