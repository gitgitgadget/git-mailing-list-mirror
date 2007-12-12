From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Wed, 12 Dec 2007 13:40:12 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712121330541.5349@iabervon.org>
References: <20071211195712.GA3865@bitplanet.net>  <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
  <1197416286.7552.4.camel@hinata.boston.redhat.com> 
 <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>  <1197473063.9269.20.camel@hinata.boston.redhat.com>
  <Pine.LNX.4.64.0712121237540.5349@iabervon.org>
 <1197483943.10132.4.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2143387413-1197484812=:5349"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2WVe-0008PZ-B4
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbXLLSkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbXLLSkP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:40:15 -0500
Received: from iabervon.org ([66.92.72.58]:51281 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574AbXLLSkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:40:14 -0500
Received: (qmail 19336 invoked by uid 1000); 12 Dec 2007 18:40:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Dec 2007 18:40:12 -0000
In-Reply-To: <1197483943.10132.4.camel@hinata.boston.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68083>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2143387413-1197484812=:5349
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Dec 2007, Kristian H=F8gsberg wrote:

> Ugh, I meant builtin-remote there, sorry.  I use fetch_pack() like the sh=
ell
> script does, and it seem a lot easier that trying to call fetch:
>=20
>         struct fetch_pack_args args;
>=20
>         args.uploadpack =3D option_upload_pack;
>         args.quiet =3D option_quiet;
>         args.fetch_all =3D 1;
>         args.lock_pack =3D 0;
>         args.keep_pack =3D 1;
>         args.depth =3D option_depth;
>         args.no_progress =3D 1;
>=20
>         refs =3D fetch_pack(&args, argv[0], 0, NULL, NULL);

Ah, but that only works for git native protocol remote repositories.=20
Calling fetch instead would mean that other protocols also work without=20
any fuss.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-2143387413-1197484812=:5349--
