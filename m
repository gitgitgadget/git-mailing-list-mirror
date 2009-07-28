From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 14:31:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281428220.8306@pacific.mpi-cbg.de>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch> <alpine.DEB.1.00.0907281248040.8306@pacific.mpi-cbg.de> <200907281353.07590.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 14:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVlq9-0001bs-V6
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 14:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbZG1MbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 08:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbZG1MbX
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 08:31:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:33554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753700AbZG1MbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 08:31:22 -0400
Received: (qmail invoked by alias); 28 Jul 2009 12:31:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 28 Jul 2009 14:31:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cQSF5DOscPXDUqvT7lCIuaB0ujKCoR3nwqtvaw+
	91YS+KDgWPe/Wk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200907281353.07590.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124243>

Hi,

On Tue, 28 Jul 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 28 Jul 2009, Thomas Rast wrote:
> > 
> > > This means that 'git log -g --date=normal' shows the date, whereas 
> > > 'git log -g --date=default' shows the reflog entry number.
> > 
> > I find this highly unintuitive, sorry.  I'd prefer it if it showed the 
> > date whenever I specify a date format.
> 
> So you'd rather have a toggle --[no-]reflog-date?  Which would make a
> lot of sense, but probably not be backwards compatible in the sense
> that log.date suddenly stops affecting the reflog date display.

No, I do not see any sense in doing this kind of sophistication.  If I ask 
for a date format, it should show me the dates.  If I don't ask for a date 
format, it should show me the reflog number.

Inspecting reflogs is an interactive task, and I do not think that this 
justifies the complications you suggested.  I can _easily_ say "git log 
-g" and then "git show --date=relative <commit>".  Not that I _ever_ 
needed such a thing.

> > And I'd prefer not to have a distinction between "default" and 
> > "normal".
> 
> I actually had to change that because I wanted to allow the user to 
> override the log.date config.  Saying --date=unspecified doesn't make a 
> lot of sense :-)

And what exactly does "--no-date" mean?  Does it not say _exactly_ what 
"--date=unspecified" would _intuitively_ mean?

I am getting more and more the feeling that this patch series is in search 
of a problem it can solve.

Ciao,
Dscho
