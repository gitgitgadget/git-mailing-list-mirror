From: Jeff King <peff@peff.net>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 08:11:54 -0400
Message-ID: <20070519121154.GA10268@coredump.intra.peff.net>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net> <20070519115245.GA10035@coredump.intra.peff.net> <20070519120933.GW17511@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sat May 19 14:12:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNn0-0007kE-A9
	for gcvg-git@gmane.org; Sat, 19 May 2007 14:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbXESML5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 08:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758133AbXESML5
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 08:11:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4366 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757388AbXESML5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 08:11:57 -0400
Received: (qmail 23416 invoked from network); 19 May 2007 12:11:58 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 19 May 2007 12:11:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 19 May 2007 08:11:54 -0400
Content-Disposition: inline
In-Reply-To: <20070519120933.GW17511@curie-int.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47744>

On Sat, May 19, 2007 at 05:09:33AM -0700, Robin H. Johnson wrote:

> Ahh, they do show up there (and I learnt a new git command now, thanks)
> - the ones that I can remember the Subject lines for anyway.
> 
> Any hints for the future on finding stuff that is in the reflog but not
> in the tree? (Remembering every subject line isn't feasible).

Try 'git-fsck --unreachable --no-reflogs'. :)

-Peff
