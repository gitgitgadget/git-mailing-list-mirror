From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 04 Dec 2007 22:32:20 +0100
Message-ID: <vpq4peyjgd7.fsf@bauges.imag.fr>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
	<m34peyur8r.fsf@roke.D-201>
	<7vir3e428i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Salikh Zakirov <salikh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 22:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzfOX-0005Qv-GV
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 22:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbXLDVdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 16:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbXLDVdM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 16:33:12 -0500
Received: from imag.imag.fr ([129.88.30.1]:39005 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245AbXLDVdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 16:33:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lB4LWKlX005245
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 22:32:20 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IzfNM-0000jM-9d; Tue, 04 Dec 2007 22:32:20 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IzfNM-0006xR-7B; Tue, 04 Dec 2007 22:32:20 +0100
In-Reply-To: <7vir3e428i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 04 Dec 2007 12\:46\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 04 Dec 2007 22:32:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67084>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, I am not sympathetic to "I have to remember".

That's definitely not an important point, but I find it conveinient,
for example in hg, to be able to just "hg update" to get to the tip of
a branch.

A use-case (which joins the one of Salikh actually) is to publish both
a repository and a working tree (I do that for my collegues which may
or (usually) may not use git). Making a hook to update the working
tree after a push is a terrible hack in git, and just "hg update" in
Mercurial.

(once again, that's one point in favor of base separate from current
branch, but it doesn't cancel the possible drawbacks. It seems
the thread "Reverting the whole index-base series" at
http://thread.gmane.org/gmane.comp.version-control.git/44360/focus=44525
is interesting to read, I'll dig a bit more.

As you mention in the thread, detaching head when pushing to a
checked-out branch would probably be an interesting option)

-- 
Matthieu
