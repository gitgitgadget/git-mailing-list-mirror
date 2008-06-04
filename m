From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Wed, 4 Jun 2008 15:59:34 -0400
Message-ID: <20080604195934.GU12896@spearce.org>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com> <200806031856.11060.robin.rosenberg.lists@dewire.com> <20080603225418.GP12896@spearce.org> <200806040130.41654.robin.rosenberg.lists@dewire.com> <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com> <20080604042703.GQ12896@spearce.org> <320075ff0806032340k9814a81g196e0417d42a3f6@mail.gmail.com> <7bfdc29a0806032346r433e003exc7408f1ff626457d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nigel Magnay <nigel.magnay@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3z9z-00012h-Ah
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759665AbYFDT7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759626AbYFDT7l
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:59:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57526 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759430AbYFDT7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:59:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3z8q-00011r-8X; Wed, 04 Jun 2008 15:59:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5237420FBAE; Wed,  4 Jun 2008 15:59:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0806032346r433e003exc7408f1ff626457d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83817>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> On Wed, Jun 4, 2008 at 12:40 PM, Nigel Magnay <nigel.magnay@gmail.com> wrote:
> >>
> >> But this shows one reason why I don't use Maven I think.  The
> >> fact that we need a "java" directory to hold our java code.
> >> What if another build system wants a different name?  Grumble.
> >>
> >
> > You don't. Just set the appropriate config item in pom.xml
> > (sourceDirectory possibly, but my memory isn't good this morning) and
> > you can use 'src' as it is currently. src/main/java is just the
> > default.
> 
> You are absolutely right in fact (your memory did not betray ;)) its
> <project><build><sourceDirectory>.

If we can avoid doing this rename and instead just configure Maven
to use the existing directory it would be better.  Then we don't
have to bother everyone's branches with this rename business.

-- 
Shawn.
