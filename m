From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Branches with git-svn
Date: Fri, 19 Sep 2008 15:10:45 +0200
Message-ID: <20080919131045.GA14301@atjola.homenet>
References: <1221819302.6784.4.camel@zdra-laptop> <48D39C7B.9020709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Xavier Claessens <xclaesse@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 15:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgfmA-0006no-Ma
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYISNKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYISNKt
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:10:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:41071 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751026AbYISNKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:10:49 -0400
Received: (qmail invoked by alias); 19 Sep 2008 13:10:46 -0000
Received: from i577B8FFC.versanet.de (EHLO atjola.local) [87.123.143.252]
  by mail.gmx.net (mp046) with SMTP; 19 Sep 2008 15:10:46 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18y/qwdLdsyDnM4o4TvTBcnfeydU/cqStAY9Rre5L
	2JIGMUuPhRAYfD
Content-Disposition: inline
In-Reply-To: <48D39C7B.9020709@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96283>

On 2008.09.19 14:35:07 +0200, Michael J Gruber wrote:
> Xavier Claessens venit, vidit, dixit 19.09.2008 12:15:
> > I created a git repository using "git-svn clone <url>" a long time =
ago.
> > But now I realise that I don't get SVN branches into my git reposit=
ory.
> > I see that the doc tells to use "git clone -t tags -b branches -T t=
runk
> > <url>" to create the repository. If I create a new repository with =
that
> > command, I get branches and tags.
> >=20
> > However I have lots of contributors having branches based on my git
> > repository. Is there a way to add SVN branch to my existing git rep=
o?
>=20
> If you haven't use those options back then, then what was the svn rep=
o
> structure - no trunk, just main?
> Did you change the structure now?

No, he was just using "git svn clone svn://host/repo/trunk", ie. single
branch tracking. We solved that on #git, adjusting the url and fetch
line, as well as adding the branches and tags line in the svn-remote
section in the config.

Bj=F6rn
