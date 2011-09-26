From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Mon, 26 Sep 2011 11:03:59 -0700 (PDT)
Message-ID: <m37h4vp4f0.fsf@localhost.localdomain>
References: <4E7CCCA0.50909@gmail.com>
	<14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
	<op.v2byz2p80aolir@keputer.lokaal>
	<1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
	<201109242259.p8OMxqIM026259@no.baka.org>
	<1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
	<m31uv4rc47.fsf@localhost.localdomain>
	<1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net>
	<m3oby8pcfz.fsf@localhost.localdomain>
	<1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net>
	<20110926003447.GG10955@localhost.localdomain>
	<1aec7c1qq0n56.sxybjnsj6ngr$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 20:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8FXF-0002dR-9b
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab1IZSEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 14:04:04 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60169 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1IZSEC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 14:04:02 -0400
Received: by eya28 with SMTP id 28so3834792eya.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=FEf0SMQbXt560ZhMb309e6cNk9Xo8Mce9xV6awtvXrU=;
        b=phAKpolJWVHv5Gf3PuLP2jqtzZ6JPFSZx7eYLyjJTlsg1uBOw1UFKIQtiwlXD0jKcW
         qMl7dB+kBGRcpp3yyE02wC4T9wQ/J3yF1uQ22QSLq+m6HS+JWPWLrMn13jcSEPLm4eob
         6bOhfCQ0bsii7pwqOU6oKYD+RhQXOhHPxU7Xc=
Received: by 10.14.6.205 with SMTP id 53mr2213464een.132.1317060240578;
        Mon, 26 Sep 2011 11:04:00 -0700 (PDT)
Received: from localhost.localdomain (abwm119.neoplus.adsl.tpnet.pl. [83.8.236.119])
        by mx.google.com with ESMTPS id z54sm62542105eef.2.2011.09.26.11.03.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 11:03:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8QI3Wg3009209;
	Mon, 26 Sep 2011 20:03:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8QI3Ge6009199;
	Mon, 26 Sep 2011 20:03:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1aec7c1qq0n56.sxybjnsj6ngr$.dlg@40tude.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182143>

tactical <a5158017@nepwk.com> writes:
> Konstantin Khomoutov wrote:
>=20
>>>>> From what I read, detached heads are subject to garbage collectio=
n.
>>>> =20
>>>> No, HEAD is protected against garbage collecting.  To be sure you
>>>> should name a branch when switching branches, though reflog would
>>>> protect you for 30 days (by default) even if you don't do that.
>>>=20
>>> So Git doesn't really support anonymous branching as part of a norm=
al
>>> workflow.
>>=20
>> I perceive a certain logical fallacy here: you cannot switch between
>> anything anonymous because to switch, you should somehow identify
>> something to switch to--a name in whatever sense we put into this wo=
rd.
>=20
> In Mercurial, you can just update to a particular changeset (and you
> identify that changeset by repository-local revision number or global=
ly
> unique ID) and then commit again.  The point is that there's no need =
to
> give a label to a head in Mercurial (although you can if you want to,=
 using
> Mercurial bookmarks, which are basically the same as what Git uses).
>=20
> Here's an example of anonymous branching:
>=20
>     c:\test>hg init
>=20
>     c:\test>echo test>foo
>=20
>     c:\test>hg commit --addremove -m initial
>     adding foo
>=20
>     c:\test>echo first>>foo
>=20
>     c:\test>hg commit -m first
>=20
>     c:\test>hg log
>     changeset:   1:3e895ec28d6c
>     tag:         tip
>     user:        tactical
>     date:        Mon Sep 26 01:39:46 2011 +0100
>     summary:     first
>=20
>     changeset:   0:b51644bb3450
>     user:        tactical
>     date:        Mon Sep 26 01:39:40 2011 +0100
>     summary:     initial
>=20
>     c:\test>hg update 0
>     1 files updated, 0 files merged, 0 files removed, 0 files unresol=
ved
>=20
>     c:\test>echo second>>foo
>=20
>     c:\test>hg commit -m second
>     created new head
>=20
>     c:\test>hg glog
>     @  changeset:   2:35c82a7e7de1
>     |  tag:         tip
>     |  parent:      0:b51644bb3450
>     |  user:        tactical
>     |  date:        Mon Sep 26 01:40:10 2011 +0100
>     |  summary:     second
>     |
>     | o  changeset:   1:3e895ec28d6c
>     |/   user:        tactical
>     |    date:        Mon Sep 26 01:39:46 2011 +0100
>     |    summary:     first
>     |
>     o  changeset:   0:b51644bb3450
>        user:        tactical
>        date:        Mon Sep 26 01:39:40 2011 +0100
>        summary:     initial
>=20
> I now have two anonymous branches, and these will never be garbage
> collected.  I can easily update to either branch with "hg update 1" o=
r "hg
> update 2" (or "hg update 0" again, if i want to create yet another
> anonymous branch).

In my opinion the need to examine either log ('hg glog') or heads
('hg heads'?) to see how to switch to anonymous branch is a PITA
that far outweights the need to name branches (to give a temporary,
local-only branch name) in Git.
=20
Nb. by using "detached HEAD" for anonymous branch I meant the
following:

  $ git checkout --detach
  $ ...
  $ <work on detached head>

  worth saving?

  Y. $ git branch -b t foo/temp
     $ git checkout <other branch>
   =20
  N. $ git checkout <other branch>

> > The branch names is just a way to not mess with
> > SHA-1 names of commits (and to have references to those commits to =
keep
> > them out of consideration for garbage collection).
> > Hence the idea to demand support for anonymous branches in Git's mo=
del
> > is just unfounded.
>=20
> I think it's simply a weakness of Git.  There are zero problems with
> anonymous branching in Mercurial, and it's a very powerful and simple
> system.
=20
IMVVVHO it is just remains of bad initial design decision of Mercurial
about representing branches ;-PPPPPPP

Only now Mercurial has something (transferable bookmarks) which
approaches flexibility and usability of Git branches.  It took them
how long... and even then there is a [supposedly] user-friendly but
flexibility-reducing notion that branch (bookmark) names are global.


Not that Git didn't and doesn't have its share of bad design decisions
(like autimatically committing a merge).

--=20
Jakub Nar=EAbski
