From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git rescue mission
Date: Fri, 09 Feb 2007 00:38:21 +0100
Organization: At home
Message-ID: <eqgc69$8i3$1@sea.gmane.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <17867.40122.51865.575762@lisa.zopyra.com> <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org> <17867.45437.922483.805945@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 00:37:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIp7-0005Iq-82
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965645AbXBHXgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 18:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965660AbXBHXgz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:36:55 -0500
Received: from main.gmane.org ([80.91.229.2]:59617 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965645AbXBHXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:36:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFIou-0003Ow-OC
	for git@vger.kernel.org; Fri, 09 Feb 2007 00:36:52 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 00:36:52 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 00:36:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39127>

<opublikowany i wys=B3any>

Bill Lear wrote:

> On Thursday, February 8, 2007 at 14:13:47 (-0800) Linus Torvalds writ=
es:
>>...
>> It's one of the bigger UI warts that got fixed since the last releas=
e=20
>> (although it got fixed by better config management, and as such you'=
ll=20
>> only *see* the fixes if you end up doing the initial clone with the =
new=20
>> git version - if you use a new git version with an old repo, many - =
but=20
>> not all - bad semantics will remain).
>> ...
>=20
> With regard to the new version and old repos, am I correct in assumin=
g
> that we can upgrade our old repo (a bare one) to the new git by first
> installing the new git, and then doing this:
>=20
> % cd /repos/git
> % mv project project.old_git
> % git --bare clone project.old_git project

  % git clone --bare project.old_git project

although usually notation project.git is used, so I think it would be

  % git clone --bare project.old_git project.git

"git --bare <cmd>" is equivalent to "git --git-dir=3Dpwd". You want to =
make
bare clone "git clone --bare", not invoke git command in bare repositor=
y
"git --bare <cmd>": there is no repository yet!

You can just edit .git/config (prehaps generate it first
from .git/remotes/origin file using remotes2config.sh script from contr=
ib
section), and move (rename) branches.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
