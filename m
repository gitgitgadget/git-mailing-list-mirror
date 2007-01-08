From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [1/2 PATCH] git-svn: make multi-init less confusing
Date: Mon, 08 Jan 2007 13:58:52 +0100
Message-ID: <87hcv1r7xv.fsf@morpheus.local>
References: <87fyaqvgoz.fsf@morpheus.local> <20070105020158.GA21925@localdomain> <871wmaugh6.fsf@morpheus.local> <m2ejq9trf1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 08 14:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3u6y-0004xL-FU
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbXAHNAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 Jan 2007 08:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbXAHNAV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:00:21 -0500
Received: from main.gmane.org ([80.91.229.2]:35931 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161269AbXAHNAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:00:21 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H3u6c-0005ur-Ci
	for git@vger.kernel.org; Mon, 08 Jan 2007 14:00:02 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 14:00:02 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 14:00:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:A7Oax9HhtLYBjnsGXcOrASzxFBU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36250>

Seth Falcon <sethfalcon@gmail.com> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> Now if you could only clarify the documentation of dcommit to explai=
n
>> whether it creates one svn revision per commit in your branch, or if
>> it creates a single svn revision with the full diff, and the
>> documentation would be perfect :-)
>
> dcommit creates one svn rev for each commit listed by:
>
>    git log remotes/git-svn..HEAD

So if I want to commit a different subset, is that possible?  In my
case, I have a "master" branch with a few changes on top of git-svn
that I never want to commit to svn.  So what I want is to commit
"master..HEAD".  Can I do that with dcommit?  It seems that "git svn
set-tree master..HEAD" might do the trick.

--=20
David K=C3=A5gedal
