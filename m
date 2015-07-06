From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git merge commit message issue
Date: Mon, 06 Jul 2015 18:33:36 +0200
Message-ID: <vpq8uats0tb.fsf@anie.imag.fr>
References: <loom.20150706T173729-880@post.gmane.org>
	<vpqtwths1yq.fsf@anie.imag.fr>
	<CAArk4YPvO46H2HXkPyPxwirauKXYJ1qpi_GmYMh-T2xz5EdaBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrey Hsiao <andreyhsiao@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9L3-0005WE-M6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbbGFQdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:33:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54227 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbbGFQdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:33:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t66GXZXi031738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jul 2015 18:33:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t66GXa9h016999;
	Mon, 6 Jul 2015 18:33:36 +0200
In-Reply-To: <CAArk4YPvO46H2HXkPyPxwirauKXYJ1qpi_GmYMh-T2xz5EdaBQ@mail.gmail.com>
	(Andrey Hsiao's message of "Tue, 7 Jul 2015 00:16:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 06 Jul 2015 18:33:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t66GXZXi031738
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436805219.85596@1/m8/BtfOHxZPeYDEdreoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273401>

[ Please, don't top-post on this list ]

Andrey Hsiao <andreyhsiao@gmail.com> writes:

> It was a bit sad since we use scripts to do the merge, then we can
> check the conflict list in the log message, and assign to separate
> owners to resolve them.
>
> Would it be possible to make it as an config option?

If a script is doing the merge, then I guess you can let your script add
the entry in .git/MERGE_MSG (based on something like 'git ls-files -u'
or 'git status --porcelain | grep ^U'). This way, your script would work
with any version of Git.

Having a config option to restore the old behavior would make sense to
me at least. I guess it falls in the category "patches welcome".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
