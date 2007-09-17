From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: git-archive not working correctly ?
Date: Mon, 17 Sep 2007 02:31:15 +0200
Message-ID: <20070917003115.GV22865@planck.djpig.de>
References: <1189983026.22727.61.camel@niki2.guldbrand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Niki Guldbrand <niki.guldbrand@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 02:31:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX4WS-0007ne-9s
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 02:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbXIQAbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 20:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbXIQAbY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 20:31:24 -0400
Received: from planck.djpig.de ([85.10.192.180]:4026 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbXIQAbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 20:31:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id D7C3788102;
	Mon, 17 Sep 2007 02:31:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGzPF9J5R9tx; Mon, 17 Sep 2007 02:31:15 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id AEC3988105; Mon, 17 Sep 2007 02:31:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1189983026.22727.61.camel@niki2.guldbrand.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58369>

On Mon, Sep 17, 2007 at 12:50:26AM +0200, Niki Guldbrand wrote:
> I have been playing with git-archive for and hour or so, but can't ge=
t
> it to pass "extra" options to tar as it's documented that it should, =
or
> am i reading the docs wrong ?
>=20
> git-archive --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra>=
]
> [--remote=3D<repo>] <tree-ish> [path=E2=80=A6]
>=20
> <extra>
>         This can be any options that the archiver backend understand.
>         See next section.
>        =20
> I want to git tar the "--exclude=3Doption", but i can't get it throug=
h.
> Is this option only valid for the zip format with the options "-0" an=
d
> "-9" ?

Yes. The tar backend currently doesn't support any extra options.

Gruesse,
--=20
=46rank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
