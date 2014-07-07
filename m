From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Adding 'Signed-off-by' to 'subtree add --squash' commits
Date: Mon, 07 Jul 2014 18:55:07 +0200
Message-ID: <87vbr93y8k.fsf@igel.home>
References: <6A74A01C3512C646A9ED99AFA28AEB981358A7E8@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"Gray\, Mark D" <mark.d.gray@intel.com>
To: "Finucane\, Stephen" <stephen.finucane@intel.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 18:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CCI-0000AM-0b
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 18:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbaGGQzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 12:55:14 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57145 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaGGQzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 12:55:11 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3h6Xvd2zCgz3hhkX;
	Mon,  7 Jul 2014 18:55:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3h6Xvd1Xchz7S6ST;
	Mon,  7 Jul 2014 18:55:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id yjvCWZICKSD5; Mon,  7 Jul 2014 18:55:07 +0200 (CEST)
X-Auth-Info: XOdNlsnpIrel5SNLk7HYOJ24Lzju7J97lpHwrpArTWU=
Received: from igel.home (ppp-188-174-151-197.dynamic.mnet-online.de [188.174.151.197])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  7 Jul 2014 18:55:07 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 6CC642C3617; Mon,  7 Jul 2014 18:55:07 +0200 (CEST)
X-Yow: NANCY!!  Why is everything RED?!
In-Reply-To: <6A74A01C3512C646A9ED99AFA28AEB981358A7E8@IRSMSX102.ger.corp.intel.com>
	(Stephen Finucane's message of "Mon, 7 Jul 2014 09:32:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252966>

"Finucane, Stephen" <stephen.finucane@intel.com> writes:

> Is it possible to "sign off" squashed commits created by the 'git subtree add ... --squash' command?

If it isn't directly possible, you can always use "git commit --amend -C
HEAD -s" to modify the commit afterwards.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
