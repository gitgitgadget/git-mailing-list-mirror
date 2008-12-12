From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: help needed: Splitting a git repository after subversion
	migration
Date: Fri, 12 Dec 2008 15:49:29 +0100
Message-ID: <20081212144929.GA27445@atjola.homenet>
References: <493C0AAD.1040208@intra2net.com> <200812101733.36221.thomas.jarosch@intra2net.com> <20081211081009.GA14639@atjola.homenet> <200812121522.38791.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 15:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB9Lu-0002qR-TC
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 15:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160AbYLLOtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Dec 2008 09:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757148AbYLLOtd
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 09:49:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:39629 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755031AbYLLOtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 09:49:32 -0500
Received: (qmail invoked by alias); 12 Dec 2008 14:49:30 -0000
Received: from i577BA41C.versanet.de (EHLO atjola.local) [87.123.164.28]
  by mail.gmx.net (mp007) with SMTP; 12 Dec 2008 15:49:30 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+p00Y9of2p0w3weHt9T9FUggsaJ6DLGi7+ZMl3Kp
	tb5R/RE5KXOxqc
Content-Disposition: inline
In-Reply-To: <200812121522.38791.thomas.jarosch@intra2net.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102900>

On 2008.12.12 15:22:15 +0100, Thomas Jarosch wrote:
> On Thursday, 11. December 2008 09:10:09 you wrote:
> > > Now I'll manually check the history of the tags/ and branches/ fo=
lder
> > > for more funny tags and write down the revision. If I understood
> > > the git-svn man page correctly, I should be able to specifiy
> > > revision ranges it's going to import. I'll try to skip the broken=
 tags.
> >
> > As long as the breakage only involves branches/tags that are comple=
tely
> > useless, it's probably a lot easier to just delete them afterwards.
> >
> > And if you accidently added changes to a tag, after it was created,=
 it's
> > also easier to manually tag to right version in git, and just forge=
tting
> > about the additional commit.
> >
> > And for a bunch of other cases, rebase -i/filter-branch are probabl=
y
> > also better options ;-)
> >
> > Skipping revisions in a git-svn import sounds rather annoying and
> > error-prone.
>=20
> Sounds very reasonable. When I'm done filtering with filter-branch,
> the original commits are still stored in "refs/originals" and the ref=
logs.
> What's the best way to get rid of those to free up the space?

See the "purging unwanted history" thread:

http://n2.nabble.com/purging-unwanted-history-td1507638.html

The commands there (starting with the "git for-each-ref") should clean
out all the pre-filter-branch stuff.

> A nice way to find the corresponding commit for a file can be found h=
ere:=20
> http://stackoverflow.com/questions/223678/git-which-commit-has-this-b=
lob

Yeah, I think something similar (or even the same?) is in the git wiki
somewhere. I never had any use for it though ;-)

Bj=F6rn
