From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Replace filepattern with pathspec for consistency
Date: Tue, 12 Feb 2013 18:06:31 +0100
Message-ID: <vpq4nhhv4vc.fsf@grenoble-inp.fr>
References: <1360661084-8678-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vliatijej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:07:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5JJv-0006Zs-K6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 18:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304Ab3BLRGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 12:06:39 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57077 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932327Ab3BLRGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 12:06:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1CH6TSO009643
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2013 18:06:30 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U5JJP-0006cD-ND; Tue, 12 Feb 2013 18:06:31 +0100
In-Reply-To: <7vliatijej.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 12 Feb 2013 08:31:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Feb 2013 18:06:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1CH6TSO009643
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361293592.74771@5iJ1Q+uQNnTtvkh3198djA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216161>

Junio C Hamano <gitster@pobox.com> writes:

> The strings that are fed to _() would be updated with your patch,
> but the replacement will stay to be "filepattern" translated to the
> target language.  Translators have to actively hunt for the messages
> to update them.  If you left the .po files untouched, they would
> notice when git.pot is updated the next time and that will ensure
> that the affected messages get translated, no?

Right, and I'm not competent to say how filepattern was translated in
any of the languages. Let me know if you want a resend without the po/
part.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
