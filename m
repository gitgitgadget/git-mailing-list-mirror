From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git merge commit message issue
Date: Mon, 06 Jul 2015 18:08:45 +0200
Message-ID: <vpqtwths1yq.fsf@anie.imag.fr>
References: <loom.20150706T173729-880@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrey Hsiao <andreyhsiao@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8wz-0006lc-5h
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbbGFQIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:08:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41029 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbGFQIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:08:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t66G8hLp025853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jul 2015 18:08:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t66G8jQd016508;
	Mon, 6 Jul 2015 18:08:45 +0200
In-Reply-To: <loom.20150706T173729-880@post.gmane.org> (Andrey Hsiao's message
	of "Mon, 6 Jul 2015 15:41:18 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 06 Jul 2015 18:08:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t66G8hLp025853
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436803726.18286@n5AOFDj4SyCkGolGXWTitg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273395>

Andrey Hsiao <andreyhsiao@gmail.com> writes:

> Dear list:
>
> In the past, when we do the merge in git, if conflicts occurred, 
> when we commit, the conflict list will be appended to 
> the default commit message automatically.
>
> eg:
> Conflicts:
> ....a.java
> ....b.java
>
> Today, after using Git 2.3.0 for a merge, it seems now the conflict list
>  was commented out by default.

Yes, this changed here:

https://github.com/git/git/commit/261f315bebfa9af2d09f20211960100ff06f87cb

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
