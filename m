From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git checkout -b following git reset --hard pitfall
Date: Sun, 09 Sep 2012 15:57:03 +0200
Message-ID: <m2mx0z47v4.fsf@igel.home>
References: <op.wkdd9andsuzgrs@rob-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Maris\, Rob" <maris.rob@ingenieur.de>
X-From: git-owner@vger.kernel.org Sun Sep 09 15:57:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAi0t-00083o-Ht
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 15:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2IIN5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 09:57:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58215 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab2IIN5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 09:57:09 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XFDTY32pVz4KK6r;
	Sun,  9 Sep 2012 15:57:05 +0200 (CEST)
X-Auth-Info: RxztyVStjb4Q1wXRDQE1yxDM5JnFDYvIob4Mq7yE9Rw=
Received: from igel.home (ppp-93-104-149-132.dynamic.mnet-online.de [93.104.149.132])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XFDTY2Yy7zbbcy;
	Sun,  9 Sep 2012 15:57:05 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BE50FCA2A5; Sun,  9 Sep 2012 15:57:03 +0200 (CEST)
X-Yow: ..  over in west Philadelphia a puppy is vomiting..
In-Reply-To: <op.wkdd9andsuzgrs@rob-desktop> (Rob Maris's message of "Sun, 09
	Sep 2012 15:25:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205079>

"Maris, Rob" <maris.rob@ingenieur.de> writes:

> Normally, when there are modifications in the working tree not yet added
> resp. committed, git will refuse to change to another branch.

Only if switching the branch requires touching the modified files.

> Actually, the modified
> status of git related to both branches after git checkout -b can have
> following consequences:
>
> - it is lost definitely when git reset -hard is executed

This is true regardless.

> - if committed, it is committed into the newly created branch

This is often the desired state, and there is no harm in doing it
accidentally.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
