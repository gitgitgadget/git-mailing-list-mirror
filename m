From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 15:08:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101507590.30769@pacific.mpi-cbg.de>
References: <87wsd48wam.fsf@iki.fi> <gk8usj$slh$1@ger.gmane.org> <alpine.DEB.1.00.0901101237050.30769@pacific.mpi-cbg.de> <200901101436.48149.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeWh-0003GP-2K
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbZAJOIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZAJOIB
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:08:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:36756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbZAJOIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:08:00 -0500
Received: (qmail invoked by alias); 10 Jan 2009 14:07:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 10 Jan 2009 15:07:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rW5UNNR3rR4FJbTH1nG7oh9mkWQMAtLjFn1tora
	bwhgpUwQmlJhB4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901101436.48149.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105111>

Hi,

On Sat, 10 Jan 2009, Jakub Narebski wrote:

> On Sat, 10 Jan 2009, Johannes Schindelin wrote:
> > On Sat, 10 Jan 2009, Jakub Narebski wrote:
> > > Thomas Rast wrote:
> > > 
> > > > --color-words works (and always worked) by splitting words onto one
> > > > line each, and using the normal line-diff machinery to get a word
> > > > diff. 
> > > 
> > > Cannot we generalize diff machinery / use underlying LCS diff engine
> > > instead of going through line diff?
> > 
> > What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
> > That's why we're substituting non-word characters with newlines.
> 
> Isn't Meyers algorithm used by libxdiff based on LCS, largest common
> subsequence, and doesn't it generate from the mathematical point of
> view "diff" between two sequences (two arrays) which just happen to
> be lines? It is a bit strange that libxdiff doesn't export its low
> level algorithm...

Umm.

It _is_ Myers' algorithm.  It just so happens that libxdiff hardcodes 
newline to be the separator.

Ciao,
Dscho
