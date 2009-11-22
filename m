From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] user-manual: Document that "git merge" doesn't like uncommited changes.
Date: Sun, 22 Nov 2009 23:18:53 +0100
Message-ID: <vpqljhyi4oi.fsf@bauges.imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
	<1258732767-12741-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vk4xlvtib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 23:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCKob-00022r-2H
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 23:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZKVWVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbZKVWVm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 17:21:42 -0500
Received: from imag.imag.fr ([129.88.30.1]:52254 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbZKVWVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 17:21:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAMMIr50021796
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Nov 2009 23:18:53 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NCKlh-0004Lt-9J; Sun, 22 Nov 2009 23:18:53 +0100
In-Reply-To: <7vk4xlvtib.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 20 Nov 2009 12\:19\:40 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 22 Nov 2009 23:18:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133459>

Junio C Hamano <gitster@pobox.com> writes:

> "but not the working tree itself" is not incorrect per-se, but misses the
> point.  How about...
>
> 	A merge is made by combining the changes made in "branchname" and
>         the changes made up to the latest commit in your current branch
>         since their histories forke.  The work tree is overwritten by the
>         result of the merge when this combining is done cleanly, or
>         overwritten by a half-merged results when this combining results
>         in conflicts.  Therefore, ...

Maybe better. OTOH, it reveals another problem: Your "the work tree is
overwritten by ..." tend to imply that the result is not commited,
while the normal case is indeed to create a merge commit
automatically.

In its current state, the doc jumps to conflict resolution and how to
commit after resolving them without saying "oh, normally this is over,
Git did the commit for you". And for people comming from SVN, thinking
"merge = update", it's not obvious at all that a merge should result
in a commit.

So, I'll resend with one more paragraph talking about autocommit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
