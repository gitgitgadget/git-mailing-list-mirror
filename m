From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 16:19:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271618210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org>
 <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM478-0003oC-V1
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXB0PTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbXB0PTg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:19:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:47159 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752497AbXB0PTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:19:35 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:19:33 -0000
X-Provags-ID: V01U2FsdGVkX1+yk8UjaJOyVwJqzE3pAbBObLdMVlXf3cd3cFdh7f
	OGmQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40742>

Hi,

On Tue, 27 Feb 2007, Johannes Schindelin wrote:

> On Tue, 27 Feb 2007, Simon Josefsson wrote:
> 
> > * Is there a tool that produce ChangeLog files in the GNU format,
> >   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
> >   should look like:
> > 
> > 2007-02-22  Simon Josefsson <simon@josefsson.org>
> > 
> > 	* link-warning.h, gl/getaddrinfo.c, gl/gnulib.mk, gl/string_.h,
> > 	gl/m4/gnulib-comp.m4, gl/m4/string_h.m4, lgl/Makefile.am,
> > 	lgl/snprintf.c, lgl/snprintf.h, lgl/stdio_.h, lgl/string_.h,
> > 	lgl/unistd_.h, lgl/m4/gnulib-comp.m4, lgl/m4/intdiv0.m4,
> > 	lgl/m4/snprintf.m4, lgl/m4/stdio_h.m4, lgl/m4/string_h.m4,
> > 	lgl/m4/unistd_h.m4: Update.
> 
> Let me hack something.

See my next three posts. This patch series is on top of "next" (it does 
not apply cleanly to "master", since the format "format:" conflicts...).

Ciao,
Dscho
