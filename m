From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] stage: remove unused, unreferenced builtin-alias
Date: Mon, 24 Jun 2013 20:27:14 +0200
Message-ID: <vpqobavnz3x.fsf@anie.imag.fr>
References: <1372097546-27721-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBUA-0002TN-6v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab3FXS10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:27:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36454 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288Ab3FXS10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:27:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5OIRCeL029678
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 20:27:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UrBTv-0002Td-26; Mon, 24 Jun 2013 20:27:15 +0200
In-Reply-To: <1372097546-27721-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 24 Jun 2013 23:42:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jun 2013 20:27:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228892>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 11920d2 (Add a built-in alias for 'stage' to the 'add' command,
> 2008-12-01) added a the 'git stage' command which simply calls
> cmd_add().  Since then, no references to it have been made anywhere on
> the internet; 

$ git sta<TAB>
stage    stash    status 

So the command is discoverable.

Also, googling a bit gives me this:

  http://git-scm.com/docs/git-stage

It's not particularly visible, but it's discoverable.

> there is no evidence that anyone even knows about its existence.

I did :-\.

I can very well live without it, but the few people like me who
sometimes run "git stage" would be surprised if it stopped working
without a deprecation period.

(In my case, I read the thread so it's OK, but there may be others)

>  Documentation/git-stage.txt | 23 -----------------------
>  Makefile                    |  3 +--
>  git.c                       |  1 -

If you go for it, there's also the completion script:

_git_stage ()
{
	_git_add
}

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
