From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Avoid TAGS/tags warning from GNU Make
Date: Sat, 04 Sep 2010 11:41:17 +0200
Message-ID: <vpqeid97sn6.fsf@bauges.imag.fr>
References: <20100904090331.GA10903@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <frekui@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 11:44:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrpIS-0007cw-LR
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 11:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab0IDJoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 05:44:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:55576 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab0IDJoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 05:44:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o849fHEV027878
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 4 Sep 2010 11:41:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OrpFN-00086w-Cq; Sat, 04 Sep 2010 11:41:17 +0200
In-Reply-To: <20100904090331.GA10903@burratino> (Jonathan Nieder's message of "Sat\, 4 Sep 2010 04\:03\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 04 Sep 2010 11:41:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155314>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 22 Oct 2009 19:04:17 +0200
>
> MinGW make considers the TAGS and tags targets to refer to
> the same file:
>
>  Makefile: warning: overriding commands for target `TAGS'
>  Makefile: warning: ignoring old commands for target `TAGS'
>
> Suppress both targets on that platform.

Wouldn't it be more sensible to rename them (like ETAGS/CTAGS) on
mingw instead, in case someone wants to use these files on windows?

Well, anyway, it doesn't harm much to remove them, they're just
convenience targets to be used by text editors, not by the build
system itself.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
