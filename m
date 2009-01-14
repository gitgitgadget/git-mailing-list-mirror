From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: .ft tag in man
Date: Wed, 14 Jan 2009 11:11:09 +0100
Message-ID: <496DBA3D.9020502@drmicha.warpmail.net>
References: <20090114052126.GA6849@b2j> <7veiz678m2.fsf@gitster.siamese.dyndns.org> <20090114064510.GZ18365@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN2jb-0006Bb-St
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbZANKLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 05:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZANKLG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:11:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38972 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753051AbZANKLE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 05:11:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2B02520F8FD;
	Wed, 14 Jan 2009 05:11:03 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 14 Jan 2009 05:11:03 -0500
X-Sasl-enc: Lsl+57/7T4SBq5F/NpizuEfwgqW9iYGxR46soDvMVxUW 1231927862
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4ACE42B7A9;
	Wed, 14 Jan 2009 05:11:02 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090114064510.GZ18365@inocybe.teonanacatl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105608>

Todd Zullinger venit, vidit, dixit 14.01.2009 07:45:
=2E..
> I began seeing this on Fedora 10.  Defining DOCBOOK_XSL_172 fixed
> that issue, but seems to have caused another. :/
>=20
> For example, in git-diff.1, without DOCBOOK_XSL_172, I see:
>=20
>                .ft C
>                $ git diff            (1)
>                $ git diff --cached   (2)
>                $ git diff HEAD       (3)
>                .ft
>=20
> With DOCBOOK_XSL_172, I get this:
>=20
>                $ git diff            =E2=96=93fB(3)=E2=96=93fR
>                $ git diff --cached   =E2=96=93fB(2)=E2=96=93fR
>                $ git diff HEAD       =E2=96=93fB(3)=E2=96=93fR
>=20
> The '.ft' problem is gone, but '\fB' and '\fR' are replaced by '=E2=96=
=93fB'
> and '=E2=96=93fR', respectively.  The paragraphs that follow such a l=
ist of
> commands show more ugliness:
>=20
>            =E2=8C=82sp =E2=96=93fB1. =E2=96=93fRChanges in the workin=
g tree not yet staged for the
>            next commit.  =E2=8C=82br =E2=96=93fB2. =E2=96=93fRChanges=
 between the index and your
>            last commit; what you would be committing if you run "git =
commit"
>            without "-a" option.  =E2=8C=82br =E2=96=93fB3. =E2=96=93f=
RChanges in the working tree
>            since your last commit; what you would be committing if yo=
u run
>            "git commit -a" =E2=8C=82br
>=20
> Defining ASCIIDOC8 seems to have no effect on this problem.
>=20
>> Perhaps you are using different version of asciidoc/docbook/xmlto
>> toolchain?
>=20
> On Fedora 10, these are the versions:
>=20
> asciidoc-8.2.5-2.fc9
> docbook-dtds-1.0-41.fc10
> docbook-style-xsl-1.74.0-4.fc10
> xmlto-0.0.21-2.fc10
>=20
> Fedora 9 has:
>=20
> asciidoc-8.2.5-2.fc9
> docbook-dtds-1.0-38.fc9
> docbook-style-xsl-1.73.2-10.fc9
> xmlto-0.0.20-3.fc9

The problem can be seen even in the F10 release packages for git. Shame
on them ;)

When I get back to my F9 box I'll try upgrading those packages one by
one to their F10 versions (hoping dependencies don't connect all of the=
m).

Michael
