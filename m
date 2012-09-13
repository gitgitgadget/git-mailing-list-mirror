From: Jeff King <peff@peff.net>
Subject: Re: [GIT PULL] sound fixes for 3.6-rc6
Date: Thu, 13 Sep 2012 09:03:44 -0400
Message-ID: <20120913130344.GC4287@sigill.intra.peff.net>
References: <s5h392m1728.wl%tiwai@suse.de>
 <CA+55aFyo6do-dZiZMiwZkN1Ko+W58+4-zkbfJnpQR+ufw=+8ig@mail.gmail.com>
 <s5hzk4uyvsr.wl%tiwai@suse.de>
 <s5hvcfiyum4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Thu Sep 13 15:03:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC95H-0004jV-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 15:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab2IMNDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 09:03:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43425 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab2IMNDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 09:03:47 -0400
Received: (qmail 2306 invoked by uid 107); 13 Sep 2012 13:04:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 09:04:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 09:03:44 -0400
Content-Disposition: inline
In-Reply-To: <s5hvcfiyum4.wl%tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205368>

On Thu, Sep 13, 2012 at 02:28:51PM +0200, Takashi Iwai wrote:

> > FWIW, it was an output from git-pull-request, which fell back to the
> > equivalent branch.  Usually I check it manually but I forgot it at
> > this time just before going to a meeting.
> > 
> > This was with git 1.7.11.5.  I'll check whether this still happens
> > with 1.7.12.
> 
> The same problem still happens with git 1.7.12.
> This is rather annoying than useful.

I can't reproduce here. What is your exact request-pull invocation? Is
request-pull showing a warning like:

  warn: You locally have sound-3.6 but it does not (yet)
  warn: appear to be at git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
  warn: Do you want to push it there, perhaps?

(it should do so since v1.7.11.2). Maybe we need to make it possible to
bump that warning to a fatal error?

-Peff
