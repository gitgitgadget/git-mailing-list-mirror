From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 16:40:06 +0200
Message-ID: <vpqzlcgxid5.fsf@bauges.imag.fr>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	<51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	<alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEP1T-0002R2-Fc
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbZFJOmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 10:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757114AbZFJOmh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:42:37 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:51396 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641AbZFJOmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 10:42:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n5AEe7aW029131;
	Wed, 10 Jun 2009 16:40:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MEOyE-00013u-Uy; Wed, 10 Jun 2009 16:40:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MEOyE-0004E0-Te; Wed, 10 Jun 2009 16:40:06 +0200
In-Reply-To: <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain> (Linus Torvalds's message of "Tue\, 9 Jun 2009 15\:40\:35 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 10 Jun 2009 16:40:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121280>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I would not object to
>
>  - old behavior: revert the commit by creating an "anti-commit":
>
> 	git revert <cmit-name>
>
>  - new extension: revert the state of the working tree to the HEAD:
>
> 	git revert [--] pathspec
>
> which would kind of match the semantics of "git checkout" does.

That's subjective, but I would find this more misleading than the
current behavior. To me, that would let beginners think that both
commands do similar things, and then "why the hell does git revert
HEAD^^ create a commit while git revert -- foo.c doesn't???"-kind of
questions.

my 2 cents,

-- 
Matthieu
