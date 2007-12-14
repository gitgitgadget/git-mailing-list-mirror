From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 20:15:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712142015240.27959@racer.site>
References: <1197660157-24109-1-git-send-email-krh@redhat.com>
 <1197660157-24109-2-git-send-email-krh@redhat.com> <Pine.LNX.4.64.0712141928240.27959@racer.site>
 <7vmysdqbui.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-475006500-1197663354=:27959"
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:16:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Gxn-0004nS-Sd
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbXLNUQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXLNUQH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:16:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:53226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754250AbXLNUQG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:16:06 -0500
Received: (qmail invoked by alias); 14 Dec 2007 20:16:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 14 Dec 2007 21:16:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185m3xUyS85U6PWGKPZ/vskcxhtgxM1YR0sB1GDI9
	8zS5cHUTt1GnVy
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmysdqbui.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68337>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-475006500-1197663354=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 14 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 14 Dec 2007, Kristian Høgsberg wrote:
> >
> >> -	struct lock_file *lock = NULL;
> >> +	struct lock_file lock;
> >
> > AFAICT this cannot work.  At least not reliably.  An atexit() handler 
> > will access all (even closed) lockfiles.
> 
> Correct.  It cannot be on the stack.

Note that this behaviour will be another obstacle to libification.

Ciao,
Dscho

---1463811741-475006500-1197663354=:27959--
