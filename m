From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 19:00:19 +0200
Message-ID: <85r6mjdyl8.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804120243.GB9716@coredump.intra.peff.net>
	<85tzrfh3yg.fsf@lola.goethe.zz>
	<8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Lars Hjemli" <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMzJ-0001Ea-Se
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbXHDRAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbXHDRAX
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:00:23 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:55528 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932128AbXHDRAW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 13:00:22 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 9F54815BFD7;
	Sat,  4 Aug 2007 19:00:20 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 90A502C6A1A;
	Sat,  4 Aug 2007 19:00:20 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 5905B13237;
	Sat,  4 Aug 2007 19:00:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6A59F1C4F932; Sat,  4 Aug 2007 19:00:19 +0200 (CEST)
In-Reply-To: <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com> (Lars Hjemli's message of "Sat\, 4 Aug 2007 15\:07\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54883>

"Lars Hjemli" <lh@elementstorage.no> writes:

> The magic setup that makes this happen is the following lines in .git/config:
>
> [remote "origin"]
>         url = git://git.kernel.org/pub/scm/git/git.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>
>
> Was this helpful?

It would be helpful.  Except that nothing whatsoever can be found in
.git/config concerning my local and my remote tracking branches.  So
where is that information _really_ hidden away?

.git/FETCH_HEAD maybe?

It also appears that doing

git-checkout --track -b mybranch origin

on a git.git clone does _not_ create a tracking branch.  I can't
figure out what I could specify as an origin to create a tracking
branch that would get reflected in .git/FETCH_HEAD.

What gives?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
