From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git 1.6.0.1 breaks git-svn with perl 5.8.0
Date: Mon, 01 Sep 2008 11:46:17 +0200
Message-ID: <vpqvdxggpw6.fsf@bauges.imag.fr>
References: <48BBB59F.9080204@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Sep 01 11:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka627-0001XM-Tu
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYIAJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYIAJsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:48:09 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:40721 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYIAJsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:48:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m819kVgd025129;
	Mon, 1 Sep 2008 11:46:31 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ka5zF-0006sl-Ef; Mon, 01 Sep 2008 11:46:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ka5zF-0007oY-CC; Mon, 01 Sep 2008 11:46:17 +0200
In-Reply-To: <48BBB59F.9080204@statsbiblioteket.dk> (Tom G. Christensen's message of "Mon\, 1 Sep 2008 11\:27\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 01 Sep 2008 11:46:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94554>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:

> The problem is that Git.pm depends on the "new" method of File::Temp
> introduced in 0.14.
> perl 5.8.0 only has File::Temp 0.13 while 0.14 was included with 5.8.1
> and later.
> The breakage was introduced in this commit:
> e41352b24e29eba43d00a3fd117befaef1d594bc

Isn't that fixed by c14c8ceb13b299892f286757e22e6af4f6cffab5 ?
(Git.pm: Make File::Spec and File::Temp requirement lazy, a few
commits before 1.6.0)

-- 
Matthieu
