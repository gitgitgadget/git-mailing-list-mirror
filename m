From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 00:30:18 +0100
Organization: At home
Message-ID: <eojn5c$v9u$1@sea.gmane.org>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 00:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6xkm-0006nd-CQ
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 00:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXAPX37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 18:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbXAPX37
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 18:29:59 -0500
Received: from main.gmane.org ([80.91.229.2]:51766 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbXAPX36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 18:29:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6xka-0006Nr-Dk
	for git@vger.kernel.org; Wed, 17 Jan 2007 00:29:56 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 00:29:56 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 00:29:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36983>

Yann Dirson wrote:

> On Tue, Jan 16, 2007 at 10:42:17PM +0000, Catalin Marinas wrote:

>>>The idea is that we pull our stack from one place (current base) to
>>>another. =A0Another possiblity would have been "stg rebase", but I'm=
 not
>>>very keen on adding another command to do a very similar job.
>>=20
>> Can you give a typical example of what <newbase> argument for --to i=
s
>> and what you repository looks like? I just want make sure I correctl=
y
>> understand the problem.
>=20
> My example is quite similar to the one given by Guilhem: I had a git
> branch coming from git-cvsimport, and my stgit stack forked atop that
> branch. =A0At some point git-cvsimport fucked something, and I
> regenerated a new mirror branch using it in a fresh repo. =A0Then I
> wanted to rebase my stack on that new branch.

I'm all for calling this command "stg rebase". Currently you can do
"stg push -a; stg commit -a; git rebase; stg uncommit -n <n>"...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
