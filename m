From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: how to ignore all .xvpics directories
Date: Mon, 03 Nov 2008 14:03:54 +0100
Message-ID: <vpqabchkll1.fsf@bauges.imag.fr>
References: <490ECE54.5090505@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 14:23:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwzPK-0007mW-PK
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 14:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbYKCNWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 08:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbYKCNWh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 08:22:37 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:62055 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbYKCNWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 08:22:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id mA3DIvuY013799;
	Mon, 3 Nov 2008 14:19:04 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kwz62-0003pp-6L; Mon, 03 Nov 2008 14:03:54 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kwz62-0004hg-3o; Mon, 03 Nov 2008 14:03:54 +0100
In-Reply-To: <490ECE54.5090505@melosgmbh.de> (Christoph Duelli's message of "Mon\, 03 Nov 2008 11\:11\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 03 Nov 2008 14:19:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99940>

Christoph Duelli <duelli@melosgmbh.de> writes:

> Is it possible to ignore (once and for all) that directories like
> .pics or .xvpics (that might occur all over the place where xv was
> called) should be ignored?

in ~/.gitconfig:

[core]
        excludesfile = /home/yourlogin/.gitignore

then, in ~/.gitignore:

.xvpics

and all your .xvpics will be ignored for all your projects.

(it's nice to keep such ignore list user-wide and not project-wide if
you don't want to bother your collaborators with your choice of
software).

-- 
Matthieu
