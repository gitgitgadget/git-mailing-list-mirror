From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Sat, 8 Mar 2008 02:24:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803080223030.3975@racer.site>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>  <20080305204414.GB4877@steel.home>  <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com>  <20080307164111.GB4899@steel.home>
 <8aa486160803071613pdacc88fkabc10f52da56ad5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1250331248-1204939470=:3975"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXno9-0007L2-Jd
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 02:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbYCHBY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 20:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbYCHBY1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 20:24:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:40126 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755649AbYCHBY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 20:24:26 -0500
Received: (qmail invoked by alias); 08 Mar 2008 01:24:24 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp004) with SMTP; 08 Mar 2008 02:24:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CBqsJRweCOjG+c02yYODzjzT0Q7vtGVdUKcobUG
	YkaMYsGXVLPeHD
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160803071613pdacc88fkabc10f52da56ad5d@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76536>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1250331248-1204939470=:3975
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 8 Mar 2008, Santi Béjar wrote:

> On Fri, Mar 7, 2008 at 5:41 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Santi Béjar, Thu, Mar 06, 2008 22:45:43 +0100:
> >
> >
> > > On Wed, Mar 5, 2008 at 9:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> >  > > Santi Béjar, Wed, Mar 05, 2008 20:18:04 +0100:
> >  > >
> >  > >  > @@ -171,7 +171,7 @@ static const char au_env[] = "GIT_AUTHOR_NAME";
> >  > >  >  static const char co_env[] = "GIT_COMMITTER_NAME";
> >  > >  >  static const char *env_hint =
> >  > >  >  "\n"
> >  > >  > -"*** Your name cannot be determined from your system services (gecos).\n"
> >  > >  > +"*** Your name cannot be determined.\n"
> >  > >
> >  > >  Why not?
> >  >
> >  > Is this important? Or in another way, is this useful? The important
> >  > thing is how you can fix it. But others think otherwise I'll change it
> >  > to explain the reason.
> >
> >  It is precise explanation of what happened. It could be a hint to fix
> >  gecos field to someone. It is considered useful not to hide
> >  information, even if you have no idea of how useful it is.
> 
> I'll wait for others to comment.

I thought I asked why you had to remove the comment (which seems not to 
have a proper reasoning in the commit message), but maybe I did not.

So here it is in writing: I agree with Alex on the criticism on this part 
of your patch.

> >  Others may be smarter than you.
> 
> I don't think this is necessary.

It is not necessary that others may be smarter than you, alright.

Hth,
Dscho

--8323584-1250331248-1204939470=:3975--
