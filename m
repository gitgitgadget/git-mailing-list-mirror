From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: What about git cp ?
Date: Sun, 03 Feb 2008 19:46:20 +0100
Message-ID: <vpq63x5swsj.fsf@bauges.imag.fr>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLjsc-00070M-JP
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYBCSrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 13:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbYBCSrS
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:47:18 -0500
Received: from imag.imag.fr ([129.88.30.1]:56551 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYBCSrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 13:47:17 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m13IkK0e025108
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Feb 2008 19:46:21 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JLjrA-0004uq-Oh; Sun, 03 Feb 2008 19:46:20 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JLjrA-0000jm-MJ; Sun, 03 Feb 2008 19:46:20 +0100
In-Reply-To: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> (Francis Moreau's message of "Sun\, 3 Feb 2008 19\:23\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 03 Feb 2008 19:46:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72391>

"Francis Moreau" <francis.moro@gmail.com> writes:

> Hello,
>
> I'm looking for a something which could be done by a git-cp command.
>
> I'd like to copy a file with its history to a new  file but want to keep the old
> one,

Git doesn't _record_ copies and renames, but detects them
after-the-fact (either by default, or explicitly like "git blame -C"
or so).

So, just "cp + git add" and you're done. That's what a "git cp"
command would do if it existed.

-- 
Matthieu
