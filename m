From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Specifying revisions in the future
Date: Sun, 05 Feb 2012 21:18:14 +0100
Message-ID: <vpqipjlf309.fsf@bauges.imag.fr>
References: <jgjkk0$qrg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: jpaugh@gmx.us
X-From: git-owner@vger.kernel.org Sun Feb 05 21:18:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8XZ-0003YM-63
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab2BEUSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 15:18:21 -0500
Received: from mx2.imag.fr ([129.88.30.17]:41538 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab2BEUSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 15:18:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q15KFPjC024080
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 5 Feb 2012 21:15:25 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ru8XP-0004V3-1S; Sun, 05 Feb 2012 21:18:15 +0100
In-Reply-To: <jgjkk0$qrg$1@dough.gmane.org> (jpaugh@gmx.us's message of "Sat,
	04 Feb 2012 10:58:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 05 Feb 2012 21:15:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q15KFPjC024080
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329077727.75155@3xYsrSNzS2mjAyA5Z241uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189953>

jpaugh@gmx.us writes:

> Hello.
>
> Is it possible to specify revisions in the future?

You mean, the opposite of <commit>^ or <commit>~n?

AFAIK, there isn't, and there's a good reason for that: <commit>^ is
well-defined, it's the first parent of <commit>, and it won't change
unless one rewrites this commit.

"the successor of <commit>", OTOH, is not well defined, since there can
be several successors, and one can't order them reliably (you can't
really know the set of successors, because they can exist in different
repositories).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
