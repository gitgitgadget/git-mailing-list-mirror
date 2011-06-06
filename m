From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 500Mb file erroneously commited
Date: Mon, 06 Jun 2011 11:10:16 +0200
Message-ID: <vpq62oj2umf.fsf@bauges.imag.fr>
References: <loom.20110606T093627-918@post.gmane.org>
	<20110606075508.GC19127@axel>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 11:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTVpK-0007OD-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab1FFJKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:10:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48407 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab1FFJKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:10:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p569AGO9022957
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Jun 2011 11:10:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QTVpA-0006HD-NI; Mon, 06 Jun 2011 11:10:16 +0200
In-Reply-To: <20110606075508.GC19127@axel> (Axel Freyn's message of "Mon, 6
	Jun 2011 09:55:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 06 Jun 2011 11:10:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p569AGO9022957
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307956217.49751@48N/SPgoR6WbHhaxfePVrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175105>

Axel Freyn <axel-freyn@gmx.de> writes:

>  - if you have already other commit's on top of it, you can use e.g.
>    "git rebase" in order to redefine the history... something like (I'm
>    not sure it works exactly like that, but in principle)
>    git checkout -b tmp <WRONG_COMMIT>
>    git rm bigfile
>    git commit --amend
>    git checkout master
>    git rebase tmpfix
>    git branch -d tmpfix

That should work, but "git rebase -i" will make it much simpler (just
"edit" or even delete the guilty commit).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
