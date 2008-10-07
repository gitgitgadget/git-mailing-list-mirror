From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git pager woes
Date: Tue, 07 Oct 2008 16:30:41 +0200
Message-ID: <vpqbpxwxysu.fsf@bauges.imag.fr>
References: <3aaafc130810070643m352ea2ufa1069dc149f0d9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.R. Mauro" <jrm8005@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDqO-00057M-Dh
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbYJGOpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbYJGOpp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:45:45 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:59406 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755219AbYJGOpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:45:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m97EhWLT020503;
	Tue, 7 Oct 2008 16:43:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KnDaD-0002sX-TT; Tue, 07 Oct 2008 16:30:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KnDaD-00061V-R3; Tue, 07 Oct 2008 16:30:41 +0200
In-Reply-To: <3aaafc130810070643m352ea2ufa1069dc149f0d9e@mail.gmail.com> (J. R. Mauro's message of "Tue\, 7 Oct 2008 09\:43\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 07 Oct 2008 16:43:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97712>

"J.R. Mauro" <jrm8005@gmail.com> writes:

> Git doesn't set special options to it's pager command if the LESS
> environment variable is set.

Yes, this is by design: if you customized less, git obeys the
configuration you've set. Otherwise, it takes a default wich is more
appropriate to git that what "less" does without $LESS set.

That policy isn't perfect, but I think any other would be worse: I
wouldn'l like git to change my configuration if I did set $LESS
myself, and I also prefer git's default to LESS default when it comes
to paging git commands (but I like less's default for other uses, for
example, I like the man page to disapear when I close it).

-- 
Matthieu
