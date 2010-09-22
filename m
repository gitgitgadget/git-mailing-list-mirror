From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log broken?
Date: Wed, 22 Sep 2010 10:05:51 +0200
Message-ID: <vpqk4mecie8.fsf@bauges.imag.fr>
References: <20100922094808.07be1757@explosive.nyblom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Torgny Nyblom <kde@nyblom.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 10:09:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyKOb-0001q9-Kn
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 10:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab0IVIJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 04:09:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:49839 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab0IVIJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 04:09:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8M865WF019859
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Sep 2010 10:06:05 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OyKKu-0001NL-2O; Wed, 22 Sep 2010 10:05:52 +0200
In-Reply-To: <20100922094808.07be1757@explosive.nyblom.org> (Torgny Nyblom's message of "Wed\, 22 Sep 2010 09\:48\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 22 Sep 2010 10:06:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156790>

Torgny Nyblom <kde@nyblom.org> writes:

> It seems like this occurs when there is a merge only commit as the
> first commit in the list returned by the "bare" log command.

"git log --follow" is not the best part of Git :-( (especially
compared to "git blame", which is excellent at following the history
of lines of code).

There were some discussion already on --follow having bad behavior on
merge commit, like:

  http://thread.gmane.org/gmane.comp.version-control.git/151502/focus=151664

But no one is really investing energy to make "git log --follow" what
it should really be, AFAIK.

> If not is this a bug in my convert program or in git?

Your converter cannot have "mis-imported" renames, since renames do
not appear in the repository with Git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
