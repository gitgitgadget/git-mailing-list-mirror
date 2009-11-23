From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git describe oddity: ignoring recent tags...
Date: Mon, 23 Nov 2009 13:39:39 +0100
Message-ID: <200911231339.41290.trast@student.ethz.ch>
References: <46a038f90911230401sb2b1dd7u21b5d7edefe510eb@mail.gmail.com> <20091123123048.GA10172@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 13:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCYCx-00017m-U5
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 13:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbZKWMjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 07:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbZKWMji
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 07:39:38 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:49966 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327AbZKWMjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 07:39:37 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 23 Nov
 2009 13:39:42 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 23 Nov
 2009 13:39:42 +0100
User-Agent: KMail/1.12.90 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.75; x86_64; ; )
In-Reply-To: <20091123123048.GA10172@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133502>

Bj=F6rn Steinbrink wrote:
> On 2009.11.23 13:01:51 +0100, Martin Langhoff wrote:
> > git describe origin/master will respond olpc-update-2.16-20-g2d4e4b=
8
> > when it is fairly clear to me that it should be
> > olpc-update-2.19-1g<hash>.
[...]
> They are lightweight:
> $ git cat-file -t olpc-update-2.19
> commit
>=20
> And using --tags "helps" here:
> $ git describe=20
> olpc-update-2.16-20-g2d4e4b8
>=20
> $ git describe --tags
> olpc-update-2.19-3-g2d4e4b8

Note that Gits that do not have 7e425c4 (describe: Make --tags and
--all match lightweight tags more often, 2008-10-13; first released in
1.6.1) will prefer the annotated tag over the unannotated ones even
with --tags, which explains your observation

> > For some reason, recent tags are being ignored -- and cgit even
> > displays them differently in
> > http://dev.laptop.org/git/projects/olpc-update/log/ though it is
> > unclear to me why.

at least with the first Git version mentioned:

> > Tested with 1.6.0.6 (Fedora 9 rpm) and 1.6.3.1.26.gf5b223 (on Karmi=
c).

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
