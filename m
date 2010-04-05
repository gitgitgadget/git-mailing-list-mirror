From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Mysterious junk in file.... "not commited yet"
Date: Mon, 05 Apr 2010 21:24:59 +0200
Message-ID: <vpq8w91r9bo.fsf@bauges.imag.fr>
References: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com>
	<o2n32541b131004051152ie6c82b3wdab0f38a9e657943@mail.gmail.com>
	<p2y26ae428a1004051203jbb7c838eh8de0cb5f6ae1dcb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:25:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrvF-0005rL-S7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab0DETZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:25:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44940 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab0DETZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:25:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o35JKX0M010864
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Apr 2010 21:20:33 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Nyruu-0006kw-7H; Mon, 05 Apr 2010 21:25:00 +0200
In-Reply-To: <p2y26ae428a1004051203jbb7c838eh8de0cb5f6ae1dcb1@mail.gmail.com> (Howard Miller's message of "Mon\, 5 Apr 2010 20\:03\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 Apr 2010 21:20:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o35JKX0M010864
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1271100036.28911@T8x+qagE1Yn6Oq+bYiIfKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144053>

Howard Miller <howard@e-learndesign.co.uk> writes:

> Hmmm... fixed. I've never even heard of 'git add' before.

Hmm, maybe it's time to read the manual, then ;-).

> Why is this different to plain old 'checkout' without the HEAD?

Read about the "index" of Git, aka "staging area". It's where Git (and
you) prepare commit, and "git diff" shows you the diff against it.
Plain "git checkout" will read from the index, while "git checkout
HEAD" takes the last commited version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
