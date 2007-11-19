From: "Jonas Juselius" <jonas.juselius@chem.uit.no>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:56:22 +0100
Message-ID: <1195491382.10573.34.camel@localhost>
References: <1195477504.8093.15.camel@localhost> <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cF3SU6hiwqI6C4pQYgOL"
Cc: <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuA2x-0008AQ-Nd
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbXKSRER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbXKSRER
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:04:17 -0500
Received: from mux1.uit.no ([129.242.4.252]:55607 "EHLO mux1.uit.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbXKSREQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:04:16 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 12:04:15 EST
Received: from EVS1.ad.uit.no (eden6.ad.uit.no [129.242.8.62])
	by mux1.uit.no (8.13.8/8.13.6/Mux) with ESMTP id lAJGuLVn054506;
	Mon, 19 Nov 2007 17:56:21 +0100 (CET)
Received: from EVS2.ad.uit.no ([129.242.8.59]) by EVS1.ad.uit.no with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Nov 2007 17:56:21 +0100
Received: from 129.242.24.54 ([129.242.24.54]) by EVS2.ad.uit.no ([129.242.8.29]) via Exchange Front-End Server postboks.uit.no ([129.242.164.132]) with Microsoft Exchange Server HTTP-DAV ; Mon, 19 Nov 2007 16:56:21 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from snowflake by postboks.uit.no; 19 Nov 2007 17:56:22 +0100
Content-class: urn:content-classes:message
In-Reply-To: <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Git in a Nutshell guide
Thread-Index: AcgqzRw5gzjDH4/eRQOO1O0KV90iyw==
X-OriginalArrivalTime: 19 Nov 2007 16:56:21.0323 (UTC) FILETIME=[1C66F1B0:01C82ACD]
X-Virus-Scanned: : ok
X-Scanned-By: MIMEDefang 2.62 on 129.242.4.252
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65469>


--=-cF3SU6hiwqI6C4pQYgOL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2007-11-19 at 17:45 +0100, Lars Hjemli wrote:
>=20
> Very nice introduction, but I have a couple of comments.
>=20
Thank you :)

> In "Specifying revisions" you say that '^' and '~' are equal, but that
> is not true. ^ is used to select the first parent of a commit, ^2
> selects the second parent of a merge commit (and ^3 selects the third
> parent of an octopus merge), while the '~' is used to go back any
> number of generations, following the first parents of each commit (~
> selects the first parent, ~2 selects the first grand-parent etc).
>=20

Thanks for the the clarification. I've never done an octopus, so I
simply ignored the matter. I'll correct the text and add a footnote.

> Also, I think you might scare users away from 'git reset':
>=20
>   git reset resets the branch to a specified state invisibly and
>   without possibility to go back. Ever. Your call.
>=20
> That's not true, since any "modern" git has reflogs enabled. If you do
> 'git reset --hard HEAD^^^' and then realize it was a mistake you can
> just 'git reset --hard HEAD@{1}'
>=20
This was new to me ;) I'll correct and add a note on reflogs.

.j.

--=-cF3SU6hiwqI6C4pQYgOL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQcA2wakVfwpZemYRAnMeAJ4hVomHA+lxA9bddOYUEgYJwtpFlwCfc8mN
PJ4DGX3LroNWTDjtWBB1ig4=
=wTCP
-----END PGP SIGNATURE-----

--=-cF3SU6hiwqI6C4pQYgOL--
