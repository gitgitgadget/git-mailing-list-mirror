From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Thu, 09 Sep 2010 23:30:22 +0200
Message-ID: <vpqocc6vc41.fsf@bauges.imag.fr>
References: <1284056514-4935-1-git-send-email-davi.reis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: davi.reis@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 09 23:33:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtokE-0000s0-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 23:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab0IIVdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 17:33:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:54630 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab0IIVdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 17:33:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o89LUNRd012001
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 9 Sep 2010 23:30:23 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OtohL-0000P9-3o; Thu, 09 Sep 2010 23:30:23 +0200
In-Reply-To: <1284056514-4935-1-git-send-email-davi.reis@gmail.com> (davi reis's message of "Thu\,  9 Sep 2010 11\:21\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 09 Sep 2010 23:30:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155904>

davi.reis@gmail.com writes:

> Subject: Re: [PATCH 1/2] Do not let lstree output recursively when a =
directory whose name is a prefix of the others is give

Don't try to put everything in the subject line. The subject line
should be < 80 characters (fit in a standard terminal), and it's best
if commands like "git log --oneline" & friends can show it without
truncating it, hence, ~50-60 characters is good.

What about

ls-tree: do not recurse when a directory is a prefix of another

<then, a more detailed description, after a blank line>

(I don't know the code of ls-tree, and I don't really understand
either the bug or the fix by reading this. A good commit message help
people to get convinced that your code is good)

> From: Davi Reis <davi@davi-macbookpro.local>

If you use the same identifier for the commit and when you send the
email, you'll get rid of this =AB=A0From=A0=BB in the body. I don't thi=
nk you
want this davi-macbookpro.local to appear publicly indeed.

You don't have a Signed-Off-By:, please read
Documentation/SubmittingPatches to see how to add it and what it
means.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
