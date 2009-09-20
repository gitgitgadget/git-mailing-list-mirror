From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Documentation problems
Date: Sun, 20 Sep 2009 20:45:00 +0200
Message-ID: <vpqeiq1zc9f.fsf@bauges.imag.fr>
References: <4AB66D4C.70301@gmail.com> <vpqvdjdzd6x.fsf@bauges.imag.fr>
	<4AB67665.10402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 20:45:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpRPN-0007i7-7P
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 20:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbZITSpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 14:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbZITSpC
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 14:45:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35337 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975AbZITSpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 14:45:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8KIecUJ013792
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Sep 2009 20:40:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MpRPA-00050y-9c; Sun, 20 Sep 2009 20:45:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MpRPA-0003B3-8A; Sun, 20 Sep 2009 20:45:00 +0200
In-Reply-To: <4AB67665.10402@gmail.com> (Bruce Korb's message of "Sun\, 20 Sep 2009 11\:37\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 20 Sep 2009 20:40:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8KIecUJ013792
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254076838.94447@yZcZoyXfbpLtMkVzK3JW0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128855>

Bruce Korb <bruce.korb@gmail.com> writes:

> Since I haven't created any any branches (to my knowledge), it seems
> that "master" is the magic branch name.

I wouldn't say "magic", but surely the default ;-).

> My goal was just to get a list of managed files.

Just cd /where/your/repo/is
git ls-files

> Is "master" going to remain my "HEAD" now?

Yes.

>> git-ls-tree is the old way to
>> refer to the command name. Normally, any reference to dashed names
>> should have been removed from the documentation by now (so most likely
>> you see it in your distro because it's an old enough version,
>> otherwise, it's a bug in the doc).
>
> $ git --version
> git version 1.6.0.2
>
> I guess the man pages and installation were out of sync for that release.

Well, actually, a few more instances of dashed commands were removed
more recently. That said, to get the doc for "git foo", you still have
to type "man git-foo" (or git foo --help indeed), but that's because
"man git foo" means something different to man.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
