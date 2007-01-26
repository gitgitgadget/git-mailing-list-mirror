From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to change merge message ("weenie commits")
Date: Fri, 26 Jan 2007 13:54:17 +0100
Organization: At home
Message-ID: <epctjl$vrv$1@sea.gmane.org>
References: <17848.54065.631799.755255@lisa.zopyra.com> <20070125161609.GA7453@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 13:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAQah-00074s-Tg
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 13:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXAZMxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 07:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbXAZMxg
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 07:53:36 -0500
Received: from main.gmane.org ([80.91.229.2]:39235 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbXAZMxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 07:53:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAQa7-0006T5-GZ
	for git@vger.kernel.org; Fri, 26 Jan 2007 13:53:27 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 13:53:27 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 13:53:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37850>

Karl Hasselstr=F6m wrote:

> On 2007-01-25 09:56:33 -0600, Bill Lear wrote:
>=20
>> Do others run into this and perhaps have a good solution?
>=20
> I make lots of small commits, then periodically rewrite history with
> StGIT to get the nice-looking set of commits I wish I had made in the
> first place. I don't think I do anything that couldn't be done with
> just git, but StGIT is made precisely for this kind of work, and is
> quite good at it.

If you want to use only core git, "git cherry-pick" (with or without
--no-commit option), "git commit --amend" and "git merge --squash"
(and probably "git rebase --onto") are your friends. You can also
do "git format-patch", edit/reorder patches and then "git am --3way"
or "git apply".

But StGIT is made for this work. I use it to reorder commits, to
amend commit deeper in the history, to split and join commits (although
it is more work, at least with version I use). If you have branch which
is currently not managed by StGIT, "stg init" and then use "stg uncommi=
t".
I frequently use "stg uncommit" and "stg pop"/"stg push" to add commit
in the middle of branch.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
