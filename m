From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-daemon documentation: use {tilde}
Date: Tue, 16 Dec 2008 19:05:28 +0100
Message-ID: <vpqbpvcro5z.fsf@bauges.imag.fr>
References: <1229442492-11993-1-git-send-email-vmiklos@frugalware.org>
	<4947E7B1.2090608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCfHJ-0004Au-I5
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 20:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYLPTHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 14:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYLPTHB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 14:07:01 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:39001 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbYLPTHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 14:07:00 -0500
X-Greylist: delayed 1362 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Dec 2008 14:06:59 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id mBGIeQAN028039;
	Tue, 16 Dec 2008 19:40:31 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LCeIS-0005bd-UZ; Tue, 16 Dec 2008 19:05:28 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LCeIS-0007tw-S6; Tue, 16 Dec 2008 19:05:28 +0100
In-Reply-To: <4947E7B1.2090608@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\, 16 Dec 2008 18\:38\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 16 Dec 2008 19:40:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103289>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Miklos Vajna venit, vidit, dixit 16.12.2008 16:48:
>> Use '{tilde}' instead of '~', becase the later does not appear in the
>> manpage version, just in the HTML one.
>
> Curiously, "git help daemon" (which execs "man git-daemon") displays the
> tilde but "man git-daemon" does not (nor does "konqueror
> man:git-daemon"). Humh?

You probably have two manpages because of two git installations. "man"
will take the one in your manpath, and git will try to find the one
corresponding to the version of git you actually launched.

-- 
Matthieu
