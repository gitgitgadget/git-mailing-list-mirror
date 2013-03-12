From: Jeff King <peff@peff.net>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 21:10:04 -0400
Message-ID: <20130312011004.GA21242@sigill.intra.peff.net>
References: <513B8037.7060107@gmail.com>
 <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
 <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
 <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
 <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com>
 <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de>
 <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
 <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
 <20130312010114.GA21026@sigill.intra.peff.net>
 <513E7EEE.3060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Horn <max@quendi.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 02:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFDjg-0004pU-9x
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 02:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab3CLBKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 21:10:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46380 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab3CLBKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 21:10:07 -0400
Received: (qmail 21078 invoked by uid 107); 12 Mar 2013 01:11:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Mar 2013 21:11:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2013 21:10:04 -0400
Content-Disposition: inline
In-Reply-To: <513E7EEE.3060107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217932>

On Mon, Mar 11, 2013 at 09:03:42PM -0400, Andrew Wong wrote:

> On 03/11/13 21:01, Jeff King wrote:
> > From "git help config":
> >
> >   core.trustctime
> >     If false, the ctime differences between the index and the working
> >     tree are ignored; useful when the inode change time is regularly
> >     modified by something outside Git (file system crawlers and some
> >     backup systems). See git-update- index(1). True by default.
>
> In an earlier email, Max did mention setting the config does workaround
> the issue. But it's still strange that it only happens to a few specific
> files in this particular repo. The issue never popped up in other repos
> that he has, which I assume has all been excluded from Time Machine...

Ah, sorry, I missed the earlier reference to it. trustctime is the only
sensible thing to do from the git side. I think figuring out the rest is
deep Apple magic that I'm not qualified to comment on.

-Peff
