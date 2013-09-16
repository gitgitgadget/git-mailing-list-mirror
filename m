From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 1.8.4 rebase regression?
Date: Mon, 16 Sep 2013 09:52:35 +0200
Message-ID: <vpqsix5b3uk.fsf@anie.imag.fr>
References: <20130915235739.GA712@quark>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Welche <prlw1@cam.ac.uk>
X-From: git-owner@vger.kernel.org Mon Sep 16 09:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLTbz-0002Eq-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 09:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab3IPHwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 03:52:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44773 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288Ab3IPHwn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 03:52:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8G7qYYO015315
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Sep 2013 09:52:34 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VLTbn-0006Rn-JC; Mon, 16 Sep 2013 09:52:35 +0200
In-Reply-To: <20130915235739.GA712@quark> (Patrick Welche's message of "Mon,
	16 Sep 2013 00:57:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Sep 2013 09:52:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8G7qYYO015315
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379922759.4042@SGa12wkiL31MLDpABxv0BQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234831>

Patrick Welche <prlw1@cam.ac.uk> writes:

> I just upgraded (via pkgsrc) from git 1.8.3.4 to 1.8.4. With 1.8.4, I had
> local changes in glib, did a git pull --rebase. Some of my changes
> conflicted, but
>
> $ git rebase --abort
> No rebase in progress?
>
> so somehow the usual process of amending the edit, or skipping the patch
> no longer works.
>
> I found a similar report at:
> http://mail-index.netbsd.org/pkgsrc-users/2013/09/14/msg018646.html

Does the following patch fix this issue?

  https://github.com/git/git/commit/99855dd

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
