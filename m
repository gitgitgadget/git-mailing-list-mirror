From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: RFC for 1.7: Do not checkout -b master origin/master on clone
Date: Mon, 17 Aug 2009 19:45:05 +0200
Message-ID: <vpqhbw6pc66.fsf@bauges.imag.fr>
References: <4A818B90.9050206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md6Ko-0005WX-9e
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbZHQRtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbZHQRtU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:49:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:54580 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbZHQRtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:49:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7HHj55D019054
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Aug 2009 19:45:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Md6GX-00039H-If; Mon, 17 Aug 2009 19:45:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Md6GX-0004XL-HN; Mon, 17 Aug 2009 19:45:05 +0200
In-Reply-To: <4A818B90.9050206@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\, 11 Aug 2009 17\:17\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 17 Aug 2009 19:45:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126246>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> - git clone does not set up any local branches at all
> - git svn fetch does not set up any local branches at all

If you don't set up a local branch, it means either

- You start with a detached HEAD, or
- You start with no working tree at all.

In both cases, you introduce more trouble for the beginner, just more
notions to learn before being able to do the very first step.

And you also break a good property of Git: in Git, you can use the
"one repo per branch" or the "multiple branches in a repository" the
way you want.

Personnally, I rarely have more than one branch for me (but I
appreciate very much having one branch per developer). And this way, I
can just forget that Git has multiple branches in a repo. When I want
to work on a project, I clone it, I hack, I commit, and then I
send the result (git push, git svn dcommit, git send-email, depending
on the project). In this workflow, I almost never have to use "git
branch", "git checkout", "git merge", it works, and Git does the right
thing for me.

-- 
Matthieu
