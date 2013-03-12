From: Jeff King <peff@peff.net>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 21:01:14 -0400
Message-ID: <20130312010114.GA21026@sigill.intra.peff.net>
References: <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
 <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
 <513B8037.7060107@gmail.com>
 <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
 <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
 <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
 <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com>
 <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de>
 <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
 <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Mar 12 02:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFDbE-0005vZ-Td
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 02:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab3CLBBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 21:01:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46365 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951Ab3CLBBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 21:01:17 -0400
Received: (qmail 20880 invoked by uid 107); 12 Mar 2013 01:02:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Mar 2013 21:02:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2013 21:01:14 -0400
Content-Disposition: inline
In-Reply-To: <A3AD5861-FE88-4D6E-B10A-B83F68BA6368@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217929>

On Tue, Mar 12, 2013 at 01:29:45AM +0100, Max Horn wrote:

> So it seems pretty clear what the cause of this is. Now I still need
> to figure out why it affects that particular repository and not
> others. But at this point I guess it is safe to say that Apple's
> auto-crap-magic revisiond is the root of the problem, and git is
> purely a victim. So I'll stop spamming this list with this issue for
> now, and see if I can figure out a fix that is less invasive than
> turning off revisiond completely (which some application rely on, so
> disabling it may break them badly).

>From "git help config":

  core.trustctime
    If false, the ctime differences between the index and the working
    tree are ignored; useful when the inode change time is regularly
    modified by something outside Git (file system crawlers and some
    backup systems). See git-update- index(1). True by default.

-Peff
