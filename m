From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 17:08:17 +0200
Message-ID: <20050416150816.GA4943@electric-eye.fr.zoreil.com>
References: <20050416131528.GB19908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:06:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMosI-0003Ym-1I
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVDPPJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVDPPJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:09:59 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:2753 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262678AbVDPPJ5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 11:09:57 -0400
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.1/8.12.1) with ESMTP id j3GF8M5T005310;
	Sat, 16 Apr 2005 17:08:22 +0200
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.1/8.13.1/Submit) id j3GF8HWw005309;
	Sat, 16 Apr 2005 17:08:17 +0200
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050416131528.GB19908@elte.hu>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar <mingo@elte.hu> :
[...]
> the history data starts at 2.4.0 and ends at 2.6.12-rc2. I've included a 
> script that will apply all the patches in order and will create a 
> pristine 2.6.12-rc2 tree.

127 weeks of bk-commit mail for the 2.6 branch alone since october 2002
provides more than 44000 messages here. The figures are surprisingly
different.

> it needed many hours to finish, on a very fast server with tons of RAM, 
> and it also needed a fair amount of manual work to extract it and to 
> make it usable, so i guessed others might want to use the end result as 
> well, to try and generate large GIT repositories from them (or to run 
> analysis over the patches, etc.).

Has anyone already compared the (split/digested) content of the ChangeLog
file with the commit messages ? It raises the interesting question of
inserting the merge messages/patches in the sequence at the right place
but I'd like to know if someone met other issues.

--
Ueimor
