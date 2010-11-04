From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 04 Nov 2010 09:42:22 +0100
Message-ID: <vpq39rhzdht.fsf@bauges.imag.fr>
References: <1288847836-84882-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 09:42:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDvP3-0001CR-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 09:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab0KDImc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 04:42:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60984 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab0KDImb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 04:42:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA48ZoGJ001407
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Nov 2010 09:35:50 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PDvOp-0007mb-6W; Thu, 04 Nov 2010 09:42:23 +0100
In-Reply-To: <1288847836-84882-1-git-send-email-kevin@sb.org> (Kevin Ballard's message of "Wed\,  3 Nov 2010 22\:17\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Nov 2010 09:35:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA48ZoGJ001407
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289464555.39492@fDxNWYjObJUTBhmDHjXU4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160694>

Kevin Ballard <kevin@sb.org> writes:

> Add a new command "shell", which takes an option commit. It simply exits
> to the shell with the commit (if given) and a message telling the user how
> to resume the rebase.

"shell" sounds like you're going to execute something in a shell, not
that you're going back to the shell. Looking at the commit message, I
thought you had missed the "exec" command and re-implemented it.

What about "pause", abbreviated as "p" for the command name?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
