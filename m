From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: regarding "git status"
Date: Thu, 13 May 2010 16:20:32 +0200
Message-ID: <vpqtyqbc28f.fsf@bauges.imag.fr>
References: <loom.20100513T155553-871@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Terrence Brannon <schemelab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 16:20:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZHI-0003w0-CO
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab0EMOUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:20:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40231 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756025Ab0EMOUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 10:20:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o4DEEBkV021563
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 May 2010 16:14:11 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OCZH6-0004EP-C3; Thu, 13 May 2010 16:20:32 +0200
In-Reply-To: <loom.20100513T155553-871@post.gmane.org> (Terrence Brannon's message of "Thu\, 13 May 2010 13\:56\:06 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 May 2010 16:14:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o4DEEBkV021563
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1274364851.16018@xtdptFgkMaOHt6LRubdR5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147008>

Terrence Brannon <schemelab@gmail.com> writes:

> In the manpage for git-status
> (http://www.kernel.org/pub/software/scm/git/docs/git-status.html) it says:
>
> "Displays paths that have differences between the index file and the current
> HEAD commit"
>
> but how could something be added to the index and not be different from the
> current HEAD commit?

The index doesn't contain the _differences_ between what you're about
to commit and HEAD, it contains _all_ the content you're going to
commit, i.e. if you have no new stuff to commit, it contains the same
thing as HEAD (in a slightly different form: HEAD uses just the object
database, while .git/index is roughly an array of files).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
