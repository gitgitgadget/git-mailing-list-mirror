From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 14:29:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907311428340.4503@intel-tinevez-2-302>
References: <20090726232154.29594.qmail@science.horizon.com>  <20090731104602.15375.qmail@science.horizon.com>  <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>  <4A72D76D.3050400@drmicha.warpmail.net>
 <40aa078e0907310524x1fe4d84dr858ebc03731ee093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 14:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrEr-0000d4-Qq
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZGaM3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZGaM3N
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:29:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:56709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752544AbZGaM3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:29:12 -0400
Received: (qmail invoked by alias); 31 Jul 2009 12:29:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 31 Jul 2009 14:29:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cytUgovUcSv7BhK9LYe4ohP1m4HpFXDLAVmwKPR
	xhHRVPft1fBLEv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0907310524x1fe4d84dr858ebc03731ee093@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124552>

Hi,

On Fri, 31 Jul 2009, Erik Faye-Lund wrote:

> On Fri, Jul 31, 2009 at 1:37 PM, Michael J
> Gruber<git@drmicha.warpmail.net> wrote:
> >> What did I do wrong? :)
> >
> > You need to go to the x86 directory, apply the patch and run make there.
> > (I made the same mistake.) Also, you i586 (32bit) glibc-devel if you're
> > on a 64 bit system.
> 
> Aha, thanks :)
> 
> Now I'm getting a different error:
> $ make
> as   -o sha1-586.o sha1-586.s
> sha1-586.s: Assembler messages:
> sha1-586.s:4: Warning: .type pseudo-op used outside of .def/.endef ignored.
> sha1-586.s:4: Error: junk at end of line, first unrecognized character is `s'
> sha1-586.s:1438: Warning: .size pseudo-op used outside of .def/.endef ignored.
> sha1-586.s:1438: Error: junk at end of line, first unrecognized character is `s'
> 
> make: *** [sha1-586.o] Error 1
> 
> What might be relevant, is that I'm trying this on Windows (Vista
> 64bit).

Probably using msysGit?  Then you're still using the 32-bit environment, 
as MSys is 32-bit only for now.

Ciao,
Dscho
