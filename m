From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Fri, 21 Aug 2009 00:42:03 +0200
Message-ID: <200908210042.05802.trast@student.ethz.ch>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch> <7vab1up1gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGL6-0006W2-Ns
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 00:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbZHTWmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbZHTWmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 18:42:25 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:19476 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbZHTWmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 18:42:24 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Fri, 21 Aug
 2009 00:42:25 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Fri, 21 Aug
 2009 00:42:27 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vab1up1gz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126655>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > Ideally, we'd like 'git diff C^!' to show the same diff that 'git s=
how C'
> > does (with log.showroot enabled).  This gives easy access to a read=
able
> > diff for the commit, irrespective of how many parents it has and wi=
thout
> > any trickery to remove the commit message from the git-show output.
>=20
> Not interested yet, as the "git show" discussion is not convincing at=
 all.

Well, it is currently half-supported, diff doesn't complain about it,
yet it does something wildly different from what people expect in the
zero- and two-parent cases.

And yes, people expect this to work; searching the #git logs (I won't
link here as it takes a fair while even for one request) shows that
people such as Dscho, Thiago, Jakub and Bj=F6rn have recommended this
syntax in the context of diff.

> Is the message annoying enough to warrant this change?
>=20
> If that is indeed the case and if it is a common thing to ask, isn't =
it
> more productive to teach "show" a way to do so in a simpler way than
> doing, say,
>=20
> 	$ git show --pretty=3Dformat: HEAD

That still doesn't get rid of the stray newline.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
