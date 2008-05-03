From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] Documentation: convert tutorials to man pages
Date: Sat, 3 May 2008 06:04:31 +0200
Message-ID: <200805030604.32123.chriscool@tuxfamily.org>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org> <8fe92b430805020255r1a06e169te583c371bde83ade@mail.gmail.com> <20080502124900.GA2923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 06:00:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js8vQ-0000N6-G7
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 06:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278AbYECD7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 23:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758269AbYECD7g
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 23:59:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34981 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756185AbYECD7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 23:59:35 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7B7101AB2BC;
	Sat,  3 May 2008 05:59:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2CC841AB2B6;
	Sat,  3 May 2008 05:59:32 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080502124900.GA2923@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81059>

Le vendredi 2 mai 2008, Jeff King a =C3=A9crit :
> On Fri, May 02, 2008 at 11:55:10AM +0200, Jakub Narebski wrote:
> > On 5/2/08, Christian Couder <chriscool@tuxfamily.org> wrote:
> > > This patch renames the following documents and at the same time
> > > converts them to the man page format:
> > >
> > >  cvs-migration.txt -> gitcvs-migration.txt
> > >  everyday.txt      -> giteveryday.txt
> > >  tutorial.txt      -> gittutorial.txt
> > >  tutorial-2.txt    -> gittutorial-2.txt
> >
> > I like the rest of the series, but this I have serious doubts about=
=2E I
> > think that manpage format is just not suitable for guides and tutor=
ials
> > (larger works), especially that we have HTML and beginnings of info
> > versions.
> >
> > Beside, the filenames looks stupid... githooks would go in a pinch,=
 but
> > other names...
>
> I don't know about that:
>
>   $ man perlretut | wc -l
>   2348

Yeah:

$ man perlfunc | wc -l
6708
$ man bash | wc -l
4916
$ man git | wc -l
825
$ man gittutorial | wc -l
691
$ man gittutorial-2 | wc -l
472
$ man giteveryday | wc -l
478
$ man gitcvs-migration | wc -l
201

so the 4 tutorials are much shorter than some other man pages and even=20
shorter than the git(7) man page.

> which is basically the same thing (funny name, and very long).

I would even say that the name is better and that the content is someti=
mes=20
much shorter compared with perl man pages.=20

> At least=20
> for me, looking at a manpage is much more convenient than info or HTM=
L.
> It's quick to load and easy to search through. Sure, the HTML will lo=
ok
> a lot nicer. But it seems like if even a few people use the man versi=
on,
> the almost zero effort to generate them is worth it=20

I agree. Sometimes the man pages are the only thing you can easily read=
=2E

> (though I would=20
> argue that it should remain "tutorial.txt" and "tutorial.html", but
> generate "gittutorial.1").

I am open to suggestions for a better naming and for choosing man page=20
sections, but I think we should be consistent as much as possible.

=46or example, the man page starts with:

NAME
       gittutorial - A tutorial introduction to git (for version 1.5.1 =
or
       newer)

If we keep "gittutorial" in the HTML format man page but we still name =
the=20
file "tutorial.html", we are not very consistent.

And I think it will be some work to get links or references working in =
both=20
the man format and HTML format man pages, especially if the naming is t=
he=20
same for some files (gitmodules, gitignore, git, gitk, git-log, ...) bu=
t=20
not others (tutorial, everyday, ...)

About man page sections, Perl is consistent because every thing is in=20
section 1. Now for git we already have git commands in section 1 and so=
me=20
other documentation (gitattributes, gitignore, gitmodules) in section 5=
=20
and "git" in section 7. Do we want to keep "git" alone in section 7 and=
 put=20
tutorials in section 1 ? Or put everything in section 1 ?

Thanks,
Christian.
