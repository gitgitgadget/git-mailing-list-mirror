From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Usability question
Date: Thu, 17 Sep 2009 12:41:06 +0200
Message-ID: <vpqy6odhn0d.fsf@bauges.imag.fr>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rob Barrett <barrettboy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 12:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoEQR-0004GV-Mg
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 12:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZIQKlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 06:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZIQKlJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 06:41:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55705 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbZIQKlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 06:41:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8HAcFdt005891
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Sep 2009 12:38:15 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MoEQE-00018e-Ex; Thu, 17 Sep 2009 12:41:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MoEQE-0000Jp-Dd; Thu, 17 Sep 2009 12:41:06 +0200
In-Reply-To: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com> (Rob Barrett's message of "Thu\, 17 Sep 2009 20\:01\:00 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2009 12:38:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8HAcFdt005891
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253788696.08548@lqb9LuK1iyVUVawFcHn9Xw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128741>

Rob Barrett <barrettboy@gmail.com> writes:

> My questions:
> 1. What is the distinction that makes the 10% special enough to get
> non-prefixed options?

Prefixed and non-prefixed is what people usually call respectively
"options" and "subcommands". To me, the distinction is needed:

Options are flags that modify the behavior of a git command. For
example, "git reset" and "git reset --hard" do something similar, but
"git svn rebase" and "git svn dcommit" do something really, totally
different. It's not about doing the same thing in a different way,
it's really about different actions.

Subcommands are closer to commands than they are to options. The
reason to group several subcommands into one command is mostly to
reduce the number of commands, but for example, it could have been
decided to replace "git svn dcommit" by "git svn-dcommit" (but then
"git help" would have been really really scarry).

> 2. Is it worthwhile? Wouldn't it be better if to shoot for more
> consistency / less complexity?

Well, if you want to get rid of subcommands, why not get rid of
commands, too?

git --commit
git --status
git --svn --rebase

I find the distinction between commands, subcommands and options
really helpfull.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
