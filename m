From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 1 Oct 2008 08:36:37 -0700
Message-ID: <20081001153637.GC21310@spearce.org>
References: <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net> <48E3312E.4090601@op5.se> <20081001151011.GA21310@spearce.org> <20081001152546.GB4962@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:38:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3lt-0005Vw-LN
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYJAPgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYJAPgj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:36:39 -0400
Received: from george.spearce.org ([209.20.77.23]:54954 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYJAPgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:36:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A3F983835F; Wed,  1 Oct 2008 15:36:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081001152546.GB4962@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97238>

Jeff King <peff@peff.net> wrote:
> On Wed, Oct 01, 2008 at 08:10:11AM -0700, Shawn O. Pearce wrote:
> 
> > Actually I rather like the patch you submitted yesterday:
> > 
> >         normal case
> >         Created abc9056 (i386: Snib the sprock) on i386
> > 
> >         detached head
> >         Created DETACHED commit abc9056 (i386: Snib the sprock)
> > 
> >         initial commit
> >         Created root-commit abc9056 (i386: Snib the sprock) on i386
> > 
> > The detached HEAD and root-commit cases are clearly denoted at the
> > very start of the line, where your eyes are likely to start scanning
> 
> I agree with your assumption that people scan the line from left to
> right, and that the most important stuff should come first. So that
> format covers _those_ cases, but not the case of "oops, I committed on
> a different branch than I intended." So I think it really makes sense
> to keep the branch name on the left side, and the commit subject last.

I briefly considered a format like this while replying above, but
at prior day-job I used rather long branch names (sometimes with
common prefixes) so it would truncate alot:

  normal case
  On i386           abc9056 (i386: Snib the sprock)

  detached head
  On DETACHED HEAD  abc9056 (i386: Snib the sprock)

  initial commit
  On i386
  Root commit       abc9056 (i386: Snib the sprock)

With the branch name field set at about 15 characters and truncated.
The initial commit case is very infrequent so burning two lines
for it to help make it stand out *and* make the branch name clear
isn't really a problem.
 
> > Right now I'm happy with your patch in next.  I don't like taking
> > the paint brush away from folks, but I also don't want to be applying
> > a ton of commit message reformatting patches over the next week.  ;-)
> 
> Welcome to maintainership. ;P

*sigh*  And I just took up the #@*#@!&!*!@ paintbrush myself.
Dammit.  I'm putting it down now.  Really.  :-)

-- 
Shawn.
