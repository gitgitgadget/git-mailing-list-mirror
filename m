From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Trivial fix: Display a more friendly message with git-shell.
Date: Mon, 21 Sep 2009 08:45:16 +0200
Message-ID: <vpqeiq0ssn7.fsf@bauges.imag.fr>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
	<4AB71A76.5010509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 08:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpceN-0008Lr-K0
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 08:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZIUGpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 02:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbZIUGpU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 02:45:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52154 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbZIUGpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 02:45:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8L6gEoL020387
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Sep 2009 08:42:14 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MpceC-0002qh-OM; Mon, 21 Sep 2009 08:45:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MpceC-0001Q3-Le; Mon, 21 Sep 2009 08:45:16 +0200
In-Reply-To: <4AB71A76.5010509@viscovery.net> (Johannes Sixt's message of "Mon\, 21 Sep 2009 08\:17\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Sep 2009 08:42:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8L6gEoL020387
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254120135.14167@vN6cP7iXoqFxaudvJfwgbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128865>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Every other use of git-shell is an error, and the current error message
> says exactly that, although in a very 31337 way (and, BTW, /me likes
> it :-)

Well, it's funny, but for a newcommer, trying "git shell" hoping to
get, for example what "bzr shell" gives (an interactive shell with
normal shell commands plus bzr ones without the 'bzr' prefix), it's
quite frustrating to be almost insulted by the tool for being curious.

> If an naive user runs git-shell from the command line, then your new
> message will not be helpful because git-shell will accept only a very
> restricted set of commands.

Perhaps one more line saying what 'man git-shell' says in addition
would help:

$ git-shell
git-shell: Restricted login shell for GIT-only SSH access
Usage: ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
