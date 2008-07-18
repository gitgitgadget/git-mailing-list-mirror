From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Link git-shell only to a subset of libgit.a
Date: Fri, 18 Jul 2008 01:06:16 +0000
Message-ID: <20080718010616.GB4155@spearce.org>
References: <20080718005814.GA4155@spearce.org> <1216343070-20237-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJeRH-0006GT-OO
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbYGRBGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbYGRBGR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:06:17 -0400
Received: from george.spearce.org ([209.20.77.23]:46916 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843AbYGRBGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:06:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1EFBA382A4; Fri, 18 Jul 2008 01:06:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1216343070-20237-1-git-send-email-s-beyer@gmx.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88944>

Stephan Beyer <s-beyer@gmx.net> wrote:
> Commit 5b8e6f85 introduced stubs for three functions that make no sense
> for git-shell. But those stubs defined libgit.a functions a second time
> so that a linker can complain.
> 
> Now git-shell is only linked to a subset of libgit.a.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> Hi Shawn,
> 
> does this compile on Solaris?

Can't, and won't test it.  Tomorrow is my last day at work and
I won't have time to test it on Solaris.  I don't have any other
Solaris boxes to test on, and don't care to either.

-- 
Shawn.
