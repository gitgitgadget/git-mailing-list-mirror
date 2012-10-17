From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 19:39:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210171936170.3049@bonsai2>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.1210171759230.3049@bonsai2> <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 19:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOXbd-0007Hp-4H
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 19:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab2JQRkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 13:40:20 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:53639 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755751Ab2JQRkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 13:40:19 -0400
Received: (qmail invoked by alias); 17 Oct 2012 17:39:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO client.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 17 Oct 2012 19:39:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19yZ0BGdDlyL/ireWkYTfD4c1B3hHIoI+rgD7d5Wc
	7pomhWg8Qbnhjc
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207925>

Hi,

On Wed, 17 Oct 2012, Felipe Contreras wrote:

> On Wed, Oct 17, 2012 at 6:03 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 17 Oct 2012, Felipe Contreras wrote:
> >
> >> I've looked at many hg<->git tools and none satisfy me. Too
> >> complicated, or too slow, or to difficult to setup, etc.
> >
> > The one I merged into Git for Windows (since that is what I install on
> > all my machines even if they run Linux) is rock-solid. It also comes
> > with tests. And it requires a fix I tried to get into git.git (but
> > failed, since I was asked to do much more in addition to what I needed
> > for myself, and I lack the time to address such requests these days).
> 
> Maybe, but who uses it? It's quite a lot of code, and it's quite
> difficult to setup--you would need a non-vanilla version of git.

Okay, so the difficulty of setting it up is because it is not in mainline
git.git?

> Compare this:
> 32 files changed, 3351 insertions(+), 289 deletions(-)
> 
> To this:
> 1 file changed, 231 insertions(+)

Yeah, and that's also because of the severe lack of tests. And the lack of
possible code-sharing with other remote helpers.

As for who uses it:

	https://github.com/dscho/hg

> It would be better to work together, but to me the code-styles are way
> too different, the difference between night and day.

Aha. Well, okay, it was an offer to collaborate.

Ciao,
Johannes
