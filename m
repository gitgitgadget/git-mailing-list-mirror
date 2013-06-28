From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 28 Jun 2013 08:34:53 +0200
Message-ID: <vpq1u7magky.fsf@anie.imag.fr>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130627201032.GF9999@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Jun 28 08:35:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsSHP-0007vZ-9m
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 08:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab3F1Gfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 02:35:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41487 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab3F1Gfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 02:35:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5S6Yq7d020851
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Jun 2013 08:34:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UsSGj-0004rb-Dq; Fri, 28 Jun 2013 08:34:53 +0200
In-Reply-To: <20130627201032.GF9999@odin.tremily.us> (W. Trevor King's message
	of "Thu, 27 Jun 2013 16:10:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 Jun 2013 08:34:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229176>

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
>> Because letting a trivial merge automatically handled by Git is so
>> easy with "git pull", a person who is new to Git may not realize
>> that the project s/he is interacting with may prefer "rebase"
>> workflow.
>
> Or they may not even realize that they've just merged an unrelated
> branch at all, dragging in a thousand unrelated commits which they
> accidentally push to a central repository without looking,
> contaminating future branches based on the central repostitory without
> drastic rebase surgery ;).  I just saw one of these earlier this week.

I don't understand how the change would solve this. If "pull" would drag
a lot of commits in the current branch, the "rebase" will rebase the
current branch on a totally different history, and pushing the result
would be equally bad.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
