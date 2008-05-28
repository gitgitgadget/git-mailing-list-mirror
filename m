From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: Re: git-svn commit id.
Date: Wed, 28 May 2008 13:18:45 -0300
Message-ID: <1211991525.15736.18.camel@omicron.ep.petrobras.com.br>
References: <1211983320.15736.11.camel@omicron.ep.petrobras.com.br>
	 <483D6F10.5000403@op5.se>
	 <8aa486160805280750q5a214961re21ed1dc731cf181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 18:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ONP-0003v0-5L
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYE1QSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbYE1QSv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:18:51 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:51449 "EHLO
	spunkymail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751303AbYE1QSv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 12:18:51 -0400
Received: from [127.0.0.1] (unknown [139.82.86.2])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by spunkymail-a18.g.dreamhost.com (Postfix) with ESMTP id D18D85B52E
	for <git@vger.kernel.org>; Wed, 28 May 2008 09:18:48 -0700 (PDT)
In-Reply-To: <8aa486160805280750q5a214961re21ed1dc731cf181@mail.gmail.com>
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83105>

I studied the matter a lit bit and found out that there is an early
commit that is different (in one repository if has lots deletions and i=
n
the other the diff is empty). This maybe an oddity of our svn repositor=
y
that uses non-standard layout (atual in place of trunk, for instance).=20

On Wed, 2008-05-28 at 16:50 +0200, Santi B=C3=A9jar wrote:
> On Wed, May 28, 2008 at 4:41 PM, Andreas Ericsson <ae@op5.se> wrote:
> > Victor Bogado da Silva Lins wrote:
> >>
> >> I have two git-svn repositories here and I noticed that the same c=
ommit
> >> have different ids in them. How this came to be, both commits shar=
e the
> >> exact same git-svn-id and are the same (as far as I know).
> >
> > If the have exactly the same history leading up to them, source tre=
es
> > and commit object (including timestamps), the only way they can be =
any
> > different is if you've run into a bug in the SHA1 libraries.
> >
> > If either of the above three are different though, you *will* end u=
p
> > with different commits.
> >
> > Try doing "git cat-file commit <sha1-of-one-commit>" and then
> > "git cat-file commit <sha1-of-other-commit>". If you take a diff
> > between the two, you'll see how they differ (my guess would be the
> > timestamps)
> >
>=20
> Git-svn uses the same timestamps as in svn, my guess is that one has
> more history than the other.
>=20
> Santi
