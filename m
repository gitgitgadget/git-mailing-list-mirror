From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 16:29:53 +0530
Message-ID: <20110714162953.36347b76@shiva.selfip.org>
References: <20110714161508.2378c155@shiva.selfip.org>
	<1310640646.18730.10.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?UTF-8?B?TWFydMOtbg==?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jul 14 12:59:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJe8-0004hX-Q8
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 12:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab1GNK7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 06:59:52 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:33002
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754389Ab1GNK7v convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 06:59:51 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id D59232004001;
	Thu, 14 Jul 2011 12:59:48 +0200 (CEST)
In-Reply-To: <1310640646.18730.10.camel@bee.lab.cmartin.tk>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177113>

On Thu, 14 Jul 2011 12:50:46 +0200
Carlos Mart=C3=ADn Nieto <cmn@elego.de> wrote:

> On Thu, 2011-07-14 at 16:15 +0530, J. Bakshi wrote:
> > Hello list,
> >=20
> > During git push or fetch over http , I need to provide username and
> > password every time, as protected by apache htpasswd file. How can =
I
> > provide the same along with git command ? Or something so that It s=
ave
> > the authentication info somewhere within .git=20
>=20
> The http transport uses the ~/.netrc file to get its authentication
> data.  `man netrc` will tell you about the syntax; for git, you need =
the
> 'machine', 'login' and 'password' fields.
>=20
> Cheers,
>    cmn
>=20
>=20
>=20

Thanks for the response. Can I use the same .netrc to store different a=
uthentication for different repo ? Is it somehow possible to store the =
information at the concerned .git of the repo ? I think this will be ea=
sier for multiple repos.
