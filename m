From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Fri, 19 May 2006 08:53:37 +0200
Message-ID: <87y7wyv72m.fsf@morpheus.hq.vtech>
References: <e4f1ta$e07$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri May 19 09:50:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzkV-000105-HO
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWESHuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 May 2006 03:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWESHuH
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:50:07 -0400
Received: from main.gmane.org ([80.91.229.2]:46011 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932138AbWESHuF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 03:50:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgzkF-0000w4-4A
	for git@vger.kernel.org; Fri, 19 May 2006 09:49:59 +0200
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 May 2006 09:49:59 +0200
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 May 2006 09:49:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:YvHzW9ycOpr0t6XormUff6/XGxA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20334>

Jakub Narebski <jnareb@gmail.com> writes:

> In #git channel somebody asked about 'branches' and 'heads' and was r=
eferred
> to the glossary. I had taken then a look at appropriate glossary entr=
ies.
>
> In 'Documentation/glossary.txt' we have:
> ---- =20
> branch::
>         A non-cyclical graph of revisions, i.e. the complete history =
of
>         a particular revision, which is called the branch head. The
>         branch heads are stored in `$GIT_DIR/refs/heads/`.

[...]

> It is just me or the glossary entry for `branch` is unnecessary=20
> complicated?=20
>
> Let's take a look at other definitions:
>
>   In software engineering, 'branch' is a separate line of development=
, which=20
>   among others allows development on a project to diverge in two dire=
ctions,=20
>   such as a stable and a development version. (WikiPedia:Branch)
>
>   In the CVS team development environment, a separate line of develop=
ment=20
>   where changes can be isolated. When a programmer changes files on=20
>   a branch, those changes do not appear on the main trunk=20
>   or other branches. (cvs.info)
>
> So from the user's point of view, 'branch' is simply _named line of
> development_. Refer to topic and tracking branches.

But the definition of 'branch' in git is quite different from the
definition in CVS or many other systems.  It CVS, each revision
(commit) belongs to a branch, and the branch is a linear sequence of
revisions, not a full DAG.  In git, a commit doesn't really "belong"
in any specific branch.

So, while it makes sense to describe branches as "lines of
development" in general terms, it is also important to note the
specific meaning of 'branch' in the context of git; i.e. as the
history of a single head commit.

I noticed that some of this seems to be changing slightly with the
introduction of branch logs, but I don't know how those are supposed
to be used yet.

--=20
David K=E5gedal
