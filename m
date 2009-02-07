From: "Fabian Franz" <FabianFranz@gmx.de>
Subject: Re: [PATCH] submodule: add --no-fetch parameter to update command
Date: Sat, 07 Feb 2009 16:44:25 +0100
Message-ID: <20090207154425.325390@gmx.net>
References: <1233872312-17781-1-git-send-email-git@fabian-franz.de>
 <8c5c35580902061001m6259d4ebt1c0dea7691b0a5dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 16:45:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVpNS-00076c-Vm
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbZBGPo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZBGPo2
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:44:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:51280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752106AbZBGPo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:44:27 -0500
Received: (qmail 4301 invoked by uid 0); 7 Feb 2009 15:44:25 -0000
Received: from 129.13.186.2 by www177.gmx.net with HTTP;
 Sat, 07 Feb 2009 16:44:25 +0100 (CET)
In-Reply-To: <8c5c35580902061001m6259d4ebt1c0dea7691b0a5dc@mail.gmail.com>
X-Authenticated: #590723
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1813rsazF41WjvuHCip9dCCNN9nUAnmjLoqBbMYBv
 4hQfTNhGcbAw9GK5K7iYZtIzn7Dd5sObrO5w== 
X-GMX-UID: a5W1fCcMbmwoR/FxYTdLSPFPUzc4clFn
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108863>

> Fabian Franz <git@fabian-franz.de> writes:
> 
> > git submodule update --no-fetch makes it possible to use git submodule
> > update in complete offline mode by not fetching new revisions.
> >
> > This does make sense in the following setup:
> >
> > * There is an unstable and a stable branch in the super/master
> repository.
> > * The submodules might be at different revisions in the branches.
> > * You are at some place without internet connection ;)
> >
> > With this patch it is now possible to change branches and update
> > the submodules to be at the recorded revision without online access.
> 
> How is this better than "cd submodule/path && git checkout whatever"?

It is better if you have a complex setup recorded in the master repository.

If my co-worker commited his newest revisions for the "stable" branch, I
might not know which of his revisions I need to checkout.

> > Another advantage is that with -N the update operation is faster,
> > because fetch is checking for new updates even if there was no
> > fetch/pull on the super/master repository since the last update.
> 
> Do we know this is common enough to deserve a shortopt -N?

I don't think so, gonna resend later.

> The logic of the patch itself looks sane to me.

Nice.

Best Wishes,

Fabian
