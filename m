From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Thu, 17 Feb 2011 18:38:51 +0100
Message-ID: <20110217173851.GB91738@book.hvoigt.net>
References: <20110212070538.GA2459@sigill.intra.peff.net> <20110213123151.GA31375@book.hvoigt.net> <20110215063903.GA28634@sigill.intra.peff.net> <20110215191620.GA56397@book.hvoigt.net> <87pqqtaxke.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org, Pat Thoyts <patthoyts@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 18:39:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq7oh-0003sz-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 18:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab1BQRiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 12:38:55 -0500
Received: from darksea.de ([83.133.111.250]:39312 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750963Ab1BQRix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 12:38:53 -0500
Received: (qmail 28066 invoked from network); 17 Feb 2011 18:38:51 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2011 18:38:51 +0100
Content-Disposition: inline
In-Reply-To: <87pqqtaxke.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167096>

Hi,

On Tue, Feb 15, 2011 at 07:48:33PM +0000, Pat Thoyts wrote:
> From: Heiko Voigt <hvoigt@hvoigt.net>
> Date: Tue, 15 Feb 2011 19:43:54 +0000
> Subject: [PATCH] git-gui: warn when trying to commit on a detached head
> 
> The commandline is already warning when checking out a detached head.
> Since the only thing thats potentially dangerous is to create commits
> on a detached head lets warn in case the user is about to do that.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
[...]
> My feeling is that the user should be making a branch to hold his
> commits. So I suggest adding some text to suggest that a branch be
> created and keep annoying the user every time they commit to a detached
> head. This errs on the side of not dropping commits into the reflog
> which seems the most useful strategy to me.
> 
> So here is a modded version of Heiko's patch.

Thanks for cleaning up my wording. I would be fine with this patch.
I played with creating a dialog including a checkbox yesterday. Please
see my other answer to this thread whether we work on this further.
Otherwise I would be fine with just issuing the warning every time. Its
better than not warning at all and using the configuration option a
clueful person can still disable the warning.

Cheers Heiko

P.S.: Should I prepare a separate patch to document the variable for
      Junio once he pulls again from you?
