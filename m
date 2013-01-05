From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 00/10] push: switch default from "matching" to "simple"
Date: Sat, 05 Jan 2013 20:39:55 +0100
Message-ID: <vpqpq1ja06s.fsf@grenoble-inp.fr>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 20:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrZbS-00023u-Fd
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 20:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab3AETkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 14:40:04 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38114 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832Ab3AETkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 14:40:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r05JSGdE029800
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 5 Jan 2013 20:28:16 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TrZb2-0005rN-7F; Sat, 05 Jan 2013 20:39:56 +0100
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com> (Junio C.
	Hamano's message of "Fri, 4 Jan 2013 22:52:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 05 Jan 2013 20:28:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r05JSGdE029800
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1358018897.86777@VsqewqRFGVNxoeQ9l16n3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212707>

Junio C Hamano <gitster@pobox.com> writes:

> We promised to change the behaviour of lazy "git push [there]" that
> does not say what to push on the command line from "matching" to
> "simple" in Git 2.0.  Even though the top-level RelNotes symbolic
> link points at 1.8.2, we can change our mind to tag 2.0 at the end
> of this cycle.

I had a quick look at the series, it sounds straightforward and correct.
Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
