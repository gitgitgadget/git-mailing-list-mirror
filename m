From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git pull (Your local changes to ... would be overwritten by merge)
Date: Thu, 17 Jun 2010 13:11:19 +0200
Message-ID: <vpq4oh1zzfs.fsf@bauges.imag.fr>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com>
	<AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
	<4C19FBF8.6010709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Blendea <bdaniel7@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 13:15:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPD3k-0001mQ-Ao
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 13:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108Ab0FQLOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 07:14:48 -0400
Received: from imag.imag.fr ([129.88.30.1]:56345 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab0FQLOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 07:14:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o5HBBJRL026395
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Jun 2010 13:11:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OPD0B-0006wy-Q0; Thu, 17 Jun 2010 13:11:19 +0200
In-Reply-To: <4C19FBF8.6010709@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 17 Jun 2010 12\:42\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 17 Jun 2010 13:11:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149298>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Daniel Blendea venit, vidit, dixit 17.06.2010 11:35:
>> Hello,
>> 
>> A while ago I have cloned on my computer a git repo.
>> Since then, the developers have modified several files in the repo.
>> Now I want to update my copy with the latest changes.
>> 
>> I do 'git pull' but I get 'Your local changes to .... would be
>> overwritten by merge.  Aborting.'
>> I didn't modified any local file. I tried using 'git stash save' but no luck.

Which OS? Do you have any crlf conversion enabled? Any filter set in
.gitattributes?

> Most likely the remote side did a non-forward push and brought you in
> that situation.

A non-fast forward push would force a non-fast forward pull,
possibly/probably with conflicts, but wouldn't trigger this message,
which is generated before the merge is actually started.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
