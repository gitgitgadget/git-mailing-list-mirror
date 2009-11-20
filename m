From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 01:49:18 +0100
Message-ID: <200911200149.19528.jnareb@gmail.com>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091119074226.GA23304@atjola.homenet> <00d401ca6954$a29fa020$e7dee060$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, B.Steinbrink@gmx.de,
	"'Jason Sewall'" <jasonsewall@gmail.com>,
	'Jan =?iso-8859-1?q?Kr=FCger=27?= <jk@jk.gs>, torvalds@osdl.org
To: "George Dennie" <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 01:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBHgr-0004wA-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 01:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbZKTAtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 19:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbZKTAtW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 19:49:22 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57564 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZKTAtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 19:49:21 -0500
Received: by bwz27 with SMTP id 27so2986823bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 16:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6lR++SX0dLTakgU2ggjvWCwwEL5IwDjlDmbPFZcCtBE=;
        b=LqxIOSSlC0Q2GIwhSwYlxwCfix4itUi3Y/4BoWU/Ak0kGosstdFya+3QP4t1Eot7o6
         /r+8it0Oro4cOTWi5ay1z9CuqWS54ekZXAR8y5wpfJUoFBLX+wGKL8EsVZBknBNC67aE
         pdTkTmObYgehwHfNg9WyXPYptV78k/VA4CIj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ivpjQBh0s9dMeOgVtgpOO5RMhRnIDNsM/vWVf1DPxlamDQasamGlqDEuxmFXa+E7Ys
         esMnZLZ5va9HrSSRbXpZpFiN2I5AdVPBIYy4/5m7XsrpkOvJiliFRGOa7ZOhWzd2r+xs
         Mtm/jvc/NZVCmbTXzL4t+0CcwQ0dI5DRCDm0A=
Received: by 10.204.154.131 with SMTP id o3mr725723bkw.66.1258678166559;
        Thu, 19 Nov 2009 16:49:26 -0800 (PST)
Received: from ?192.168.1.13? (abvw68.neoplus.adsl.tpnet.pl [83.8.220.68])
        by mx.google.com with ESMTPS id 16sm387235fxm.0.2009.11.19.16.49.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 16:49:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <00d401ca6954$a29fa020$e7dee060$@com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133271>

On Thu, 19 Nov 2009, George Dennie wrote:

> Thanks Jakub Narebski and Bj=F6rn Steinbrink...Nice description Bj=F6=
rn.
>=20
> I think an important piece of conceptual information missing from the=
 docs
> is a concise list of the conceptual properties defining the context o=
f the
> working tree, index, and repository during normal use. This itemizati=
on
> would go far in explaining the synergies between the various commands=
=2E

If you didn't find sufficient description of underlying concepts behind
git in "Git User's Manual" (distributed with Git), "Git Community Book"
or "Pro Git", take a look at the following documents:

 * "Git for Computer Scientists"
 * "Git From Bottom's Up"
 * "The Git Parable"

> Functionally, all the commands merely manipulate these properties. If=
 these
> properties were summarize in context one would expect that would repr=
esent a
> very complete functional model of Git. A user could review the descri=
ption
> figure what they wanted to do and then find the command(s) to accompl=
ish it.

I disagree.  While understanding underlying concepts of Git helps with
finding a way to get what one wants to achieve, I don't think that the =
way
presented here would work in practice.

> Presently this knowledge is accreted over time as oppose to merely be=
ing
> read and in the space of a few minutes "groked" (of course it could b=
e that
> I am particularly limited :).

It is documented, see referenced mentioned above.

> For example, towards a functional model, is this close? (note: all
> properties can be blank/empty)...
>=20
> REPOSITORIES
> 	Collection of Commits

Direct Acyclic Graph of Commits, where edges in graph point from commit
to zero or more its parents.

> 	Collection of Branches
> 		-- collection of commits without children

Errr... what?  Commit doesn't *have* [pointer to] children.  Also branc=
h
can point to commit for which there exists other commit which has given
commit as parent (up-to-date or fast-forward situation, e.g.)


    a---b---c            <--- branch_a
             \
              \-d---e    <--- branch_b

Branches (or branch heads / branch tips) are named references into DAG
of commits, points where DAG of commits grow.

> 		-- as a result each commits either augments
> 		-- and existing branch or creates a new one

Commits do not create a new branch.  New commits must be crated on
existing branch (or on unnamed branch aka detached HEAD, but that is
advanced usage).

> 	Master Branch
> 		-- typically the publishable development history

TANSTAAMB. There ain't such thing as a master branch. ;-)))))

Well, at least not in a sense of there being a branch that is a trunk
branch distinguished by _technical_ means.

>=20
> INDEX
> 	Collections of Parent/Merge Commits
> 		-- the commit will use all these as its parent

No.  The index is set of versions of files (blobs) that would go as
a contents (tree) of a next commit (if you use "git commit', not=20
"git commit -a").

>=20
> 	Staged Commit=20
> 		-- these changes are shown relative to the working tree

Errr.... what?

>=20
> 	Default Branch
> 		-- the history the staged commit is suppose to augment

Errr... what?

If by "default branch" you mean "current branch", it is currently check=
ed
out branch, where new commit would go, pointed by HEAD symbolic referen=
ce.


> WORKING_TREE
> 	Collection of Files and Folders
> =09
>=20
> As far as I can tell, the working tree is not suppose to be stateful,=
 but it
> seems the commands treat it as such.

Stateful?

Working tree / working area is a working area.  It can be disconnected =
from
repository via core.worktree, --work-tree option and GIT_WORK_TREE=20
environment, see also contrib/workdir/git-new-workdir


> Again, thanks for your patients.

patience.

--=20
Jakub Narebski
Poland
