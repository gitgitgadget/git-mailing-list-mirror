From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Per-remote tracking branch
Date: Thu, 24 Sep 2009 13:25:50 +0200
Message-ID: <20090924112550.GA6540@atjola.homenet>
References: <vpq4or48bux.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 24 13:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqmSX-0003ax-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 13:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZIXLZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 07:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZIXLZw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 07:25:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:58430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751674AbZIXLZw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 07:25:52 -0400
Received: (qmail invoked by alias); 24 Sep 2009 11:25:54 -0000
Received: from i59F56041.versanet.de (EHLO atjola.homenet) [89.245.96.65]
  by mail.gmx.net (mp041) with SMTP; 24 Sep 2009 13:25:54 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/H0GNWiVHHrEEZ8qtTtFovNDeuQ8nDdnY0zqANfY
	C+/BQb008NXGAG
Content-Disposition: inline
In-Reply-To: <vpq4or48bux.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129037>

On 2009.09.15 17:29:58 +0200, Matthieu Moy wrote:
> Hi,
>=20
> Is there a way, with Git, to specify a tracking branch on a per-remot=
e
> basis?
>=20
> At the moment, I can configure a tracking branch to let me just type
>=20
> $ git pull
>=20
> when I want to say
>=20
> $ git pull origin master
>=20
> Now, assume I have another remote "foo", I'd like to be able to just
> say
>=20
> $ git pull foo
>=20
> and put something in my .git/config so that Git knows I mean
>=20
> $ git pull foo master
>=20
> Is there a simple way to do that?

Setup "foo" so that it fetches "master" only, i.e. have
remote.foo.fetch =3D refs/heads/master:refs/remotes/foo/master

You get that setup with: git remote add -t master foo git://...

Then there's only one possible choice for "git pull", and it will take
that.

Bj=F6rn
