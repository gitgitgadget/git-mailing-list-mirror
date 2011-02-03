From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] Tracking empty directories
Date: Thu, 03 Feb 2011 11:07:50 +0100
Message-ID: <vpqbp2tqvm1.fsf@bauges.imag.fr>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com>
	<4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
	<201102021921.53755.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 11:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkw6e-0001os-2w
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 11:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab1BCKH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 05:07:58 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46475 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755397Ab1BCKH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 05:07:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p13A7o17001107
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 3 Feb 2011 11:07:50 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pkw6R-00081Q-8i; Thu, 03 Feb 2011 11:07:51 +0100
In-Reply-To: <201102021921.53755.wjl@icecavern.net> (Wesley J. Landaker's message of "Wed\, 2 Feb 2011 19\:21\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Feb 2011 11:07:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p13A7o17001107
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297332470.92831@i3QzRiKv1w0OZNA+oYvCJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165966>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

>   2) One of git's best strengths is that it's so easy to interact with other 
> SCM software, primarily because git's features are a SUPERSET of other SCMs. 
> However, almost every other SCM can track empty directories, except
> git, 
[...]
>   4) On many projects I work on with a huge number of people, the workflow 
> is to create a very, very intricate directory hierarchy skeleton, so that 
> it's clear to everyone where everything goes and how it is organized, even 
> before any work is started.

Just adding my 2 cents: my first clash with Git's non-management of
empty directories was a combination of both. A colleague created an
SVN project with several empty directories, along the lines of "Here
it is. Now, put your stuff in there".

git-svn didn't import these empty directories (I think I actually
could have worked around this with "git svn mkdirs"). Adding
.gitignore files would have been a really dirty workaround since I
didn't want to put Git stuff in the SVN repo.

I don't think my colleague did anything wrong, I did want to use Git,
and that was still frustrating to see such a simple scenario not
managed by my favorite tool.

So, yes, I can clearly leave without empty directory support, but that
would be a nice addition to Git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
