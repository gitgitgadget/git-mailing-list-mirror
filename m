From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add option --path to allow to run tests with real systems.
 You must install git before running this test.
Date: Thu, 6 Dec 2007 15:50:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061549491.27959@racer.site>
References: <20071206134817.GA8523@laptop>  <Pine.LNX.4.64.0712061422010.27959@racer.site>
 <fcaeb9bf0712060732r70d07135lf6a01ae2410a0ada@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-367439311-1196956259=:27959"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 16:52:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0J13-00008J-E6
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 16:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbXLFPvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 10:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbXLFPvc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 10:51:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:57001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbXLFPvb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 10:51:31 -0500
Received: (qmail invoked by alias); 06 Dec 2007 15:51:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 06 Dec 2007 16:51:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CSMoVFKHCPAho1/YDJbFyxxFyEzlnvo+AUvkwLx
	QANhGJpoldKWjM
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0712060732r70d07135lf6a01ae2410a0ada@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67297>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-367439311-1196956259=:27959
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Dec 2007, Nguyen Thai Ngoc Duy wrote:

> On Dec 6, 2007 10:23 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Thu, 6 Dec 2007, Nguyễn Thái Ngọc Duy wrote:
> >
> > > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > > ---
> > >  On Thu, Dec 06, 2007 at 10:15:05AM +0700, Nguyen Thai Ngoc Duy wrote:
> > >  > On Dec 6, 2007 2:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > >  > > This is wrong, isn't it?  $path may point at the freshly built but not
> > >  > > installed git executable, but it reports --exec-path the location that
> > >  > > git-foo and friends are to be _eventually_ installed, not the location
> > >  > > they are sitting after built, being tested, waiting to be installed.
> > >  > >
> > >  > Yes, forgot to mention you must do "make install" first :)
> > >  >
> > >
> > >  Perhaps a check to remind people to 'make install' like this?
> >
> > Well, the whole point of "make test" is to be sure that it works before
> > installing it.
> >
> > How about something completely different?
> 
> I still think testing another round after installing is good. But
> that's not my aim. So Ack on your patch (at least the idea because I
> have not used it yet).

No, I think that testing after installing is way too late.

BTW there was no sign-off on my patch (as well as no commit message), 
because it does not work on symbolic-link-challenged systems.  So it was 
purely meant as inspiration.

Ciao,
Dscho

---1463811741-367439311-1196956259=:27959--
