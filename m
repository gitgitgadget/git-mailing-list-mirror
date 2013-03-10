From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Sun, 10 Mar 2013 16:49:09 +0100
Message-ID: <vpqmwubgsqy.fsf@grenoble-inp.fr>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
	<1362786889-28688-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 16:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEiVW-0004sK-7R
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 16:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab3CJPt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 11:49:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41095 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab3CJPt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 11:49:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2AFn8eW008537
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Mar 2013 16:49:08 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UEiUo-0005Ms-6e; Sun, 10 Mar 2013 16:49:10 +0100
In-Reply-To: <1362786889-28688-2-git-send-email-gitster@pobox.com> (Junio C.
	Hamano's message of "Fri, 8 Mar 2013 15:54:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Mar 2013 16:49:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2AFn8eW008537
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363535352.96397@WseKHi9HL4ecmjetX1Plig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217808>

Junio C Hamano <gitster@pobox.com> writes:

> As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
> pathspec, 2013-01-28), "git add -u/-A" that is run without pathspec
> in a subdirectory will stop working sometime before Git 2.0, to wean
> users off of the old default, in preparation for adopting the new
> default in Git 2.0.

I originally thought this step was necessary, but I changed my mind. The
warning is big enough and doesn't need to be turned into an error.

If this step is applied, it should be applied at 2.0, not before, as
this is the big incompatible change. Re-introducing a new behavior won't
harm users OTOH.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
