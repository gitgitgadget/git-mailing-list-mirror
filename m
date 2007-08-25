From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Sat, 25 Aug 2007 16:39:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708251639100.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
 <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
 <7v8x81s7d1.fsf@gitster.siamese.dyndns.org> <9B94A29F-AF61-46C0-8497-C7372DF73250@pp.inet.fi>
 <Pine.LNX.4.64.0708241154410.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <0748D6C4-C72F-4271-9372-3EBFC249FFE2@pp.inet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Sat Aug 25 16:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOwo6-00088k-GB
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 16:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759965AbXHYOjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 10:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759964AbXHYOjk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 10:39:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:60810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758181AbXHYOjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 10:39:39 -0400
Received: (qmail invoked by alias); 25 Aug 2007 14:39:37 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 25 Aug 2007 16:39:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+n2fxJ3Oun/Rr0lLbYoUt8D/z5bS5FrPA9Y0usWZ
	Y7qZ7jFV7gRpN+
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <0748D6C4-C72F-4271-9372-3EBFC249FFE2@pp.inet.fi>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56637>

Hi,

On Fri, 24 Aug 2007, V?in? J?rvel wrote:

> On Aug 24, 2007, at 12:55, Johannes Schindelin wrote:
> > On Fri, 24 Aug 2007, V?in? J?rvel wrote:
> > > I also think that maintaining a proper .gitignore is imporant, and 
> > > more productive than using --only-tracked instead. But when I have 
> > > cruft that can't be put in .gitignore, or it would ignore files that 
> > > are supposed to be shown and tracked, I use --only-tracked.
> > 
> > Would it not be better to imitate the "-x" and "-X" options of 
> > ls-files, then?  You could achieve the effect you desire by "git 
> > status -x \*" then.
> 
> I haven't used that option, do I understand correctly, that with that 
> option, you should provide another exclusion file? That would remove the 
> dynamic ability of --only-tracked.

-X takes a filename, -x a pattern.

Hth,
Dscho
