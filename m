From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] teach the user to be nice to git and let him say
 please sometimes
Date: Mon, 13 May 2013 15:44:15 +0200
Message-ID: <20130513134415.GB3561@book-mint>
References: <20130511201928.GA22938@book.hvoigt.net>
 <7vobcfvqu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 15:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubt3N-0006ET-5y
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab3EMNoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:44:30 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:36358 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab3EMNo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:44:28 -0400
Received: from [77.23.112.173] (helo=book-mint)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ubt37-00057K-Fi; Mon, 13 May 2013 15:44:22 +0200
Content-Disposition: inline
In-Reply-To: <7vobcfvqu1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224135>

Hi,

On Sun, May 12, 2013 at 02:19:34PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Since ages we do not care about our program enough. Lets not treat them
> > as slaves anymore and say please.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> > Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> > Signed-off-by: Johan Herland <johan@herland.net>
> 
> So these were the ones present on the dev-day?

No this was just a random sample of the ones sitting at the same
beer garden table that this feature was implemented on.

> I actually would have expected, from the "please" title, the
> opposite, us saying "please" to the user, either once in a while in
> the advice messages we give to them, or perhaps in the en_POLITE
> locale ;-)

The en_POLITE is also a nice idea :-) We could split up the work on the
translations amongst all people joining a git meetup.

> >  .gitignore                       |  1 +
> >  Makefile                         |  1 +
> >  builtin.h                        |  1 +
> >  builtin/config.c                 | 23 ++-----------------
> >  builtin/please.c                 |  9 ++++++++
> >  cache.h                          |  1 +
> >  config.c                         | 23 +++++++++++++++++++
> >  contrib/completion/git-prompt.sh |  5 +++-
> >  git.c                            | 49 +++++++++++++++++++++++++++++++++++++++-
> 
> There is no test to protect this feature from future breakages?

In fact the whole testsuite should fail after the first 10 tests if you said
please right before running it. So since battery life is short and this
feature so important we did not bother to fix that. We already had
enough please complaints during intermediate commits and entering the
signed-off messages. It is really annoying, you should try this patch! ;-)
And it is especially unuseful when you are committing using git gui.

Cheers Heiko
