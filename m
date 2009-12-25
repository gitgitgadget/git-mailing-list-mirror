From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: You have local changes; cannot switch branches error question
Date: Fri, 25 Dec 2009 15:32:03 +0100
Message-ID: <vpqpr63cefw.fsf@bauges.imag.fr>
References: <76c5b8580912241425k741b24e9ie8ed92ca7cb8a659@mail.gmail.com>
	<7vhbrghrsn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 15:32:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOBDO-0001FH-UW
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 15:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbZLYOcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 09:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbZLYOcR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 09:32:17 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57735 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713AbZLYOcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 09:32:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nBPEVJgx001707
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Dec 2009 15:31:19 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NOBD1-00054H-Nt; Fri, 25 Dec 2009 15:32:03 +0100
In-Reply-To: <7vhbrghrsn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 24 Dec 2009 15\:32\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Dec 2009 15:31:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBPEVJgx001707
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1262356281.72582@g8keskH+kt5wP+6ADgQk+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135674>

Junio C Hamano <gitster@pobox.com> writes:

> There are two ways to deal with this situation, one safely, and another
> quickly.

And a third one : commit, and then rebase onto the other branch. It's
safe, and nice when your local changes are ready to commit (then, you
can write the commit message before bothering about potential merge
conflicts).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
