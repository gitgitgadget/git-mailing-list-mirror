From: Mark Struberg <struberg@yahoo.de>
Subject: Re: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 22:44:40 +0000 (GMT)
Message-ID: <799439.71089.qm@web27808.mail.ukl.yahoo.com>
References: <20080814221221.GT3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:45:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlZi-0000VU-K1
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYHNWon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYHNWom
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:44:42 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:44991 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750822AbYHNWom convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:44:42 -0400
Received: (qmail 71279 invoked by uid 60001); 14 Aug 2008 22:44:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=frz7rLZ+2oLVD39uJp/1D1tl8CIjsoMo2p7ol5Z5tfjHgO743me4bbjnkOEm45VaX4py1vfb5c0PjgJIZDtR8AUbAQnqyJMTKlYAc0yQATKnZKdnuuhcYb+B07oTdR35I5xzbGhIr4GrsQHgyC9iTAQfGWm9Y2rj37P0t2kLjLI=;
Received: from [213.162.66.179] by web27808.mail.ukl.yahoo.com via HTTP; Thu, 14 Aug 2008 22:44:40 GMT
X-Mailer: YahooMailWebService/0.7.218
In-Reply-To: <20080814221221.GT3782@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92430>

Hi Shawn!

--- Shawn O. Pearce <spearce@spearce.org> schrieb am Fr, 15.8.2008:

> Von: Shawn O. Pearce <spearce@spearce.org>
> Betreff: Re: does anything like cvs export exist in git?
> An: "Mark Struberg" <struberg@yahoo.de>
> CC: git@vger.kernel.org
> Datum: Freitag, 15. August 2008, 0:12
> Mark Struberg <struberg@yahoo.de> wrote:
> > Since maven-scm should run under various OS (including
> Windoof)
> > the tar thingy will not work out.
>=20
> OK.  Maven could also consider using JGit, since its pure
> Java
> and thus just as portable as the JRE is.

I looked at JGit when I started implementation back in October last yea=
r but it wasn't rdy then. This is definitely on my list, and the whole =
project is already setup to support both, a native plus a Java implemen=
tation. But just one step after the other, I'd like to help finishing t=
he german git manpages first ;)

> > At least I now know that it's really unlikely that this
> > functionality does exist yet.
>=20
> Its not implemented for a reason; we suggest to users to
> use
> git-archive when they need to export a tree outside of Git.
Yup, this is completely ok from a git perspective, but maven-scm aims t=
o deliver the same result for each SCM system. And since cvs has been f=
irst...
Also, export is not very important (and also not time critical), all re=
ally important functions already work fine.

txs and LieGr=FC,
strub


__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
