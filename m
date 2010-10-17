From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t0003: properly quote $HOME
Date: Sun, 17 Oct 2010 21:37:25 +0200
Message-ID: <vpqiq10a9vu.fsf@bauges.imag.fr>
References: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 21:38:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Z3T-0001sM-1B
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab0JQTh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:37:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45365 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932540Ab0JQTh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:37:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9HJVS6C023916
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Oct 2010 21:31:28 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P7Z2r-00007r-DE; Sun, 17 Oct 2010 21:37:25 +0200
In-Reply-To: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun\, 17 Oct 2010 21\:13\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 17 Oct 2010 21:31:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9HJVS6C023916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1287948691.73262@yYH/n1JN3edvQ6dVrZj01g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159215>

Thomas Rast <trast@student.ethz.ch> writes:

> 6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
> to quote one instance of $HOME in the tests.  This broke the test for
> me with the shell complaining about an ambiguous redirect (but only
> when run with --root for some reason).

My bad, sorry. ACK for the fix.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
