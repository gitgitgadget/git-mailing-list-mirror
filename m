From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path" config var
Date: Tue, 25 Mar 2008 07:19:01 +0100
Message-ID: <200803250719.02044.chriscool@tuxfamily.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org> <200803210823.47899.chriscool@tuxfamily.org> <7vd4poqwu6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 07:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je2QF-0000mi-PZ
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 07:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217AbYCYGN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 02:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755718AbYCYGN2
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:13:28 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58155 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756217AbYCYGN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 02:13:27 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1E46D1AB2D7;
	Tue, 25 Mar 2008 07:13:25 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BB2531AB2D5;
	Tue, 25 Mar 2008 07:13:24 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vd4poqwu6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78149>

Le vendredi 21 mars 2008, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> >
> > It's perhaps more honest, but kfmclient is not as well known as
> > konqueror.
> >
> > Isn't a documentation patch like this enough:
>
> I dunno.  I am not a KDE use to begin with.
>
> But I am somewhat uncomfortable with this kind of magic, and very muc=
h
> more so with basing the magic on the name of a binary.

I think in this case it should be ok if it's properly documented.

It's good to have a consistent user interface with meaningfull names fo=
r the=20
available options. And we are right to try to do the same thing as when=
=20
browsing an HTML man page.

In the documentation patch for "man.<tool>.cmd" that I will send just a=
fter=20
this email, there is also enough information to understand what is goin=
g on=20
and to find a good way around the magic if needed.

I can send the same kind of documentation patch for git-web--browse too=
, so=20
we are completely consistent.

> For example, if a distro offers two versions of konq to co-exist on t=
he
> same system as konqueror-3 and konqueror-4 (with the usual symlink tr=
icks
> /etc/alternatives/konqueror -> konqueror-3 and /usr/bin/konqueror ->
> /etc/alternatives/konqueror to make one version the systemwide defaul=
t),
> people who want a particular version may say /usr/bin/konqueror-4 and
> would get frustrated to see kfmclient magic would not kick in.  By ta=
king
> honest route without magic, you would not have to worry about such
> potential confusion.

In my experience KDE people have never changed the binary names like th=
at.=20
They just use (or advice users to use) different directory names and ch=
ange=20
environment variables (QTDIR, KDEDIR and maybe others) to point to the =
new=20
dirs.

Thanks,
Christian.
