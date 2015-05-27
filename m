From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Wed, 27 May 2015 17:04:09 +0200
Message-ID: <vpq1ti23vva.fsf@anie.imag.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
	<1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 17:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxcsW-00012t-6P
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 17:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbE0PEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 11:04:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44922 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbbE0PEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 11:04:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4RF48UB026492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2015 17:04:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4RF49CW021271;
	Wed, 27 May 2015 17:04:09 +0200
In-Reply-To: <1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 27 May 2015 16:53:06 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 May 2015 17:04:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4RF48UB026492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433343848.73698@E8LoGIUUT0cmBHyuAriuQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270057>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> It also has some effects with the second part of this patch (checks
> removed and/or duplicated commits): if you comment the line, the
> commit will be considered as removed, thus ending in a warning if the
> config variable is set to warn/error; however this problem won't
> appear with noop.

Indeed, that's the whole point of having a "drop" command.

As an advice for your next submission: use "git send-email
--cover-letter", and explain the overall idea before the patches.

I personally prefer "drop" to "noop" as a command name: I understand
"noop" as a command without argument (useful to say "this is actually an
empty list of commands, not an empty file to ask rebase to abort"), but
I find it weird to write

noop <sha1> <title>

As Remi wrote, the inspiration comes from Mercurial. Perhaps we should
ask on the mercurial ml how happy they are with the name.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
