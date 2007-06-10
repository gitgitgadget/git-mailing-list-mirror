From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 11 Jun 2007 00:07:24 +0200
Message-ID: <vpqwsybo44j.fsf@bauges.imag.fr>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	<46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	<20070610083754.GC4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVak-0002a3-Jn
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbXFJWIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbXFJWIV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:08:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:43623 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661AbXFJWIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:08:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l5AM7Oeq004332
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2007 00:07:24 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HxVZE-0008DV-CO; Mon, 11 Jun 2007 00:07:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HxVZE-0007mr-9u; Mon, 11 Jun 2007 00:07:24 +0200
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, Martin Langhoff <martin.langhoff@gmail.com>,  git@vger.kernel.org
In-Reply-To: <20070610083754.GC4084@efreet.light.src> (Jan Hudec's message of "Sun\, 10 Jun 2007 10\:37\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 11 Jun 2007 00:07:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49777>

Jan Hudec <bulb@ucw.cz> writes:

> A related thing is Bazaar's "Bundle Buggy". It tracks patch submission rather
> than bugs, but it is roughly what I meant by the "mailing list integration"
> above. It "reads" the mailing list, watching for anything labeled [PATCH] or
> [BUNDLE]

Indeed, the bundle buggy is inspired from the "Bug goo" developed
earlier for GNU Arch. This one was watching mails labeled with [BUG]
on the mailing list.

I found the idea really good. Indeed, as a user, when I find a bug in
a piece of software, I often hesitate between using the bugtracker (in
which case my bug is often mostly ignored), or reporting it on the
mailing list (in which case, a long discussion can follow, at the end
of which everybody thinks that someone else will fix the bug, and no
one actually does). With the bug goo, the bugtracker becomes the
mailing list, with all the advantage of it (discussions easy to
follow, threaded, ...), and a few additions, the biggest of which is
status tracking, in particular, the ability to list all unsolved bugs.

Unfortunately, as most of the GNU Arch stuff, it started with good
ideas, but was abandonned before it started being interesting :-\.

-- 
Matthieu
