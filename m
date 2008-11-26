From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git configure script
Date: Wed, 26 Nov 2008 21:53:46 +0100
Message-ID: <vpq7i6q8azp.fsf@bauges.imag.fr>
References: <njx4p1ub7zz.fsf@cfl-sunray1.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: neale@lanl.gov (Neale T. Pickett)
X-From: git-owner@vger.kernel.org Wed Nov 26 21:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5RRY-0006zV-49
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 21:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYKZUzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYKZUzs
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 15:55:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:44383 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbYKZUzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 15:55:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mAQKrkqb011805
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 26 Nov 2008 21:53:46 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L5ROM-0002ge-3S; Wed, 26 Nov 2008 21:53:46 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L5ROM-0006GX-1A; Wed, 26 Nov 2008 21:53:46 +0100
In-Reply-To: <njx4p1ub7zz.fsf@cfl-sunray1.lanl.gov> (Neale T. Pickett's message of "26 Nov 2008 12\:30\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 26 Nov 2008 21:53:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101768>

neale@lanl.gov (Neale T. Pickett) writes:

> But it installed everything in $HOME/bin and $HOME/libexec.  Looking
> into it, it seems the shipped Makefile doesn't look to see what --prefix
> is, despite the configure script claiming that "make install" would
> honor this.

It does, since it includes config.mak.autogen which overrides prefix
defined in Makefile.

I'm 99% sure you did something wrong. You should investigate by
looking into config.mak.autogen after running configure.

-- 
Matthieu
