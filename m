From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: more useful set-upstream
Date: Tue, 21 Sep 2010 11:30:25 +0200
Message-ID: <vpqfwx3phou.fsf@bauges.imag.fr>
References: <AANLkTi=c51u=pQ3TLt3YE54mbwy8AqRb2rcsatEVo2U5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 11:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxzBN-00062F-4w
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 11:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab0IUJaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 05:30:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48554 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab0IUJa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 05:30:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o8L9HVPR008587
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Sep 2010 11:17:31 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OxzBB-0007MA-Ds; Tue, 21 Sep 2010 11:30:25 +0200
In-Reply-To: <AANLkTi=c51u=pQ3TLt3YE54mbwy8AqRb2rcsatEVo2U5@mail.gmail.com> (Ramana Kumar's message of "Tue\, 21 Sep 2010 18\:55\:08 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 21 Sep 2010 11:17:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8L9HVPR008587
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285665453.76154@20wIY5/nSRA6K2mfll8F+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156700>

Ramana Kumar <ramana.kumar@gmail.com> writes:

> I don't understand why all my branches haven't automatically had the right
> upstream set anyway - am I missing some configuration of pull and
> push?

If you keep it simple, they should:

* git clone wherever => checks out the default branch, and sets the
  upstream for it.

* git checkout foo => if foo doesn't exist, and <remote>/foo exists,
  foo is created and upstream is set to <remote>/foo (that's rather
  recent)

But we could probably have a better way to set the upstream after the
fact when the initialisation magic didn't do its job.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
