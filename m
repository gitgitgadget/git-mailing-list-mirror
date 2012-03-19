From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 10:47:39 +0100
Message-ID: <vpqvcm0exc4.fsf@bauges.imag.fr>
References: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:47:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ZBx-0004fb-P8
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 10:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab2CSJrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 05:47:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50985 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758591Ab2CSJrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 05:47:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2J9gxvc016517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Mar 2012 10:42:59 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S9ZBk-0002xZ-AX; Mon, 19 Mar 2012 10:47:40 +0100
In-Reply-To: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
	(Piotr Krukowiecki's message of "Mon, 19 Mar 2012 10:44:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 19 Mar 2012 10:43:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2J9gxvc016517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332754984.88221@+rj33YuRJgchVYkDR3P/kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193421>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Hi,
>
> is there a way to configure --word-diff to be a more programming
> language friendly?

I often use this:

  git diff --color-words=.

It's rather bad on plain text, since it will try to diff within words,
but works well on source code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
