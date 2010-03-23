From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git rev-list formatting
Date: Tue, 23 Mar 2010 07:06:38 -0400
Message-ID: <m3ocifnvpd.fsf@winooski.ccs.neu.edu>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
	<4BA7A75A.6060909@lsrfire.ath.cx>
	<m31vfbpzol.fsf@winooski.ccs.neu.edu>
	<4BA89D88.7080803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 12:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu22o-0000i5-7V
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 12:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab0CWLHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 07:07:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:48433 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab0CWLHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 07:07:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nu1wt-00060W-25
	for git@vger.kernel.org; Tue, 23 Mar 2010 12:07:03 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 12:07:03 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 12:07:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:v3o1YBMblu3FPOdYJZbqBXUxDno=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143006>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Eli Barzilay venit, vidit, dixit 23.03.2010 02:57:
>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>=20
>>> Am 22.03.2010 12:30, schrieb Eli Barzilay:
>>>> Possible bug -- IIUC, this:
>>>>
>>>>   git rev-list --pretty=3D"%w(40,2,2)%b" $rev
>>>>
>>>> should show all bodies wrapped as specified, but with 1.7.0.3 I se=
e
>>>> only the first one wrapped, and the rest don't show up.  In one of=
 my
>>>> attempts to sort this, I saw all bodies, but all bodies after the
>>>> first were not wrapped as specified.
>>>
>>> I can't reproduce this when running this command against git's own
>>> repo.  Or perhaps I just fail to see it.  Is the one you're trying
>>> this on public?  Does it work as expected with some other version o=
f
>>> git?
>>=20
>> Sorry, I've lost track of all the different things I tried, but here=
's
>> something that I can reproduce reliably now, which seems to be a
>> similar problem (or at least nothing in the man page explain why it
>> would do what it does).  If this is helpful, I'll tar up the
>> repository and put it up somewhere.  This is all running in the repo
>> -- and it case it matters, it's a bare repo, created with 1.7.0.
>
> I'd say that certainly matters (can't reproduce this one on non-bare
> either).
>
> When you say "in the repo", do you mean that you're current
> directory is within yourbarerepo.git?

Yes.


> Do you have GIT_DIR set explicitly?

No.


> [...]

I've made a copy of the repository at

  http://tmp.barzilay.org/testing.git.tgz

which shows what I said when I run

  git rev-list --pretty=3D"%b" 267d60518
  git rev-list --pretty=3D"%b" 84482

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
