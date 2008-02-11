From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 19:50:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802111950000.3870@racer.site>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>  <m3myq7e3ie.fsf@localhost.localdomain> <e5bfff550802111120x24338cd6n6eb1f6db55fe487f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOegj-0001sC-Hw
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbYBKTun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758824AbYBKTun
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:50:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:46486 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758501AbYBKTum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:50:42 -0500
Received: (qmail invoked by alias); 11 Feb 2008 19:50:39 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp048) with SMTP; 11 Feb 2008 20:50:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sN3VbeknsI2miYeefMWWtnIImzqVhoPxP4ezDTq
	QkDVq0XFuXmztN
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550802111120x24338cd6n6eb1f6db55fe487f@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73573>

Hi,

On Mon, 11 Feb 2008, Marco Costalba wrote:

> On Feb 11, 2008 7:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
> > > So it happens to be just faster to re-clone the whole thing by 
> > > upstream.
> >
> > So what you are doing is passing the work, unnecessary work I'd say, 
> > to some poor server. Not nice.
> 
> To a poor net bandwidth I would say because cloning from zero just 
> downloads the packages.

Not exactly.  Remember, if you did not "repack" via clone, the server 
would spend less cycles _and_ bandwidth on you.  Namely zero.

Ciao,
Dscho
