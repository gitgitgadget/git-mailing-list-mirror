From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC resend] diff-options: make --patch a synonym for -p
Date: Thu, 13 May 2010 13:39:40 +0200
Message-ID: <vpqzl04ghdv.fsf@bauges.imag.fr>
References: <1273741140.2516.15.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 13:40:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCWmB-0002LJ-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 13:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762Ab0EMLkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 07:40:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38769 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758759Ab0EMLkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 07:40:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o4DBXJWw001569
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 May 2010 13:33:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OCWlQ-0002UE-WB; Thu, 13 May 2010 13:39:41 +0200
In-Reply-To: <1273741140.2516.15.camel@wpalmer.simply-domain> (Will Palmer's message of "Thu\, 13 May 2010 09\:59\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 May 2010 13:33:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o4DBXJWw001569
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1274355200.86923@AF2HnsBclWJ+pVTiMk50tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146988>

Will Palmer <wmpalmer@gmail.com> writes:

> Re-sending, as this seems to have slipped under the radar last time.
> In case a justification is non-obvious: -p has always meant "patch", and the
> synonym (-u) has a long-form. I always find myself typing out the long-form
> --patch, only to be surprised that it doesn't exist. This patch seeks to
> correct what I can only assume was an oversight.

Agreed. I'll still type -p, but explaining to newbies "git log --patch"
is self-explanatory, while "git log -p" is non-obvious, especially
when it's different from "git -p log"...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
