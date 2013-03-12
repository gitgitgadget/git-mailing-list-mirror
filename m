From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Tue, 12 Mar 2013 09:26:51 +0100
Message-ID: <20130312082650.GA4075@sandbox-ub.fritz.box>
References: <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
 <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
 <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
 <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com>
 <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de>
 <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
 <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
 <20130312010114.GA21026@sigill.intra.peff.net>
 <513E7EEE.3060107@gmail.com>
 <20130312011004.GA21242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, Max Horn <max@quendi.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 09:27:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFKYO-0005dt-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 09:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab3CLI04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 04:26:56 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:41219 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab3CLI0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 04:26:55 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UFKXs-0003BL-Bo; Tue, 12 Mar 2013 09:26:52 +0100
Content-Disposition: inline
In-Reply-To: <20130312011004.GA21242@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217937>

On Mon, Mar 11, 2013 at 09:10:04PM -0400, Jeff King wrote:
> On Mon, Mar 11, 2013 at 09:03:42PM -0400, Andrew Wong wrote:
> 
> > On 03/11/13 21:01, Jeff King wrote:
> > > From "git help config":
> > >
> > >   core.trustctime
> > >     If false, the ctime differences between the index and the working
> > >     tree are ignored; useful when the inode change time is regularly
> > >     modified by something outside Git (file system crawlers and some
> > >     backup systems). See git-update- index(1). True by default.
> >
> > In an earlier email, Max did mention setting the config does workaround
> > the issue. But it's still strange that it only happens to a few specific
> > files in this particular repo. The issue never popped up in other repos
> > that he has, which I assume has all been excluded from Time Machine...
> 
> Ah, sorry, I missed the earlier reference to it. trustctime is the only
> sensible thing to do from the git side. I think figuring out the rest is
> deep Apple magic that I'm not qualified to comment on.

>From what I read isn't the ctime the only thing that changes? I read
that you tried this option and the issues disappeared? Maybe the
resolution (or part of it) is to change the default of core.trustctime
to false on osx?

Cheers Heiko
