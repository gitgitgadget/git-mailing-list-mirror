From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Documentation problems
Date: Sun, 20 Sep 2009 20:24:54 +0200
Message-ID: <vpqvdjdzd6x.fsf@bauges.imag.fr>
References: <4AB66D4C.70301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 20:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpR5v-0002T1-N4
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 20:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbZITSY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbZITSY6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 14:24:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35194 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782AbZITSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 14:24:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8KILr41008789
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Sep 2009 20:21:54 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MpR5i-0004dC-Hr; Sun, 20 Sep 2009 20:24:54 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MpR5i-00034f-GU; Sun, 20 Sep 2009 20:24:54 +0200
In-Reply-To: <4AB66D4C.70301@gmail.com> (Bruce Korb's message of "Sun\, 20 Sep 2009 10\:58\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 20 Sep 2009 20:21:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8KILr41008789
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254075715.83783@7jMHBscWuA5x4xxZfdCSRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128853>

Bruce Korb <bruce.korb@gmail.com> writes:

> Hi,
>
> I'm trying to figure out what a ``tree-ish''.
> I cannot seem to use many of the commands until I know.
>
> <tree-ish>
>     Indicates a tree, commit or tag object name. A command that takes a
>     <tree-ish> argument ultimately wants to operate on a <tree> object
>     but automatically dereferences <commit> and <tag> objects that point at a <tree>.
>
> I need a translation.  :(  Thank you.  Regards, Bruce

tree = directory (with its content).

For example, the last commit in the current branch is a Git object of
type "commit", which contains mostly a log message, a few headers, and
a pointer to the tree object corresponding to the content of the
directory in which you made the commit (modulo what you excluded from
the commit of course). Therefore, the name of this commit, although
not really a tree, is a tree-ish in that it talks about one and only
one tree. You could name it HEAD, a sha1sum (like
5a2abc12d64a5e00daa6aebbb673715f365a564a), the name of the branch
(like "master"), ...

> P.S. I have a SuSE installation with everything relating to GIT installed.
> The man pages reference commands like, "git-ls-tree --name-only" except
> that there isn't any such command.  Unless you reverse engineer the
> implementation of "git", discover the /usr/lib/git directory and add it
> to your path.  That hassle is rather inconvenient.  More hints about
> where the git commands get squirreled away would be useful.  Thank
> you.

Just type "git ls-tree --name-only". git-ls-tree is the old way to
refer to the command name. Normally, any reference to dashed names
should have been removed from the documentation by now (so most likely
you see it in your distro because it's an old enough version,
otherwise, it's a bug in the doc).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
