From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle: fix wrong check of read_header()'s return value
 & add tests
Date: Thu, 8 Mar 2007 18:12:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081811360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vslchio4f.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0703081405310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703080558ye4cff44l88eb88d4911222a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>,
	Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMBH-0002tZ-7m
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbXCHRMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXCHRMU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:12:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:38095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752585AbXCHRMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:12:16 -0500
Received: (qmail invoked by alias); 08 Mar 2007 17:12:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 08 Mar 2007 18:12:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8hjNBJff8tplnEGyTn10VQozppQ4RX2o6mDvh9I
	tixXe3D0EsOckj
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703080558ye4cff44l88eb88d4911222a0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41759>

Hi,

On Thu, 8 Mar 2007, Alex Riesen wrote:

> On 3/8/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 6 Mar 2007, Junio C Hamano wrote:
> > > +     (
> > > +             while read x && test -n "$x"
> > > +             do
> > > +                     :;
> > > +             done
> > > +             cat
> > > +     ) <bundle1 >bundle.pack &&
> > 
> > I tried to avoid that, because it was mentioned that this does not work on
> > Cygwin for some reason I forgot.
> > 
> 
> Can't think of a reason why it would not. Just tried: works.
> It works even with \r\n line endings (which I don't understand).

IIRC there was a problem when a file was detected to be text, but 
continued to be binary. Mark?

Ciao,
Dscho
