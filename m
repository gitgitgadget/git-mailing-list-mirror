From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 20:54:17 +0200
Message-ID: <vpqfxfund0m.fsf@bauges.imag.fr>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
	<alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
	<40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyW2M-0000HW-5X
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbZD0S6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbZD0S6g
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:58:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:63533 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbZD0S6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 14:58:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3RIsIEo012146
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 20:54:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LyVy5-0006pA-Vw; Mon, 27 Apr 2009 20:54:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LyVy5-0002dw-Ue; Mon, 27 Apr 2009 20:54:17 +0200
In-Reply-To: <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com> (Erik Faye-Lund's message of "Mon\, 27 Apr 2009 20\:42\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 27 Apr 2009 20:54:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117707>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> $ git grep '('
> fatal: unmatched parenthesis

try this: git grep -e '('

The idea is that you can do things like

git grep -e foo --and '(' -e bar --or -e boz ')'

to build a boolean expression of expressions.

-- 
Matthieu
