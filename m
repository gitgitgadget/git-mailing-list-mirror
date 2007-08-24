From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Sat, 25 Aug 2007 00:33:38 +0200
Message-ID: <20070824223338.GA13209@steel.home>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi> <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Sat Aug 25 00:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOhiz-0001Xu-NS
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 00:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbXHXWdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 18:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760858AbXHXWdn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 18:33:43 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:41695 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450AbXHXWdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 18:33:41 -0400
Received: from tigra.home (Fac71.f.strato-dslnet.de [195.4.172.113])
	by post.webmailer.de (mrclete mo14) (RZmta 11.0)
	with ESMTP id d01171j7OHvguM ; Sat, 25 Aug 2007 00:33:39 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4E078277BD;
	Sat, 25 Aug 2007 00:33:39 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C2EE7BE01; Sat, 25 Aug 2007 00:33:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFzwIf0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56607>

V=E4in=F6 J=E4rvel=E4, Fri, Aug 24, 2007 08:35:13 +0200:
> On Aug 23, 2007, at 23:32, Alex Riesen wrote:
>=20
> >V=E4in=F6 J=E4rvel=E4, Thu, Aug 23, 2007 21:58:31 +0200:
> >>With this flag, the user can choose to filter untracked files from =
=20
> >>the
> >>status output. This can be used to either speed up the status =20
> >>output, as
> >>the untracked files are not fetched at all, or to just cleanup the
> >>output without using gitignore.
> >
> >"git diff -r --name-status; git diff --cached -r --name-status" is =20
> >not enough?
>=20
> That line will result in duplicate entries, if files are staged, and =
=20
> the output of git-status is neater (but longer) in my opinion.

That is because it _is_ two times different: between working directory
and the index, and between index and HEAD. git-status _will_ show you
the same for the same reason.

Besides, why do you want to hide this "duplication"? It shows how the
matters really are.

Besides, it looks like you are using "friendly" where you actually
wanted to say "I consider you too dumb to know what happens". Someone
may feel offended
