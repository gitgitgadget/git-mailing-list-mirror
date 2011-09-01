From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git 'new' alias
Date: Thu, 01 Sep 2011 21:40:28 +0200
Message-ID: <vpqei00m4pf.fsf@bauges.imag.fr>
References: <CACnwZYfo2E0SFfFrYzUktAZYwqgyX_J4KgFQD5kqXToGmip3Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 21:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzD7x-0008Sh-4p
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 21:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab1IATkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 15:40:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39900 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757840Ab1IATke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 15:40:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p81JdiRI021327
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 21:39:44 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QzD7k-0005FJ-U5; Thu, 01 Sep 2011 21:40:28 +0200
In-Reply-To: <CACnwZYfo2E0SFfFrYzUktAZYwqgyX_J4KgFQD5kqXToGmip3Lg@mail.gmail.com>
	(Thiago Farina's message of "Thu, 1 Sep 2011 16:30:16 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 21:39:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81JdiRI021327
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315510787.67277@YO7+UZbn01cJkxIUWY+d6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180568>

Thiago Farina <tfransosi@gmail.com> writes:

> Hi,
>
> Could we change the 'new' alias in the wiki page,
>
> from:
> new = !sh -c 'git log $1@{1}..$1@{0} "$@"'
>
> to:
> new = !git log $1@{1}..$1@{0} "$@"
>
> ?

Go on. I think I'm the one who added it, and I didn't know $1 and $@
would work without "sh -c", but I guess my version results in calling
stg like sh -c "sh -c 'git log ...'" which is a bit overkill ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
