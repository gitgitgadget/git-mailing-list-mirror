From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:17:14 -0500
Message-ID: <20130211041714.GA12281@sigill.intra.peff.net>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kpq-0003bw-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3BKERT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:17:19 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43953 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab3BKERQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:17:16 -0500
Received: (qmail 17868 invoked by uid 107); 11 Feb 2013 04:18:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Feb 2013 23:18:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2013 23:17:14 -0500
Content-Disposition: inline
In-Reply-To: <20130211041404.GA15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215985>

On Sun, Feb 10, 2013 at 08:14:04PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Sun, Feb 10, 2013 at 05:20:16PM -0800, Jonathan Nieder wrote:
> 
> >> +When run interactively (with no arguments), 'git-shell' will
> >> +automatically run `~/git-shell-commands/help` on startup, provided it
> >> +exists.  If the 'help' command fails then the interactive shell is
> >> +aborted.
> >
> > Doesn't that mean that people who currently do allow interactive access
> > and have a ~/git-shell-commands/help (that returns zero) will get
> > spammed by its as a motd each time they connect?
> 
> Only interactive connections.  That's the existing behavior.

Ah, sorry. I misread the patch. I see now that we already run help, and
this is just making the exit value significant. In that case, yeah, I
think it's fine.

-Peff
