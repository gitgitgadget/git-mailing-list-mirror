From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 19:57:13 +0100
Message-ID: <vpqoda43lva.fsf@bauges.imag.fr>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
	<20080225183413.GA15131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiXm-0002uB-Ge
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbYBYS6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbYBYS6j
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:58:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:61606 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbYBYS6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 13:58:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1PIvG2K018506
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2008 19:57:16 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JTiVl-000707-Gy; Mon, 25 Feb 2008 19:57:13 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JTiVl-0005c0-Eg; Mon, 25 Feb 2008 19:57:13 +0100
In-Reply-To: <20080225183413.GA15131@sigill.intra.peff.net> (Jeff King's message of "Mon\, 25 Feb 2008 13\:34\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 25 Feb 2008 19:57:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75046>

Jeff King <peff@peff.net> writes:

>   - there's more than _one_ maintainer for the repo; in fact, who you
>     email depends on what part of the code you are touching

Yes, but a sane default address to send to can be given by the
repository you make your original clone from.

The really nice thing with the way darcs does it is that it makes it
extremely easy for an occasional contribution. If the maintainer
configured his stuff correctly, it's really "darcs get; ... ; darcs
record; darcs send". git-send-email is nice, but harder to use for a
first-timer.

>   - this information could be shipped as part of the repo (i.e., under
>     version control like the rest of the project, as it changes with the
>     project)

True, but for the case of multiple maintainers, that would break
merging between maintainers on that particular part.

You can have a maintainer A advertizing for A@domain.com, and a
"sub-maintainer" B advertizing for B@domain.com. If A merges from B,
he doesn't want his advertized adress to become the one of B.

>   - this information can potentially be inferred from git shortlog
>     and/or blame; this addresses the problem of data becoming stale

Yes and no. git@vger.kernel.org won't appear anywhere in these for
example.

-- 
Matthieu
