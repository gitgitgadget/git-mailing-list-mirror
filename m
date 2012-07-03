From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How do I delete a remote branch with a period in the name?
Date: Tue, 03 Jul 2012 09:56:46 +0200
Message-ID: <m23959e0qp.fsf@igel.home>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "jonsmirl\@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 09:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slxyk-000686-2I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 09:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933505Ab2GCH4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 03:56:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56313 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2GCH4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 03:56:50 -0400
Received: from frontend4.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WRHjs6sLWz4KKCq;
	Tue,  3 Jul 2012 09:57:21 +0200 (CEST)
Received: from igel.home (ppp-88-217-101-196.dynamic.mnet-online.de [88.217.101.196])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WRHjB3CZDzbbvw;
	Tue,  3 Jul 2012 09:56:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 20E1DCA2A4; Tue,  3 Jul 2012 09:56:46 +0200 (CEST)
X-Yow: OVER the undertow!  UNDER the overpass!  Around the FUTURE
 and BEYOND REPAIR!!
In-Reply-To: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	(jonsmirl@gmail.com's message of "Mon, 2 Jul 2012 23:09:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200906>

"jonsmirl@gmail.com" <jonsmirl@gmail.com> writes:

> jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git push origin :fl.stg
> error: unable to push to unqualified destination: fl.stg
> The destination refspec neither matches an existing ref on the remote nor
> begins with refs/, and we are unable to guess a prefix based on the source ref.
> error: failed to push some refs to 'git@github.com:jonsmirl/lpc31xx.git'
> jonsmirl@smirl2:/home/apps/florida/lpc31xx$
>
> jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git branch -r
>   linus/master
>   origin/HEAD -> origin/master
>   origin/bar.stgit
>   origin/dt-test
>   origin/fl.stgit
>   origin/foo.stgit
>   origin/lpc313x-stg
>   origin/lpc313x-stg.stgit
>   origin/master
>   origin/master.stgit
>   origin/temp.stgit
>   origin/v3.4-stg
>   origin/v3.4-stg.stgit
>   origin/v3.5-stg
>   origin/v3.5-stg.stgit

There doesn't appear to be a remote branch with that name.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
