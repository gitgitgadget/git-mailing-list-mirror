From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Sat, 18 Aug 2007 11:57:57 +0200
Message-ID: <85fy2hupui.fsf@lola.goethe.zz>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>
	<20070816082110.GB16849@muzzle>
	<7vir7eh7mc.fsf@gitster.siamese.dyndns.org>
	<20070818090913.GA13936@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 11:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IML4P-0008Sz-9o
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 11:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXHRJ6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 05:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbXHRJ6I
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 05:58:08 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:50792 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713AbXHRJ6H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2007 05:58:07 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id ED4544C42A;
	Sat, 18 Aug 2007 11:58:05 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id D94172C6B79;
	Sat, 18 Aug 2007 11:58:05 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-041-107.pools.arcor-ip.net [84.61.41.107])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 9A38719B322;
	Sat, 18 Aug 2007 11:57:57 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1D5131C36605; Sat, 18 Aug 2007 11:57:57 +0200 (CEST)
In-Reply-To: <20070818090913.GA13936@soma> (Eric Wong's message of "Sat\, 18 Aug 2007 02\:09\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3982/Sat Aug 18 09:45:32 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56106>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Actually I do.  A major, if not primary, selling point of
>> git-svn has been that svn cannot do merges but if you import to
>> git you can, and I've had an impression that Sam's git-svn intro
>> alludes to this capability as well.
>
> Wow.  My primary reasons for git-svn are completely different: speed
> and offline usability; and merging was not so much a concern for me.
>
>> If I understand you correctly, your position is that the svn side
>> has the authoritative history when using git-svn, and we should
>> refuse to do anything on the git side that the resulting history in
>> svn cannot represent.  I know and respect that you have thought
>> about the issues involved long enough before that declaration of
>> defeat, but at the same time, I would really hope that we can come
>> up with a workable compromise to allow merge tracking on the git
>> side.
>
> Yes.  From what I gather, developers only use git-svn because they
> don't have enough swing within their group to replace SVN.

Not at all.  Subversion has _working_ subproject support (which is
rather easy, since every directory is treated the same and you can
merge at every level).  It also has other tools like "Trac".  And it
provides a _stable_ history and point of reference and backup.  While
I appreciate being able to create and undo almost any mess in my
personal git repository (and this happens not infrequently), I would
not want to propose that to everybody.

git-svn makes it possible for me to keep the mess that is git to
myself, and only expose others to the _results_ of my work with it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
