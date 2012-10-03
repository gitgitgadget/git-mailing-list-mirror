From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Wed, 03 Oct 2012 18:52:24 +0200
Message-ID: <m2bogja46v.fsf@igel.home>
References: <k4hj91$4tt$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJSBc-0008Tk-GB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 18:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108Ab2JCQw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 12:52:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53542 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019Ab2JCQw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 12:52:26 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XX3Dn2m90z4KK5w;
	Wed,  3 Oct 2012 18:52:25 +0200 (CEST)
X-Auth-Info: GDYA1yYQqCXKJgo8QVodb9A7jNcIeEqsg+9bymV/W70=
Received: from igel.home (ppp-93-104-158-56.dynamic.mnet-online.de [93.104.158.56])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XX3Dn2RHNzbbfm;
	Wed,  3 Oct 2012 18:52:25 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0C4E0CA2B8; Wed,  3 Oct 2012 18:52:24 +0200 (CEST)
X-Yow: Yow!  Maybe I should have asked for my Neutron Bomb in PAISLEY--
In-Reply-To: <k4hj91$4tt$4@ger.gmane.org> (Geoffrey De Smet's message of "Wed,
	03 Oct 2012 16:49:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206913>

Geoffrey De Smet <ge0ffrey.spam@gmail.com> writes:

> Suppose this case:
>
> git clone .../blessedRepo.git
> // do changes
> git commit -m"bad1"
> // do changes
> git commit -m"bad2"
> git reset --hard HEAD^4 // Why does it let me do this?

Because there is nothing wrong with that.

> // I just "broke" my local repository, because if I continue

No you didn't.

> // do changes
> git commit -m"good1"
> git push origin master // fails because the history disrespects the remote
> repo's history

You may just as well want to push it to a different branch (or even a
different repository).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
