From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 15:42:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021541470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>  <alpine.DEB.1.00.0810021433130.22125@pacific.mpi-cbg.de.mpi-cbg.de> <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:37:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOMS-0007Ca-PC
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbYJBNfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 09:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbYJBNfp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:35:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:60601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753273AbYJBNfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:35:44 -0400
Received: (qmail invoked by alias); 02 Oct 2008 13:35:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 02 Oct 2008 15:35:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pYBtdZbap5Ee4BK6VLRjTJNt2A8Biyqw7ALWB56
	r3Y73ehUOBtzQV
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97325>

Hi,

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> On Thu, Oct 2, 2008 at 2:33 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
> >
> >> Set auto-number true by default, allowing the format.number key to be
> >> set to 'noauto' to override this.
> >> ---
> >>  builtin-log.c |    6 +++++-
> >>  1 files changed, 5 insertions(+), 1 deletions(-)
> >
> > Interesting.  No sign-off, no defense why this is actually desirable,
> > after we lived for so long without this behavior... Care to elaborate?
> 
> Doh, sorry about the Sign-off, I'll resend with.
> 
> Now, about the reason for this patch: I would say that the most common
> use-case of format-patch being used to prepare multiple patches is
> when one plans on sending a patchset. When format.numbering is set to
> auto, single-patches will still be extracted without numbers, but
> patchset will be properly numbered.
> 
> Of course, there may be cases where one doesn't want numbering (for
> which there is the -N flag already), and of course we want to give the
> user the choice to disable autonumbering at the config level, for
> which there is the new noauto option for format.numbering.
> 
> If this explanation is good enough for you, I'll plop it in the resend
> message too :)

Yep, this is worthy of a commit message.

Thanks,
Dscho
