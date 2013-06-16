From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Sun, 16 Jun 2013 20:48:41 +0200
Message-ID: <vpqvc5dj3hy.fsf@anie.imag.fr>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 20:49:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoI0i-0008Sz-N6
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 20:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab3FPSsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 14:48:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37682 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab3FPSsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 14:48:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5GImdWf021204
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 20:48:39 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoI0H-0002vo-Pr; Sun, 16 Jun 2013 20:48:41 +0200
In-Reply-To: <1371377188-18938-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 16 Jun 2013 15:36:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 16 Jun 2013 20:48:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228022>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +* `current` - push the refspec "$HEAD".  HEAD is resolved early to a
> +  branch name (referred to as $HEAD).  In other words, push the
> +  current branch to update a branch with the same name on the pushing
> +  side.

I'd put it the other way around: the intuitive explanation first, and
the technical one after. For people not totally familiar with Git, the
first part does not make much sense (and when I learn a new tool, I
really don't like when the doc assumes I already know too much about
it).

Also, this $HEAD Vs HEAD doesn't seem very clear to me. I don't have a
really good proposal for a better wording, but maybe replacing $HEAD
with $branch would make a bit more sense, as having $HEAD != HEAD is
weird.

> +* `simple` - in central workflows, behaves like `upstream`, except
> +  that it errors out unless branch.$HEAD.merge is equal to $HEAD.

I'd reverse the sentense too. In your wording, I get the feeling that
erroring out is the normal flow, and pushing is the exception
("unless").

"... except that it errors out if branch.$HEAD.merge is not equal to
$HEAD." ?

> +  single command.  Dangerous, and inappropriate unless you are the
> +  only person updating your push destination.

Here also, I'd have said "Dangerous, and inappropriate if you are
not ...".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
