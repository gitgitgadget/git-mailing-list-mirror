From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 13:37:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1aD-0001r1-6B
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbXB0Mh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933069AbXB0Mh0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:37:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:54407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933040AbXB0MhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:37:25 -0500
Received: (qmail invoked by alias); 27 Feb 2007 12:37:24 -0000
X-Provags-ID: V01U2FsdGVkX18xWR8Ns/gxLYkeS2eCAuuwyOT233xEIF5k7k7HzJ
	lwDQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <877iu3q13r.fsf@latte.josefsson.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40720>

Hi,

On Tue, 27 Feb 2007, Simon Josefsson wrote:

> Hi!  I'm considering switching to git for my projects (shishi, gsasl,
> gnutls, libtasn1, opencdk, ...) and I have some questions:
> 
> * How do I discard all locally modified or added files?  'cvs upd -C'
>   does some of that, but I've been using a tool 'cvsco' which quickly
>   restore a CVS checkout into a pristine state.

The command in git is called "git reset --hard". Beware: this really, 
really loses _all_ local changes. And no need to worry when it completes 
much faster than you expected it to... See "git status" to see that it 
worked, indeed.
 
> * Is there a tool that produce ChangeLog files in the GNU format,
>   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
>   should look like:
> 
> 2007-02-22  Simon Josefsson <simon@josefsson.org>
> 
> 	* link-warning.h, gl/getaddrinfo.c, gl/gnulib.mk, gl/string_.h,
> 	gl/m4/gnulib-comp.m4, gl/m4/string_h.m4, lgl/Makefile.am,
> 	lgl/snprintf.c, lgl/snprintf.h, lgl/stdio_.h, lgl/string_.h,
> 	lgl/unistd_.h, lgl/m4/gnulib-comp.m4, lgl/m4/intdiv0.m4,
> 	lgl/m4/snprintf.m4, lgl/m4/stdio_h.m4, lgl/m4/string_h.m4,
> 	lgl/m4/unistd_h.m4: Update.

Let me hack something.

Ciao,
Dscho
