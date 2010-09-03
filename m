From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Fri, 03 Sep 2010 21:34:02 +0200
Message-ID: <vpqr5habp05.fsf@bauges.imag.fr>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Fri Sep 03 21:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orc23-0006ke-4Z
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 21:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab0ICTee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 15:34:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57062 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012Ab0ICTed (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 15:34:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o83JUNXt028114
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Sep 2010 21:30:23 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Orc1T-0001Vx-Ie; Fri, 03 Sep 2010 21:34:03 +0200
In-Reply-To: <20100903192907.GA2978@n2100.arm.linux.org.uk> (Russell King's message of "Fri\, 3 Sep 2010 20\:29\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Sep 2010 21:30:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o83JUNXt028114
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1284147025.02486@drVAE4s3PQYnR92psAWGhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155268>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> git patches include additional metadata for renaming files, which gnu patch
> will not understand.
>
> If you want GNU patch compatible diffs, don't use -C or -M when generating
> patches out of git.

Fyi: actually, GNU patch will support git-style patches in the next
version according to

http://savannah.gnu.org/forum/forum.php?forum_id=6320

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
