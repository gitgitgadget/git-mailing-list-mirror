From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 08 Dec 2009 15:39:53 +0100
Message-ID: <vpqfx7l1qdi.fsf@bauges.imag.fr>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
	<4B192701.4000308@drmicha.warpmail.net>
	<vpqfx7qocwl.fsf@bauges.imag.fr>
	<7vws12r5v2.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
	<20091205062708.6117@nanako3.lavabit.com>
	<7vd42t6f9i.fsf@alter.siamese.dyndns.org>
	<20091208121314.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1HZ-00081i-Db
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbZLHOnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbZLHOnE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:43:04 -0500
Received: from imag.imag.fr ([129.88.30.1]:49640 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbZLHOnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:43:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nB8EdslI018471
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Dec 2009 15:39:54 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NI1EI-0005Yb-6z; Tue, 08 Dec 2009 15:39:54 +0100
In-Reply-To: <20091208121314.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Tue\, 08 Dec 2009 12\:13\:14 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 08 Dec 2009 15:39:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134882>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Teach a new option, --autosquash, to the interactive rebase.
> When the commit log message begins with "!fixup ...", and there
> is a commit whose title begins with the same ...

You should be clearer than "title" here. My understanding is that this
is the _message_ (man git-commit talks about log message or commit
message).

It's a detail, but I could make sense to allow putting something other
than the commit message here, like an object name:

git commit -m "fixup! 66eb61bd"
git commit -m "fixup! HEAD^^"

The last one is a bit tricky, since it should mean "HEAD^^" right
before I did the commit.


All that said, I probably won't be a user of that particular feature
(although I love the new "fixup" command for rebase -i), so don't see
any complaint here, just food for thoughts ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
