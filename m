From: David Kastrup <dak@gnu.org>
Subject: Re: What's in git.git (stable)
Date: Sat, 11 Aug 2007 11:32:01 +0200
Message-ID: <85hcn6xvqm.fsf@lola.goethe.zz>
References: <7vir7mo42w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 11:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJnKP-0006up-Mk
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 11:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbXHKJcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 05:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512AbXHKJcE
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 05:32:04 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:53740 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755496AbXHKJcD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 05:32:03 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 6B8D92DD78D;
	Sat, 11 Aug 2007 11:32:02 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 55C9B2C6A03;
	Sat, 11 Aug 2007 11:32:02 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 317658C469;
	Sat, 11 Aug 2007 11:32:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C99141C3C79D; Sat, 11 Aug 2007 11:32:01 +0200 (CEST)
In-Reply-To: <7vir7mo42w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 11 Aug 2007 01\:41\:59 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3923/Sat Aug 11 10:03:45 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55596>

Junio C Hamano <gitster@pobox.com> writes:

> I thought we were pretty in good shape and in a nice and quiet
> freeze period.
>
> Until a few days ago.
>
> Then suddenly, flurry of activity happened.  A few performance
> issues were raised and fixed:

The fix to git-filter-branch I posted is tested and obviously
necessary (without it, git-filter-branch will only work if GIT_DIR is
set previously to calling it).

Also documentation and usage of git-filter-branch are out of kilter,
the given examples for wiping a file from history don't work,
specifing the refs to work on reacts impredictably (it is not clear
what gets accepted and what not, and one seemingly has to always
specify "HEAD" which is basically ignored).

Could you ask Dscho to consider adding cases based on the
documentation to the test suite?  That should help weed out the worst
discrepances.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
