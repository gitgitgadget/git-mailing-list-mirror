From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 01:58:58 -0200
Message-ID: <20081125035858.GB25284@c3sl.ufpr.br>
References: <20081125003758.GA6115@zakalwe.fi> <940723.36955.qm@web37906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 05:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4pOJ-0001Xc-7s
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 05:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbYKYER4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2008 23:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbYKYERz
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 23:17:55 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:47925 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbYKYERz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 23:17:55 -0500
X-Greylist: delayed 1132 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Nov 2008 23:17:55 EST
Received: from localhost (unknown [189.32.58.161])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 420B1700003C9;
	Tue, 25 Nov 2008 01:58:59 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <940723.36955.qm@web37906.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101644>

On Mon, Nov 24, 2008 at 05:40:22PM -0800, Gary Yang wrote:
> How to tell "git daemon" only to publish /pub/git/pub/linux/kernel ?

$ man git-daemon

<snip>
It verifies that the directory has the magic file
       "git-daemon-export-ok", and it will refuse to export any git dir=
ectory
       that hasn=C2=B4t explicitly been marked for export this way (unl=
ess the
       --export-all parameter is specified). If you pass some directory=
 paths
       as git-daemon arguments, you can further restrict the offers to =
a
       whitelist comprising of those.
</snip>

Hope this helps

>=20
>=20
> --- On Mon, 11/24/08, Heikki Orsila <shdl@zakalwe.fi> wrote:
>=20
> > From: Heikki Orsila <shdl@zakalwe.fi>
> > Subject: Re: How to hide a git repository?
> > To: "Gary Yang" <garyyang6@yahoo.com>
> > Cc: git@vger.kernel.org
> > Date: Monday, November 24, 2008, 4:37 PM
> > On Mon, Nov 24, 2008 at 04:32:58PM -0800, Gary Yang wrote:
> > >=20
> > > We have two repositories, one is
> > /pub/git/dev/linux/kernel, another=20
> > > is /pub/git/pub/linux/kernel. The
> > /pub/git/pub/linux/kernel is open to=20
> > > public for people to download released code.
> > /pub/git/dev/linux/kernel=20
> > > is used for our development. We would like to hide=20
> > > /pub/git/dev/linux/kernel from public. How to do it?
> >=20
> > Tell "git daemon" only to publish
> > /pub/git/pub/linux/kernel.
> >=20
> > --=20
> > Heikki Orsila
> > heikki.orsila@iki.fi
> > http://www.iki.fi/shd
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=20
> > http://vger.kernel.org/majordomo-info.html
>=20
>=20
>      =20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Bruno Ribas - ribas@c3sl.ufpr.br
http://www.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br
