From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 5/5] Convert "float" to the lib infrastructure
Date: Tue, 17 Mar 2009 08:16:45 +0100
Message-ID: <20090317071645.GC3716@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120918.2992.82713.stgit@pc1117.cambridge.arm.com> <20090313024137.GE15393@diana.vm.bytemark.co.uk> <b0943d9e0903160936m1971fbaft928a495eaab4fa20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTZ2-000881-Vn
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbZCQHQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 03:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZCQHQs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:16:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:60054 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZCQHQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:16:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjTXZ-00015N-00; Tue, 17 Mar 2009 07:16:45 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903160936m1971fbaft928a495eaab4fa20@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113429>

On 2009-03-16 16:36:43 +0000, Catalin Marinas wrote:

> 2009/3/13 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-03-12 12:09:18 +0000, Catalin Marinas wrote:
> >
> > > =A0options =3D [
> > > =A0 =A0 =A0opt('-s', '--series', action =3D 'store_true',
> > > - =A0 =A0 =A0 =A0short =3D 'Rearrange according to a series file'=
)]
> > > + =A0 =A0 =A0 =A0short =3D 'Rearrange according to a series file'=
)
> > > + =A0 =A0] + argparse.keep_option()
> >
> > This flag should take the filename as a parameter, both because
> > it's the right thing to do and because it'll make the tab
> > completion work right (as is, it'll complete on patch names after
> > the -s flag).
> >
> > Something like
> >
> > =A0opt('-s', '--series', type =3D 'string')
> >
> > ought to do it.
>
> This command was accepting series via the stdin as well (maybe for
> easier use in other scripts or from stgit.el).

Ah. Hmm, I'd prefer if it used "-" for that, for consistency. And
because I don't know how to make flags with optional parameters. :-/

> Anyway, it doesn't seem to make any difference with the bash
> completion. It still tries to complete patches but when this fails
> bash lists files if the prefix matches some.

Hmm, that's not right. But I can have a look at it if you like.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
