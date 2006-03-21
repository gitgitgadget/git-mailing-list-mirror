From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 17:18:33 -0300
Message-ID: <1142972313.4749.123.camel@praia>
References: <1142969653.4749.109.camel@praia>
	 <20060321193924.GD14579@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Mar 21 21:18:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLnJU-0003g6-0a
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 21:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWCUUSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Mar 2006 15:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWCUUSk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 15:18:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55194 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932438AbWCUUSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 15:18:40 -0500
Received: from [200.181.90.159] (helo=[192.168.255.65])
	by pentafluge.infradead.org with esmtpsa (Exim 4.54 #1 (Red Hat Linux))
	id 1FLnJO-0005jM-Lq; Tue, 21 Mar 2006 20:18:39 +0000
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060321193924.GD14579@fieldses.org>
X-Mailer: Evolution 2.4.2.1-3mdk 
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17786>

Em Ter, 2006-03-21 =E0s 14:39 -0500, J. Bruce Fields escreveu:
> On Tue, Mar 21, 2006 at 04:34:13PM -0300, Mauro Carvalho Chehab wrote=
:
> > It shouldn't have any conflicts here for Linus, since those patches=
 came
> > from his tree.
>=20
> What do you mean by "those patches came from his tree"?  If you're
> actually cherry-picking patches from his tree and applying them to
> yours, then you're not reproducing the same commits he has--you're ju=
st
> creating new commits that happen to have nearly identical content.
No, I'm not cherry-picking his patches.=20

>From the discussions on git IRC, I think it may be caused by a bad
procedure when solving a conflict, after merging from Linus tree.

>From what I'm understanding now, I should do, when a conflict is
detected:

nano <files>
git-update-index <files>
git commit

Previously (at git 1.1.4), I was doing:
nano <files>
git commit <files>

git 1.2.4 don't allow this bad commit syntax anymore.

>=20
> --b.
Cheers,=20
Mauro.
