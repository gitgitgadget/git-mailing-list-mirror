From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: names using git config
Date: Wed, 24 Jun 2009 19:06:55 +0200
Message-ID: <vpqljnhv9w0.fsf@bauges.imag.fr>
References: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJVwL-0001Yj-PV
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 19:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbZFXRHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbZFXRHE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 13:07:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39102 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbZFXRHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 13:07:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n5OH6eGE016868
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Jun 2009 19:06:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MJVvz-0001xg-Eg; Wed, 24 Jun 2009 19:06:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MJVvz-0002SR-DG; Wed, 24 Jun 2009 19:06:55 +0200
In-Reply-To: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com> (Ryan's message of "Wed\, 24 Jun 2009 22\:28\:40 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Jun 2009 19:06:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n5OH6eGE016868
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1246468004.59005@3Q2D5wk+y9DBI6rkUzeCgQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122146>

Ryan <ryanphilips19@googlemail.com> writes:

> How do i select a Name which ends in a dot something like Ryan W.
> Philips in Git using  git config user.name
>
> Because when i do that "Ryan W. Philips" It just comes and Ryan W
> Philips in git log when i add a commit.

Can't reproduce here:

$ mkdir git
$ cd git/
$ git init
Initialized empty Git repository in /tmp/git/.git/
$ git config user.name 'Matthieu M. Moy'
$ cat .git/config 
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[user]
        name = Matthieu M. Moy
$ touch foo; git add foo
$ git commit -m "foo"
[master (root-commit) 6814174] foo
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git log
commit 681417491423260ad13c3fb59c28fc96a68bf4f9
Author: Matthieu M. Moy <Matthieu.Moy@imag.fr>
Date:   Wed Jun 24 19:05:43 2009 +0200

    foo
$ git version
git version 1.6.3.rc1.35.gabb3a
$ 

-- 
Matthieu
