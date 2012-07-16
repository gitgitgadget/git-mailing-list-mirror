From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 18:16:40 +0200
Message-ID: <vpqhat7wujb.fsf@bauges.imag.fr>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 16 18:17:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqnyi-0007Ad-0l
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab2GPQQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:16:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48187 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab2GPQQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 12:16:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GGEqIF022138
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 18:14:52 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SqnyT-0007mL-Dh; Mon, 16 Jul 2012 18:16:41 +0200
In-Reply-To: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
	(mhagger@alum.mit.edu's message of "Sat, 14 Jul 2012 08:59:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 18:14:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GGEqIF022138
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343060093.88401@cYqIYUAO0QXgnAU65SDLHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201526>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
> can be used to send notification emails describing pushes into a git
> repository.  This script is derived from
> contrib/hooks/post-receive-mail, but has many differences, including:
>
> * One email per commit [1].

It's cool to have it, but it would be nice to allow the "one email per
push" mode too. I have co-workers who already complain about the number
of emails sent by the post-receive-mail script. I can't imagine their
reaction if I set up a one-email-per-commit hook ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
