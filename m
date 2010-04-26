From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Mon, 26 Apr 2010 13:22:35 -0400
Message-ID: <20100426172235.GA626@coredump.intra.peff.net>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
 <20100425194800.GB14736@coredump.intra.peff.net>
 <20100425220955.GA25620@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Cheng Renquan <crquan@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 19:22:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6S15-000144-SA
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 19:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0DZRWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 13:22:38 -0400
Received: from peff.net ([208.65.91.99]:38724 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab0DZRWh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 13:22:37 -0400
Received: (qmail 12410 invoked by uid 107); 26 Apr 2010 17:22:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 13:22:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 13:22:35 -0400
Content-Disposition: inline
In-Reply-To: <20100425220955.GA25620@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145831>

On Sun, Apr 25, 2010 at 05:09:55PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
>=20
> > The config variables format.* are traditionally about format-patch.=
 I
> > see we have format.pretty these days, too.
>=20
> Yes, it as added in commit v1.5.5-rc0~57^2 (log/show/whatchanged:
> introduce format.pretty configuration, 2008-03-02):
>=20
>     When running log/show/whatchanged from the command line, the user=
 may want
>     to use a preferred format without having to pass --pretty=3D<fmt>=
 option
>     every time from the command line.  This teaches these three comma=
nds to
>     honor a new configuration variable, format.pretty.
>=20
>     The --pretty option given from the command line will override the=
=20
>     configured format.
>=20
> I use it to mess with line wrapping; that it=E2=80=99s possible is ve=
ry nice.
> Thanks, Renquan.

To be clear, I don't have any problem with the _functionality_. I just
think it probably should have been log.pretty, or pretty.default or
something. Too late now, though.

-Peff
