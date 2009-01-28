From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Thu, 29 Jan 2009 00:27:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901290024290.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain> <69A01114-27BB-4239-8FD8-C35D1306CE25@alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jean-loup Gailly <jloup@gzip.org>,
	Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Adler <madler@alumni.caltech.edu>
X-From: git-owner@vger.kernel.org Thu Jan 29 00:28:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJpo-0003pN-GP
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbZA1X1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZA1X1N
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:27:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:48240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752860AbZA1X1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:27:12 -0500
Received: (qmail invoked by alias); 28 Jan 2009 23:27:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 29 Jan 2009 00:27:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19y9Epnhb5ydB982OLSBbOYXZNWWpgLe0QBcW8D7U
	sXCWlPS7bS0jQG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <69A01114-27BB-4239-8FD8-C35D1306CE25@alumni.caltech.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107597>

Hi,

On Wed, 28 Jan 2009, Mark Adler wrote:

> 2.  Can someone send me the input and the 58 bytes of output from this 
>    case?

I did better than that already... 
http://article.gmane.org/gmane.comp.version-control.git/107391

Maybe it did not go through correctly.

Unfortunately, I was sick today and could not do any proper work, so I 
could not even test the suggestions Julian gave me.

The easiest test, though, should be to set the byte at offset 51 to 
something bogus and see if inflate() still groks it.

Ciao,
Dscho
