From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Sun, 15 Feb 2009 20:15:05 +0100
Message-ID: <87k57rh5qe.fsf@wine.dyndns.org>
References: <18834.27724.991388.339214@hungover.brentg.com>
	<87hc31kzrb.fsf@wine.dyndns.org>
	<e38bce640902120738h7b9bb75o42e1524cbfd95169@mail.gmail.com>
	<18836.22386.987021.484807@hungover.brentg.com>
	<87ocx3hbkq.fsf@wine.dyndns.org>
	<e38bce640902151035s18e374e6j25e3887728722700@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmTs-0000ec-7a
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbZBOTPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbZBOTPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:15:16 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59549 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbZBOTPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:15:15 -0500
Received: from adsl-84-226-2-29.adslplus.ch ([84.226.2.29] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LYmSK-00077L-0X; Sun, 15 Feb 2009 13:15:14 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 8727F1E7203; Sun, 15 Feb 2009 20:15:05 +0100 (CET)
In-Reply-To: <e38bce640902151035s18e374e6j25e3887728722700@mail.gmail.com>
	(Brent Goodrick's message of "Sun, 15 Feb 2009 10:35:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110034>

Brent Goodrick <bgoodr@gmail.com> writes:

> Ok, now that makes sense to me. Part of the problem here is that there
> is no statement in the user manual about git.el's intent to hide the
> index. Perhaps something to the effect of "If you are new to using
> Emacs but not new to git, then you need to know that bla bla ...".
> Otherwise, I think users may get tripped up by this as I was. Was
> there a manual in the works for git.el or did I just miss it in recent
> checkins?

There's no manual, and I'm not going to write one, I suck at writing
documentation. If you would like to contribute one it would certainly be
welcome.

> However, the *git-status* buffer does properly reflect the two added
> files by their state being changed to "Added". Since you may have a
> ton of files that are being added, it probably doesn't make a whole
> lot of sense to dump a long message into the minibuffer with all of
> those names.  By the same token, it doesn't make sense to emit one
> message per file either. Instead, would you be willing to change that
> message to just state "Added n files" where "n" is the number of files
> added?

That's exactly what git-success-message already does. The only problem
is that the list isn't always preserved properly (and that's only a
cosmetic bug, the operations get carried out correctly).

-- 
Alexandre Julliard
julliard@winehq.org
