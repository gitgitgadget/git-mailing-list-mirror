From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 18:35:31 +0200
Message-ID: <vpq381etoks.fsf@anie.imag.fr>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<vpqwpyqws53.fsf@anie.imag.fr> <558D67FD.2000607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:35:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8WbT-00005J-29
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbFZQfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:35:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54737 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbbFZQfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:35:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGZTC0022901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 18:35:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGZVJF013338;
	Fri, 26 Jun 2015 18:35:31 +0200
In-Reply-To: <558D67FD.2000607@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 26 Jun 2015 16:55:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Jun 2015 18:35:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QGZTC0022901
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435941331.20625@0KyzuWngvFTcMjfAcMrzxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272789>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I didn't like this example so much because (1) the code snippet is
> pretty trivial, and (2) the explanation afterwards is more of a general
> explanation of `git bisect` than a description of this particular
> example.

I agree that the explanations were redundant. I removed it.

> If you want to keep this example, how about making it a little bit more
> interesting? Perhaps use `git bisect terms` instead of new/old,

I now have both.

> and a little motivational text showing how the alternate names make
> the commands clearer?

Well, actually the motivational text would be essentially what was
already said.

> 1. I found it confusing that `git bisect terms` lists its arguments in
> the order `<term-new> <term-old>`. I think that listing them in
> "chronological" order would have been a lot more intuitive. But I expect
> this choice was made because `git bisect start` takes optional arguments
> in that order, so the inconsistency might be worse than the backwardness
> of this single command's arguments.

Yes, I think keeping the order of 'git bisect start' is good. Junio also
mentionned alphabetic order (bad -> good, new -> old).

> 2. When I was describing "old/new", I kept wishing that I could type
> "before/after" instead, because those terms seemed to agree better with
> the prose description of what "old/new" mean. I wonder if "before/after"
> might be better names for commits determined to be before/after the
> change being sought?

I like old/new essentially because they are very short. I would keep the
code as-is for now, but it's very easy to add a before/after couple of
terms later if needed. If others think before/after are better, it's
still time to change it.

> Oh and I just noticed that `git bisect terms` is missing from the
> synopsis at the top of the man page.

Fixed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
