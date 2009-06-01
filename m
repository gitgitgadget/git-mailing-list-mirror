From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: "exclude" and ".gitignore" for everyone
Date: Mon, 01 Jun 2009 16:36:30 +0200
Message-ID: <vpqy6scc975.fsf@bauges.imag.fr>
References: <h00m32$gs0$2@ger.gmane.org>
	<E6F58E6B-4ECF-4A55-9249-9A8BBFBDBC24@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikos Chantziaras <realnc@arcor.de>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB8iQ-0000gz-UG
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 16:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZFAOmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 10:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbZFAOmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 10:42:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:38029 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbZFAOmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 10:42:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n51Ec4Ox028575
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2009 16:38:04 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MB8dW-0004he-AJ; Mon, 01 Jun 2009 16:37:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MB8co-0001p1-Nz; Mon, 01 Jun 2009 16:36:30 +0200
In-Reply-To: <E6F58E6B-4ECF-4A55-9249-9A8BBFBDBC24@silverinsanity.com> (Brian Gernhardt's message of "Mon\, 1 Jun 2009 09\:58\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 01 Jun 2009 16:38:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120473>

Brian Gernhardt <benji@silverinsanity.com> writes:

>  Generally, I'd suggest putting [...] your editor's garbage in
> exclude.

better: put them in a user-wide ignore file.

in ~/.gitconfig:

[core]
        excludesfile = /home/yourlogin/.gitignore

then put whatever you want in $HOME/.gitignore.

-- 
Matthieu
