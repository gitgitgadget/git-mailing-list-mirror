From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 11:27:49 +0100
Message-ID: <vpq4pcp6moq.fsf@bauges.imag.fr>
References: <47A6E130.7090909@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 11:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLyaK-0000pP-VI
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbYBDK3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYBDK3M
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:29:12 -0500
Received: from imag.imag.fr ([129.88.30.1]:34164 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbYBDK3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 05:29:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m14ARn7E026858
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 11:27:50 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JLyYH-000220-Qd; Mon, 04 Feb 2008 11:27:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JLyYH-0002J4-Nz; Mon, 04 Feb 2008 11:27:49 +0100
In-Reply-To: <47A6E130.7090909@glidos.net> (Paul Gardiner's message of "Mon\, 04 Feb 2008 09\:56\:00 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 04 Feb 2008 11:27:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72486>

Paul Gardiner <osronline@glidos.net> writes:

> Hi,
>
> I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
> want a local mirror on my own home server, so that it appears amongst
> the projects shown by my own gitweb set up, and so it gets caught by
> my backup system.  I've created the mirror with
>
>   git clone --bare <remote-url> <local-dir>
>
> and that seems fine.  But how do I now keep it up to date.  I was
> guessing a cron job doing some sort of git pull, but pull doesn't
> look to work on --bare proj.git type repositories.

You probably want "git fetch". Actually, "git pull" does a fetch first
(get the remote revisions that you don't have), and then a merge with
your working tree.

-- 
Matthieu
