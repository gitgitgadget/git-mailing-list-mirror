From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Per-remote tracking branch
Date: Thu, 24 Sep 2009 13:35:37 +0200
Message-ID: <20090924113537.GA14113@atjola.homenet>
References: <vpq4or48bux.fsf@bauges.imag.fr>
 <20090924112550.GA6540@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 24 13:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqmc4-0006tL-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 13:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZIXLfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZIXLfm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 07:35:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:59011 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751564AbZIXLfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 07:35:39 -0400
Received: (qmail invoked by alias); 24 Sep 2009 11:35:41 -0000
Received: from i59F56041.versanet.de (EHLO atjola.homenet) [89.245.96.65]
  by mail.gmx.net (mp012) with SMTP; 24 Sep 2009 13:35:41 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18XMc9xkAQXTRZMGHoWcabascmNvrqr1LXSUNw3V2
	6ltcNCAajggvz9
Content-Disposition: inline
In-Reply-To: <20090924112550.GA6540@atjola.homenet>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129038>

On 2009.09.24 13:25:50 +0200, Bj=F6rn Steinbrink wrote:
> On 2009.09.15 17:29:58 +0200, Matthieu Moy wrote:
> > At the moment, I can configure a tracking branch to let me just typ=
e
> >=20
> > $ git pull
> >=20
> > when I want to say
> >=20
> > $ git pull origin master
> >=20
> > Now, assume I have another remote "foo", I'd like to be able to jus=
t
> > say
> >=20
> > $ git pull foo
> >=20
> > and put something in my .git/config so that Git knows I mean
> >=20
> > $ git pull foo master
> >=20
> > Is there a simple way to do that?
>=20
> Setup "foo" so that it fetches "master" only, i.e. have
> remote.foo.fetch =3D refs/heads/master:refs/remotes/foo/master
>=20
> You get that setup with: git remote add -t master foo git://...
>=20
> Then there's only one possible choice for "git pull", and it will tak=
e
> that.

Ah, crap, spoke too soon. That works only when branch.<name>.merge is
not set. Though that's not that much of a problem. When your "primary"
remote (the one set for branch.<name>.remote) also fetches just a singl=
e
branch, "git pull" will still work, even if branch.<name>.merge is not
set.

Bj=F6rn
