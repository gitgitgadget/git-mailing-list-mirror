From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 13:05:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111304520.10279@pacific.mpi-cbg.de>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>  <200903100808.15875.chriscool@tuxfamily.org>  <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com> <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1146329515-1236773149=:10279"
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhNBs-0003K8-3b
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbZCKMEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbZCKMEL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:04:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:59744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755135AbZCKMEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 08:04:10 -0400
Received: (qmail invoked by alias); 11 Mar 2009 12:04:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 11 Mar 2009 13:04:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18f80VSQtUfhzcGFnDa+30QbTCLf6cJRHwb7is0zF
	LNwfyAmkfeSO4W
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112916>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1146329515-1236773149=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 11 Mar 2009, John Tapsell wrote:

> 2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
> > On Tue, Mar 10, 2009 at 7:08 AM, Christian Couder
> > <chriscool@tuxfamily.org> wrote:
> >
> >> I will try to have a look at the end of this week.
> >> But do you want it to be integrated with Git or do you want it to be an
> >> independant project that works with many different version control system?
> >
> > Hmm. Whatever works, I guess. On the one hand the code does seem
> > naturally generic. On the other hand, it's good if users don't
> > have to separately obtain an extra package to use it. Supposing that
> > the algorithm proves useful, would the git project  be okay with an
> > extra dependency, or would you want to integrate it? Right now it's in
> > python, which I understand is an obstacle to integration.
> 
> There used to be a dependency on python.  git-merge-recursive for
> example, before it was converted to C.

Not "for example".  It was the only dependency of git.git on Python, and 
the rewrite of merge-recursive was only done to break that dependency, as 
I had a platform where I could not install Python.

Ciao,
Dscho

--8323328-1146329515-1236773149=:10279--
