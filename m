From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Approach for collaborative branches
Date: Sun, 06 Dec 2009 18:15:40 +0100
Message-ID: <vpqhbs4f2gz.fsf@bauges.imag.fr>
References: <4B1BE266.2000208@pickrell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Pickrell <gary@pickrell.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 18:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHKiD-0005Pe-1O
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 18:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933923AbZLFRPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 12:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933910AbZLFRPo
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 12:15:44 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41771 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933894AbZLFRPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 12:15:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nB6HDNDG017585
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Dec 2009 18:13:23 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NHKhw-0006Eh-LR; Sun, 06 Dec 2009 18:15:40 +0100
In-Reply-To: <4B1BE266.2000208@pickrell.com> (Gary Pickrell's message of "Sun\, 06 Dec 2009 08\:57\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Dec 2009 18:13:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB6HDNDG017585
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260724405.58119@6+jfbz3m7WxqWkTnkm1SHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134680>

Gary Pickrell <gary@pickrell.com> writes:

> 1) Clone the repository on Ubuntu
> 2) Made an Ubuntu branch
> 3) Made my changes to the code.  Added files...ect
> 4) Used git push origin Ubuntu to push the changes to the repository
>
> I'm unable to see my Ubuntu changes on my windows machine.  How should
> I proceed?

On the windows machine, you should do first

  git fetch

this will tell you about the new branch if you didn't fetch it
already. If it's called Ubuntu remotely, it's probably called
origin/Ubuntu on your local repository after doing a fetch. Therefore,
you can now do

  git merge origin/Ubuntu


Now, you probably also want your local branch to be named the same way
on both machines. One way to do that is to create a branch "foo" on
the repository, then on both sides, fetch it and do

  git checkout --track origin/foo

this will create a local branch foo, and tell git that further "pull"
should take their changes from origin/foo.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
