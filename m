From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [DONOTAPPLY PATCH 2/3] setup: warn about implicit worktree with $GIT_DIR
Date: Wed, 27 Mar 2013 09:24:28 +0100
Message-ID: <vpq38vh1c8z.fsf@grenoble-inp.fr>
References: <20130326200851.GA22080@sigill.intra.peff.net>
	<20130326201208.GB22522@sigill.intra.peff.net>
	<20130326202142.GL1414@google.com>
	<20130326202722.GA22769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 09:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKlfk-0002KS-OH
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 09:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab3C0IY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 04:24:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47765 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab3C0IY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 04:24:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2R8OS6E029971
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Mar 2013 09:24:28 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UKlen-000848-0s; Wed, 27 Mar 2013 09:24:29 +0100
In-Reply-To: <20130326202722.GA22769@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 26 Mar 2013 16:27:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Mar 2013 09:24:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2R8OS6E029971
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1364977473.84533@eVC+jXUEOItinPsbdD0jRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219242>

Jeff King <peff@peff.net> writes:

> I probably shouldn't have included this middle patch at all, because
> the interesting thing is what happens when we do turn it off.

Actually, I think the warning is the most important part. With the
warning enabled, people should notice they are doing something
potentially wrong and dangerous, so the warning essentially fixes the
issue in the short term.

I also think that changing the default behavior later makes sense (but I
agree that replacing "in Git 2.0" with "in a future version of Git" is
better, there's no urgency for this change and people start looking
forward 2.0).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
