From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Fri, 03 Apr 2009 12:42:03 +0200
Message-ID: <87eiwakohw.fsf@krank.kagedal.org>
References: <20090329171347.GA26866@beczulka> <20090329222827.GA32199@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <porridge@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 12:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpgsg-0006Hl-AZ
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 12:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762904AbZDCKmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2009 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762342AbZDCKmX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 06:42:23 -0400
Received: from main.gmane.org ([80.91.229.2]:45924 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761553AbZDCKmW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 06:42:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lpgqn-0002U6-IA
	for git@vger.kernel.org; Fri, 03 Apr 2009 10:42:17 +0000
Received: from 87.96.142.66 ([87.96.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 10:42:17 +0000
Received: from davidk by 87.96.142.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 10:42:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.66
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:Dbym9TAc9Hhq9aSQHZQzSRKBxy4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115524>

Eric Wong <normalperson@yhbt.net> writes:

> Marcin Owsiany <porridge@debian.org> wrote:
>> Hello,
>>=20
>> I created my git repository by cloning it with git-svn from an upstr=
eam SVN
>> repository. When I did that, a branch "master" was created. Afterwar=
ds I
>> renamed that branch to "upstream". However every time I "git-svn fet=
ch", it
>> recreates the "master" branch, pointing it at the newest upstream co=
mmit.
>>=20
>> Ideally, I'd like it to just forget about "master" and do the same t=
o my
>> "upstream" branch. Is it possible?
>>=20
>> If not, then is it at least possible to have it not recreate the "ma=
ster"
>> branch? It clutters my view.
>
> "master" has been a git convention since the earliest days of git and
> it's less confusing to new users following documentation if it always
> exists (and a lot of users' first git experience is with git svn).
>
> Why not just use "master" as one of your branches?  It won't bite you=
=2E
> "git svn fetch" will never clobber your "master" if it already exists=
=2E

I also find this highly annoying. I use branch names that matches the
branches we use in svn. So when working on changes for the svn "foo"
branch, I have a git branch "foo" that is based on "svn/foo". And when
working on "bar" I use a "bar" branch and so on. A "master" branch has
no place in my workflow, and I keep deleteing it over and over again.

But mostly I just ignore it.

--=20
David K=C3=A5gedal
