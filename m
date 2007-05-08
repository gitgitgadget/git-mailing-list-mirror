From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 5/6] user-manual: miscellaneous editing
Date: Mon, 7 May 2007 23:07:32 -0400
Message-ID: <20070508030732.GB9471@fieldses.org>
References: <-1060540797535999820@unknownmsgid> <8aa486160705070027g2cb6797fy5acbe338e30429ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 05:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlG9z-00072n-LF
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967681AbXEHDHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 23:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967692AbXEHDHg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:07:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54744 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967691AbXEHDHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:07:35 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlG32-0003K2-Jy; Mon, 07 May 2007 23:07:32 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160705070027g2cb6797fy5acbe338e30429ff@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46520>

On Mon, May 07, 2007 at 09:27:40AM +0200, Santi B=E9jar wrote:
> On 5/7/07, J. Bruce Fields <bfields@citi.umich.edu> wrote:
> >Cc: Santi B=E9jar <sbejar@gmail.com>
>
> You forgot to CC: the e-mail to me :-)

The version of git-send-email I was using is supposed to do that
automatically based on the inlined Cc: line.  Did it not do that?

> >@@ -1830,14 +1836,14 @@ Now, assume your personal repository is in t=
he=20
> >directory ~/proj.  We
> > first create a new clone of the repository:
> >
> > -------------------------------------------------
> >-$ git clone --bare proj-clone.git
> >+$ git clone --bare proj.git
> > -------------------------------------------------
>=20
> You missed the ~/proj as in:
>=20
> $ git clone --bare ~/proj proj.git

Whoops, thanks.

> What do you think about the rest of my changes, in particular:
>=20
> @@ -2374,7 +2388,6 @@ then the following commands will all do the sam=
e=20
> thing:
> -------------------------------------------------
> $ git fetch git://example.com/proj.git master:ref/remotes/example/mas=
ter
> $ git fetch example master:ref/remotes/example/master
> -$ git fetch example example/master
> $ git fetch example
> -------------------------------------------------

Yes, you're correct, thanks for your persistence.

The others--I don't remember.  I'll take a quick look.  If you want to
be sure they'll all be considered, you could update the patch and
resend.

--b.
