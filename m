From: James French <James.French@naturalmotion.com>
Subject: RE: running git from non-standard location on Mac
Date: Thu, 21 Feb 2013 11:48:39 +0000
Message-ID: <1CE1BECC0915A6448EAE5D7080EDA905052078CA55@oxexc1>
References: <1CE1BECC0915A6448EAE5D7080EDA905052078C95E@oxexc1>
 <20130221143525.726f06827351376b59a02f4b@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 12:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8UeH-0008JD-SN
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 12:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab3BULsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 06:48:45 -0500
Received: from gwl205.naturalmotion.com ([86.12.140.205]:29177 "EHLO
	mail1.naturalmotion.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753202Ab3BULsp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 06:48:45 -0500
Thread-Topic: running git from non-standard location on Mac
Thread-Index: Ac4QHypnbdXmL64ERfSCkf/OBYZ1JAACgipA
In-Reply-To: <20130221143525.726f06827351376b59a02f4b@domain007.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216766>



-----Original Message-----
=46rom: Konstantin Khomoutov [mailto:flatworm@users.sourceforge.net]=20
Sent: 21 February 2013 10:35
To: James French
Cc: git@vger.kernel.org
Subject: Re: running git from non-standard location on Mac

On Thu, 21 Feb 2013 09:48:36 +0000
James French <James.French@naturalmotion.com> wrote:

> I wonder if someone could help me. I installed git on a Mac and then =
I=20
> copied the install somewhere else (which I do want to do, trust me). =
=A0
> I'm now having trouble with git svn. I'm getting "Can't locate=20
> Git/SVN.pm in @INC..."
>=20
> I've added the bin folder to PATH. What else do I need to do? Do I=20
> need to use -exec-path=3D/MyPathToGit/libexec/git-core? How do I chan=
ge=20
> the content of @INC?
>=20
> Apologies if this is a dumb question, I'm not much of a unix man.

`git svn` is implemented in Perl (which is supposedly bundled with your=
 Git package, but I'm not sure), and "SVN.pm" is a Perl module (a libra=
ry written in Perl, ".pm" stands for "Perl Module").

@INC is an internal variable used by Perl to locate its modules.
Its contents is partially inferred from the Perl's installation locatio=
n and partially from the environment.

This [1] should help you get started with affecting @INC.

1. http://stackoverflow.com/a/2526809/720999



Thanks for the help guys. I got it working using --exec-path and PERL5L=
IB environment variable. But Matthieu is right, I should build it from =
source to do it properly.
