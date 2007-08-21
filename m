From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Replace git --paginate by git --pager[=PAGER_CMD].
Date: Tue, 21 Aug 2007 10:51:30 +0200
Message-ID: <vpqtzqte0dp.fsf@bauges.imag.fr>
References: <fadhkv$amj$2@sea.gmane.org>
	<11876854283229-git-send-email-Matthieu.Moy@imag.fr>
	<Pine.LNX.4.64.0708211041170.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 21 10:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INPTI-0005ut-Iw
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 10:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757AbXHUIwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXHUIwP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 04:52:15 -0400
Received: from imag.imag.fr ([129.88.30.1]:56952 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456AbXHUIwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 04:52:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7L8pVg5019829
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Aug 2007 10:51:31 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1INPSU-0005lg-Ij; Tue, 21 Aug 2007 10:51:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1INPSU-0006nV-GM; Tue, 21 Aug 2007 10:51:30 +0200
In-Reply-To: <Pine.LNX.4.64.0708211041170.16728@wbgn129.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Tue\, 21 Aug 2007 10\:42\:21 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 21 Aug 2007 10:51:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56286>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Personally, I like to read "git --paginate log" better than to read "git 
> --pager log".  So I would not unnecessarily deprecate --paginate.  It's 
> not like it hurts or something.

It doesn't "hurt", but having several options to do the same thing is
useless and confusing (someone reading here about --paginate and there
about --pager may not immediately notice that one is an alias for the
other).

Anyway, how often do you type or read "git --paginate log"?

-- 
Matthieu
