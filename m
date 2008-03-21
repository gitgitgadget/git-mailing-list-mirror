From: Jeff King <peff@peff.net>
Subject: Re: Switching branches without committing changes
Date: Fri, 21 Mar 2008 00:10:13 -0400
Message-ID: <20080321041013.GA2502@coredump.intra.peff.net>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org> <20080321040647.GE8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:11:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcYao-0001ih-QV
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbYCUEKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbYCUEKR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:10:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4736 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbYCUEKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:10:16 -0400
Received: (qmail 22229 invoked by uid 111); 21 Mar 2008 04:10:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Mar 2008 00:10:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2008 00:10:13 -0400
Content-Disposition: inline
In-Reply-To: <20080321040647.GE8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77703>

On Fri, Mar 21, 2008 at 12:06:47AM -0400, Shawn O. Pearce wrote:

> Use `git checkout -m` to switch the branch anyway.  However, if
> there is a merge conflict while you are trying to carry the changes
> to the other branch you may be faced with a merge conflict you are
> not prepared to resolve, or simply cannot resolve in a reasonable
> period of time.

Ah, for some reason I didn't think of '-m' in the advice I gave (I guess
I have just never used it). It is almost certainly simpler than using a
'stash' at this point (but I do think stashing _beforehand_ still has
advantages).

-Peff
