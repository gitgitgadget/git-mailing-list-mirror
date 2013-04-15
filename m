From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 18:17:23 +0200
Message-ID: <vpqmwszlqek.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<7vbo9g15po.fsf@alter.siamese.dyndns.org>
	<vpqbo9gqcvl.fsf@grenoble-inp.fr>
	<CALkWK0nymT=wTnHpTE=uBsqoHxACFb4gStU0SGE79bc7uBVKXQ@mail.gmail.com>
	<vpqbo9foqld.fsf@grenoble-inp.fr>
	<CALkWK0mLxZCr-QK2tkR9xEsocj6GAM7FZOSeiJ9SnEusfnv88g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URm7I-0006sr-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab3DOQSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:18:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56144 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab3DOQSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:18:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3FGHMp0009462
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 18:17:22 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URm5s-0003GB-7n; Mon, 15 Apr 2013 18:17:24 +0200
In-Reply-To: <CALkWK0mLxZCr-QK2tkR9xEsocj6GAM7FZOSeiJ9SnEusfnv88g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 20:01:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Apr 2013 18:17:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FGHMp0009462
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366647443.49833@XViM3H5uF8RJYMS8pVQiCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221245>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> I disagree. A configuration option is something you set once, and then
>> forget about. A command, or a command-line option, is something you
>> explicitely add when you need it.
>
> You're making it out to be a much bigger difference than it actually
> is.  Users will simply alias pull to 'pull --autostash' (a lot of them
> already alias it to pull --ff-only, and I'm going to fix this soon).

No, they don't.  Git forbids redefining commands with aliases. They may
have an alias like "git pullauto" or so, but not "git pull".

> If your criticism were that git status doesn't show stash state, I
> agree with you.

There's not much we can do about it now, as Git cannot guess whether a
stash is to be re-applied later or just kept "in case". My main use of
"git stash" is "I want a reset --hard, but stash is safer", I wouldn't
want "status" to remind me when I have a stash because it is almost
always the case.

Showing the "autostash" status in "git status" would make sense OTOH,
but I agree that it's another topic.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
