From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Tue, 12 Mar 2013 14:58:44 +0100
Message-ID: <vpqhakgiusr.fsf@grenoble-inp.fr>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
	<1362786889-28688-2-git-send-email-gitster@pobox.com>
	<vpqmwubgsqy.fsf@grenoble-inp.fr>
	<20130312112840.GA13186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 14:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFPjv-0000p5-RK
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab3CLN7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 09:59:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37428 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab3CLN7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:59:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2CDwhoG031969
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Mar 2013 14:58:43 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UFPj3-0004is-5b; Tue, 12 Mar 2013 14:58:45 +0100
In-Reply-To: <20130312112840.GA13186@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Mar 2013 07:28:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Mar 2013 14:58:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2CDwhoG031969
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363701529.28386@wDGDPRu3pIjlCaIKDCcu5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217964>

Jeff King <peff@peff.net> writes:

> PS I wonder how others are finding the warning? I'm finding it slightly
>    annoying. Perhaps I just haven't retrained my fingers yet. But one
>    problem with that retraining is that I type "git add -u" from the
>    root _most_ of the time, and it just works. But occasionally, I get
>    the "hey, do not do that" warning, because I'm in a subdir, even
>    though I would be happy to have the full-tree behavior.

Same here. Not terribly disturbing, but I did get the warning
occasionally, even though I'm the author of the patch introducing
it ;-).

> I guess we already rejected the idea of being able to shut off the
> warning and just get the new behavior, in favor of having people
> specify it manually each time?

Somehow, but we may find a way to do so, as long as it temporary (i.e.
something that will have no effect after the transition period), and
that is is crystal clear that it's temporary.

All proposals up to now were rejected because of the risk of confusing
users (either shutting the warning blindly, or letting people think they
could keep the current behavior after Git 2.0).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
