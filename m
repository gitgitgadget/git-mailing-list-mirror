From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 11:24:21 +0200
Message-ID: <vpqvc7oqh8a.fsf@grenoble-inp.fr>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
	<87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfeP-00007B-9s
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab3DOJYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:24:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48375 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198Ab3DOJYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:24:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3F9OKpK027923
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 11:24:20 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URfe9-0001Xe-I9; Mon, 15 Apr 2013 11:24:21 +0200
In-Reply-To: <87r4iccgdw.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 15 Apr 2013 11:06:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Apr 2013 11:24:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3F9OKpK027923
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366622661.42148@WlqRnjFt8GKxJkLZmarTxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221207>

Thomas Rast <trast@inf.ethz.ch> writes:

> My $0.02:

(BTW, feel free to edit the wiki. I've added a few bits from your
message there already).

> * Allow "git add -p" to use "git diff --color-words" to show hunks 
[...]
>   If neither one is possible my feeling is that it's one of the
>   hardest tasks on the list. (Not to discourcage anyone from trying,
>   but still.)

Yes, this was already inferable from the "See also the GSoC proposal"
statement and our discussions on GSoCs on this list ;-). It's not funny
if all projects are easy, but it's not a coincidence if this idea has
been there for a while without being implemented.

> * git pull --set-upstream
>
>   This is vaguely related to another itch that nobody has bothered to
>   fix: 'git fetch origin foo' should really update origin/foo.  This has
>   been discussed on the list a few times already:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/192252
>     http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165758
>
>   which by the way would be a *great* thing to fix, hint hint ;-)  and
>   since Peff already posted a POC patch in the first thread, it's
>   probably not that hard.  (Peff?)

My understanding is that this would be technically easy to fix, but a
migration plan is needed, which isn't easy for a one-shot, one-month
contribution.

I've added it to the wiki.

> * Allow git send-email --cc 'foo@example.com, bar@example.com' instead
>   of git send-email --cc foo@example.com --cc bar@example.com
>
>   That would be really nice.  Bonus points if it handles continuation
>   lines etc. correctly, so that it's even easier to paste.

Added to the wiki too.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
