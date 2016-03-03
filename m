From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature request: Configurable prefixes for git commit --fixup and --squash
Date: Thu, 03 Mar 2016 15:52:41 +0100
Message-ID: <vpq8u1zlikm.fsf@anie.imag.fr>
References: <CALHmdRz3ffgifH2BZK14B=4LGFqOeTWpRarD+RAFx8AtwwMidg@mail.gmail.com>
	<20160303132128.GE1766@serenity.lan> <vpqio13ll3i.fsf@anie.imag.fr>
	<CALHmdRwe2d=DwFbNhOB91DQ7rnW7yUTeQZ3td9zef4v2-aOBqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, authmillenon@riot-os.org,
	John Keeping <john@keeping.me.uk>
To: Martine Lenders <mlenders@riot-os.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 15:53:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abUd6-000369-3l
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 15:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbcCCOxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 09:53:24 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39072 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbcCCOxX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 09:53:23 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u23EqeoM028125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Mar 2016 15:52:40 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u23EqfW2029076;
	Thu, 3 Mar 2016 15:52:41 +0100
In-Reply-To: <CALHmdRwe2d=DwFbNhOB91DQ7rnW7yUTeQZ3td9zef4v2-aOBqg@mail.gmail.com>
	(Martine Lenders's message of "Thu, 3 Mar 2016 15:38:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 03 Mar 2016 15:52:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u23EqeoM028125
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457621562.45241@so1i8uvpb8vYy/ilRjqPCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288183>

[ Please, don't top-post on this list ]

Martine Lenders <mlenders@riot-os.org> writes:

> Hi Matthieu,
> We already do this :-). But sadly, this won't help: [ci skip]
> encourages Travis-CI to do nothing at all, while your proposed
> solution will at least require Travis to boot up a VM (or in case of a
> build matrix several VMs). In our case, including queueing this can
> take up to 1h.

Ah, indeed. Booting a VM just to execute "if fixup, do nothing" is a bit
overkill ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
