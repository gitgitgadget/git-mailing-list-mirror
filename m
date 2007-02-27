From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 23:12:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272227500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org> <200702271257.37437.andyparkins@gmail.com>
 <200702272227.05244.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:12:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAZ0-0006lP-Ig
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXB0WMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXB0WMn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:12:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:46448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751923AbXB0WMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:12:43 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:12:41 -0000
X-Provags-ID: V01U2FsdGVkX1+Wztd9TLmW5vzl98k3qiQuTRrJkDToWQeWscncHC
	LBQA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702272227.05244.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40821>

Hi,

On Tue, 27 Feb 2007, Robin Rosenberg wrote:

> tisdag 27 februari 2007 13:57 skrev Andy Parkins:
> 
> > Not that I know of, but git has some lovely log generation tools, so 
> > I'm sure it could be easily done with a snippet of perl - or perhaps a 
> > change to git's own log generator to support
> > 
> >  git-rev-list --pretty=gnucl
> > 
> gir-rev-list ??
> 
> Extend git-shortlog with --gnucl instead. What seems missing is the 
> grouping of changes by date. git-shortlog only groups by author.

No, the revision walker groups by commit (not by date, but you don't want 
that anyway). git-shortlog works _on top_ of the revision walker.

The sane thing _is_ to use the revision walker.

Given the amount of projects using cvs2cl (I personally saw a couple), I 
expect a couple of people to speak up in favour of including support for 
--pretty=cl or =changelog or =gnucl or whatever.

Ciao,
Dscho
