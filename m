From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git merge man page, upstream
Date: Tue, 23 Oct 2012 09:51:50 +0200
Message-ID: <vpqk3uhr5gp.fsf@grenoble-inp.fr>
References: <CAB9Jk9BT3F1_yvf7jQQyT72_EWskFS4bEgXCkmJs7uZOPhEK8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 09:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQZHb-0006IC-O7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 09:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab2JWHwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 03:52:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37680 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab2JWHwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 03:52:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q9N7jMqD009255
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2012 09:45:22 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TQZHC-0008Sx-S4; Tue, 23 Oct 2012 09:51:50 +0200
In-Reply-To: <CAB9Jk9BT3F1_yvf7jQQyT72_EWskFS4bEgXCkmJs7uZOPhEK8w@mail.gmail.com>
	(Angelo Borsotti's message of "Tue, 23 Oct 2012 09:40:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Oct 2012 09:45:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9N7jMqD009255
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1351583126.56931@7L4eO3zTExfU5Ng+9PRlnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208217>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hello,
>
> the git merge man page, OPTIONS, <commit> ... states:
>
>    "If no commit is given from the command line, and if
> merge.defaultToUpstream configuration variable is set, merge the
> remote tracking branches that the current branch is configured to use
> as its upstream. See also the configuration section of this manual
> page."
>
> Actually, in this case git merge merges the upstream branch, not the
> remote tracking branch.

It merges the upstream branch, which is a remote-tracking branch (notice
the - between remote and tracking, it's a branch that tracks a remote
branch, not a remote branch that tracks something).

I'll send a patch to fix that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
