From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Sun, 21 May 2006 10:30:23 +0200
Organization: At home
Message-ID: <e4p8e8$uqt$2@sea.gmane.org>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun May 21 10:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhjKK-0007e2-QQ
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWEUIaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 21 May 2006 04:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWEUIaJ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:30:09 -0400
Received: from main.gmane.org ([80.91.229.2]:10978 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751505AbWEUIaH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 04:30:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhjK8-0007d0-TP
	for git@vger.kernel.org; Sun, 21 May 2006 10:30:04 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 10:30:04 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 10:30:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20439>

David K=E5gedal wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
[...]
>> So from the user's point of view, 'branch' is simply _named line of
>> development_. Refer to topic and tracking branches.
>=20
> But the definition of 'branch' in git is quite different from the
> definition in CVS or many other systems.  It CVS, each revision
> (commit) belongs to a branch, and the branch is a linear sequence of
> revisions, not a full DAG.  In git, a commit doesn't really "belong"
> in any specific branch.
>=20
> So, while it makes sense to describe branches as "lines of
> development" in general terms, it is also important to note the
> specific meaning of 'branch' in the context of git; i.e. as the
> history of a single head commit.

We can always say that branch is 1-st parent linear history of head bra=
nch,
up to unmarked but computable branching/fork/creation point, i.e.

  {i =3D 0..N: branch-head~i}

where N is the length of the branch.

BTW. HEAD~0 =3D=3D HEAD, isn't it?

--=20
Jakub Narebski
Warsaw, Poland
