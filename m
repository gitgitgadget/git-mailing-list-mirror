From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Tue, 23 Jan 2007 12:26:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231225450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com>  <200701191310.32417.jnareb@gmail.com>
  <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <200701192344.11972.jnareb@gmail.com>  <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701220706w65ed0657h1d69819e7879ed40@mail.gmail.com> 
 <Pine.LNX.4.63.0701221619110.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701220733j1002bd9dse8db491512c7a500@mail.gmail.com> 
 <Pine.LNX.4.63.0701221643030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0701220809w1851cbfp5aa7e027ce79eed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 12:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9JnA-00050R-0G
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 12:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbXAWL0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 06:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXAWL0R
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 06:26:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:38992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932952AbXAWL0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 06:26:16 -0500
Received: (qmail invoked by alias); 23 Jan 2007 11:26:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 23 Jan 2007 12:26:15 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701220809w1851cbfp5aa7e027ce79eed3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37501>

Hi,

On Mon, 22 Jan 2007, Alex Riesen wrote:

> On 1/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > BTW IMHO we will probably never libify git; too many too 
> > > > complicated cases exist already.
> > >
> > > We probably don't need it libified completely. Just reading and writing of
> > > the object database and tags/references and very simple revision walking
> > > will be a very good start [...]
> > 
> > ... and even these use xmalloc(), which die()s on out-of-memory. Note that
> > it would be a really horrible work to libify that, since you basically
> > have to insert gazillions of free() calls at the right point, which we
> > don't have to, since exit() cleans up after us anyway.
> 
> Didn't say it'd be simple. Just not impossible.

I thought that was what you meant by "very simple revision walking".

Ciao,
Dscho
