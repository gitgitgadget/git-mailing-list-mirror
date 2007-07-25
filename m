From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: submodule init problem
Date: Wed, 25 Jul 2007 21:50:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707252150090.14781@racer.site>
References: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
  <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>  <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
  <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com> 
 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org> 
 <Pine.LNX.4.64.0707201933360.14781@racer.site>  <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
  <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org> 
 <8c5c35580707251325i2633777pdd7604b541506533@mail.gmail.com> 
 <Pine.LNX.4.64.0707252129150.14781@racer.site>
 <8c5c35580707251340n2f1a9fd2j5fdf322277d68d26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Ricky Nite <ricky.nite@gmail.com>,
	Chris Larson <clarson@kergoth.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDnon-0007rb-No
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760500AbXGYUuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760081AbXGYUug
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:50:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:48210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756927AbXGYUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:50:35 -0400
Received: (qmail invoked by alias); 25 Jul 2007 20:50:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 25 Jul 2007 22:50:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iqP8KDFMi7PeqBA5rtap44E6ARJkdBWLfl8lCvC
	YHV7nXvSTU0hFD
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580707251340n2f1a9fd2j5fdf322277d68d26@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53719>

Hi,

On Wed, 25 Jul 2007, Lars Hjemli wrote:

> On 7/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 25 Jul 2007, Lars Hjemli wrote:
> > >  eol='$'
> > >  git config --get-regexp '^submodule\..*\.path$' "^$1$eol"
> > 
> > Ah, now I get it.  You are looking for the _key_ whose value is "$1".
> 
> Yes
> 
> > And you do not need the eol hack.
> 
> Hmm, I tried misc. quoting/escaping without success, care to educate me?

I already did ;-I  "^$1$"

Ciao,
Dscho
