From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 20:16:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305072323.GA31169@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1519624341-1173122195=:22628"
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOIfp-0005NM-6I
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 20:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXCETQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXCETQh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 14:16:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:36437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932270AbXCETQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 14:16:36 -0500
Received: (qmail invoked by alias); 05 Mar 2007 19:16:35 -0000
X-Provags-ID: V01U2FsdGVkX1+vrhg3zt+vOu180thsFyzeZWESSyODEV5/PGPK5r
	2NwkltIPOmdU0w
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17900.27067.247950.419438@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41475>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1519624341-1173122195=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 Mar 2007, Bill Lear wrote:

> On Monday, March 5, 2007 at 12:32:07 (+0100) Johannes Schindelin writes:
>
> >On Mon, 5 Mar 2007, Karl Hasselström wrote:
> >
> >> On 2007-03-02 20:21:17 +0100, Johannes Schindelin wrote:
> >> 
> >> > On Fri, 2 Mar 2007, Karl Hasselström wrote:
> >> >
> >> > > However, given that your file timestamps have been bumped (without
> >> > > file content changes),
> >> >
> >> > There were changes. Only that they have been taken back, but that is
> >> > _another_ change.
> >> 
> >> Since the content is exactly the same as before, I'd be of the strong
> >> opinion that nothing has changed as far as the make system should be
> >> concerned.
> >
> >You are missing an important point here: there _was_ a change.
> 
> Physically, yes, the bits were changed,

Yeah, I know people, who would like to change laws of physics, too.

> but logically nothing has changed, at least in the scenario I outlined.

But it could! Even in the scenario you outlined. If somebody (might be 
even you yourself) pushes into your repo, under the name of the branch to 
which you switch back to right after that. Bingo. Files changed.

See? That is what happens if you don't fix things the right way, you keep 
getting problems. Yes, you can solve them in another tacky way, but you'll 
only get different problems, then.

Ciao,
Dscho

---1148973799-1519624341-1173122195=:22628--
