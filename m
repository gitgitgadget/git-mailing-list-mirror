From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Breakage in master since 6d4bb3833c
Date: Fri, 21 Oct 2011 14:28:01 +0200
Message-ID: <20111021122801.GA3799@goldbirke>
References: <4EA1614D.3090202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 21 14:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHECr-0002ML-ST
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 14:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1JUM2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 08:28:09 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:3451 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1JUM2I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 08:28:08 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 21 Oct
 2011 14:28:55 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 21 Oct
 2011 14:28:01 +0200
Content-Disposition: inline
In-Reply-To: <4EA1614D.3090202@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184058>

Hi,

On Fri, Oct 21, 2011 at 02:10:53PM +0200, Michael Haggerty wrote:
> When testing reference-handling performance using my refperf script [=
1],
> I noticed that there is a problem in master that I bisected down to
>=20
> 6d4bb3833c "fetch: verify we have everything we need before updating =
our
> ref"
>=20
> When I run the following commands
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> GIT=3D$(pwd)/git

> $GIT fetch origin
> Then the last "git fetch origin" command gives the following output:
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]

I suspect this is the same issue as here:

  http://thread.gmane.org/gmane.comp.version-control.git/182339/focus=3D=
182357


Best,
G=E1bor
