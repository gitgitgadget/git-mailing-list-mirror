From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: How do I stop git enumerating my working directory
Date: Tue, 01 Jul 2008 18:37:47 +0200
Message-ID: <vpqr6ad5zms.fsf@bauges.imag.fr>
References: <486A53CC.4020803@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <lists@glidos.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDitj-0002TK-Uu
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYGAQjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYGAQjK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:39:10 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:55209 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbYGAQjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:39:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m61Gbqvb014592;
	Tue, 1 Jul 2008 18:37:52 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KDirT-0003Ha-D8; Tue, 01 Jul 2008 18:37:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KDirT-0003N6-Ah; Tue, 01 Jul 2008 18:37:47 +0200
In-Reply-To: <486A53CC.4020803@glidos.net> (Paul Gardiner's message of "Tue\, 01 Jul 2008 16\:57\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 01 Jul 2008 18:37:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87051>

Paul Gardiner <lists@glidos.net> writes:

> I don't think I can make .gitignore files do the job, because
> it seems that you can set up to ignore a whole directory,
> and then partially countermand that by placing a .gitignore
> file (containing ! commands) inside the directory.

To me, it seems the opposite ;-).

I just tried to "git init" my $HOME, then "git status" takes forever,
but "echo '*' > .gitignore; git status" completes immediately.

So, an option is to put "*" in your .gitignore, and then "git add -f"
files explicitely, or to work your .gitignore finer.

-- 
Matthieu
