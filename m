From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Testing for commit reachability through plumbing commands
Date: Thu, 06 Mar 2014 20:17:42 +0100
Message-ID: <877g879lwp.fsf@igel.home>
References: <CACPiFCJLyE6XC9dY_eawe2y9gS4YsPdTbqkKAd0dcPXd5-eMCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdni-0003w9-GP
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbaCFTRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:17:46 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:48110 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaCFTRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:17:45 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fg1tv3N5Wz4KK3w;
	Thu,  6 Mar 2014 20:17:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fg1tv3GFvzbbfj;
	Thu,  6 Mar 2014 20:17:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id GXRXJcRihcMh; Thu,  6 Mar 2014 20:17:42 +0100 (CET)
X-Auth-Info: LmFrXF6+7wHYxz18oN7FM5xal5+khQ9RF/9CUdEn/e8=
Received: from igel.home (ppp-46-244-225-217.dynamic.mnet-online.de [46.244.225.217])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu,  6 Mar 2014 20:17:42 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 943462C1D37; Thu,  6 Mar 2014 20:17:42 +0100 (CET)
X-Yow: Yow!  We're going to a new disco!
In-Reply-To: <CACPiFCJLyE6XC9dY_eawe2y9gS4YsPdTbqkKAd0dcPXd5-eMCg@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 6 Mar 2014 12:17:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243535>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I have a shell script that trims old history on a cronjob. This is for
> a repo that is used to track reports that have limited "life" (like
> logs). Old history is trimmed with grafts pointing to an empty "root"
> commit.
>
> Right now, info/graft grows unbound. I am looking for a way to trim
> unreachable grafts, I would like to be able to say something like:
>
>  git is-reachable treeish
>
> Grepping through docs and existing code hasn't helped, but perhaps I'm
> missing something obvious...

Does git fsck --unreachable --no-reflogs help?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
