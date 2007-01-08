From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [1/2 PATCH] git-svn: make multi-init less confusing
Date: Mon, 08 Jan 2007 14:11:21 +0100
Message-ID: <877ivxr7d2.fsf@morpheus.local>
References: <87fyaqvgoz.fsf@morpheus.local> <20070105020158.GA21925@localdomain> <871wmaugh6.fsf@morpheus.local> <m2ejq9trf1.fsf@gmail.com> <87hcv1r7xv.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 08 14:12:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uHp-0007hP-Iy
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbXAHNLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 Jan 2007 08:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbXAHNLe
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:11:34 -0500
Received: from main.gmane.org ([80.91.229.2]:42709 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161268AbXAHNLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:11:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H3uHf-0007pI-Lz
	for git@vger.kernel.org; Mon, 08 Jan 2007 14:11:27 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 14:11:27 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 14:11:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:m0v5405uFVMKs2w2kkvUpXj1mN0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36252>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Seth Falcon <sethfalcon@gmail.com> writes:
>
>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>> Now if you could only clarify the documentation of dcommit to expla=
in
>>> whether it creates one svn revision per commit in your branch, or i=
f
>>> it creates a single svn revision with the full diff, and the
>>> documentation would be perfect :-)
>>
>> dcommit creates one svn rev for each commit listed by:
>>
>>    git log remotes/git-svn..HEAD
>
> So if I want to commit a different subset, is that possible?  In my
> case, I have a "master" branch with a few changes on top of git-svn
> that I never want to commit to svn.  So what I want is to commit
> "master..HEAD".  Can I do that with dcommit?  It seems that "git svn
> set-tree master..HEAD" might do the trick.

I tried set-tree now, and all I got was a perl crash:

morpheus% git svn set-tree master..
diff-tree 8dba2b29df78184fef96bbbf9521387846b140b3 b5561ab7309e9b7b3acf=
acaa786358e7d90665c6
        A       .gitignore
=2E.. more files
Use of uninitialized value in concatenation (.) or string at /usr/lib/p=
erl5/SVN/Core.pm line 579.
Malformed file:  at /usr/local/bin/git-svn line 459

This is git f4bf2184ae8b79f95b9f56c1ea5455d04e559299 from Jan 1.

Perl is v5.8.8 (Ubunty edgy)

--=20
David K=C3=A5gedal
