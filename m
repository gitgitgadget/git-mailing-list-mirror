From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 14:27:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281426370.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> 
 <474AC136.8060906@viscovery.net>  <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
  <Pine.LNX.4.64.0711261340470.27959@racer.site>  <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
  <7vir3m94ku.fsf@gitster.siamese.dyndns.org>  <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
  <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>  <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
  <Pine.LNX.4.64.0711281355460.27959@racer.site>
 <fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNto-0006s6-KF
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXK1O2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbXK1O2E
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:28:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:51441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755547AbXK1O2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:28:01 -0500
Received: (qmail invoked by alias); 28 Nov 2007 14:28:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 28 Nov 2007 15:28:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19E3ilRj1NE/igZlWlDLaz4sfpYrCS+RCRM7etlu9
	bGn4yXMwcE3g/m
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66344>

Hi,

On Wed, 28 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 28, 2007 8:57 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > It might be POSIX, but there are shells that do not like the
> > expression 'export VAR=VAL'.  To be on the safe side, rewrite them
> > into 'VAR=VAL' and 'export VAR'.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> >         On Wed, 28 Nov 2007, Wincent Colaiuta wrote:
> >
> >         > I'm still a little concerned that nobody commented when I
> >         > pointed out that export VAR=VAL is used elsewhere in Git,
> >         > especially in git-clone.sh, which is very commonly-used
> >         > porcelain. Is it a problem?
> >
> >         How's that for a comment?
> >
> >  git-clone.sh         |    2 +-
> >  git-filter-branch.sh |   20 ++++++++++++--------
> >  git-quiltimport.sh   |   10 ++++++----
> >  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> Why leave test scripts behind?

Because I did a

	git grep 'export.*=' *.sh

instead of a

	git grep 'export.*=' -- \*.sh

But this patch is

- good of its own, and

- a comment ;-)

Ciao,
Dscho
