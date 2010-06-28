From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 18:27:20 +0200
Message-ID: <vpqaaqfgm1j.fsf@bauges.imag.fr>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karl Stenerud <kstenerud@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 18:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTHEr-0005Ew-9O
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131Ab0F1QbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 12:31:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:48293 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab0F1QbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 12:31:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o5SGRKEB013669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jun 2010 18:27:20 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OTHB2-0007Fp-9E; Mon, 28 Jun 2010 18:27:20 +0200
In-Reply-To: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com> (Karl Stenerud's message of "Mon\, 28 Jun 2010 12\:10\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 28 Jun 2010 18:27:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149838>

Karl Stenerud <kstenerud@gmail.com> writes:

> The git help tells me I can disable it by setting gc.auto to 0,
> while the mailing list archive tells me I also have to set
> gc.autopacklimit to 0.  This is fine, but if I do that, I won't know
> when the repo is in need of cleanup.  Is there any option I can set
> to instruct it to simply TELL me when it's in need of gc?

An alternative is to actually run "git gc" periodically, to make sure
that git gc --auto is never needed.

I do that from a cron job for example.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
