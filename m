From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 16:07:37 -0000
Message-ID: <gjdh0r$n3c$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 17:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHh9y-0007th-Um
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 17:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbYL3QIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 11:08:18 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYL3QIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 11:08:16 -0500
Received: from main.gmane.org ([80.91.229.2]:54466 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbYL3QIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 11:08:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHh8Z-0008CN-Np
	for git@vger.kernel.org; Tue, 30 Dec 2008 16:08:08 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 16:08:07 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 16:08:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104191>


"Jeff Whiteside" <jeff.m.whiteside@gmail.com> wrote in message=20
news:3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com...
hi zorb,

you have done a great justice here to inadvertently explaining the
learning curve of git, through a few mistakes, especially for ppl
behind in their scm use.  i enjoyed reading your blog posts though, as
they remind me of myself, not long ago.

you have a couple of mistakes i think you should correct.

-"Imagine a project with 4 versions, made up of various configurations
of the three files."
this line implies that you have branches (the word configurations).
you should be focusing, at first, on a project that has a set number
of files, and the content merely changes.  ideally, you don't often
add and rm files across versions.  also, the project doesn't really
have 4 versions, like windows has 4 different versions of vista, the
project has 3 old versions and 1 new version.

** ok, I've changed "configurations" as its overloaded in the context o=
f=20
older SCMs.
Point taken about changing content not containers. However changing con=
tent=20
is easier, and therefore less need for a tutorial
Also this write-up is basically a "note to self", that I've cleaned up =
in=20
case someone else can find it useful, and the problem I was solving was=
 a=20
problem that involved containers changing.
I've explained the context for going the way of containers now in the=20
write-up.
I've covered off your concern for ppl thinking we have 4x current versi=
ons=20
(ie. branches) with "4 progressively more recent versions"

"Setup a git index in the project directory"
-this implies you're talking about the index.  you're not.  you're
talking about the repository.  either make it clear that the index is
an intermediary staging area, or ignore its existence and change all
git-add && git-commit references to git-commit -a references.  this
will ease the user of older scms into git.

** Don't forget they'll have read the tutorial and/or user-guide, and t=
he=20
concepts of an index and staging are fairly easy to pick up.
I'll keep it in, and make sure I refer to it as you suggest.

-"Rollback to each of the versions, starting with version A"
this is bad.  you're saying rollback.  to others that have used scms,
this will mean, "retrieve an older copy", but in git, this is DELETING
all the versions after the version that you "rollback" to.  your blog
post shouldn't discuss the git-reset --hard command at all, since
you're rewriting history, which is dangerous.  afaik, most scms don't
allow you to rewrite history.  to "rollback" to an older version you
should use checkout the git-checkout command.  maybe the git reset
-=96hard HEAD is okay to include... but it won't be immediately obvious
to new users why it does what it does... this nomenclature was likely
not the best choice whenever it was made.

** have now promoted git-checkout as the way to review older versions
I've left git-reset in there, for my own notes as much as anything, but=
 not=20
suggesting it be used as some sort of cursor to move the HEAD up and do=
wn=20
the branch

NB getting some funny results with git-checkout near the head of the br=
anch
- will investigatge and report





u're talking sdf




On Sat, Dec 27, 2008 at 5:29 PM, Zorba <cr@altmore.co.uk> wrote:
>
> tidied up the formatting, added a few more comments where needed, fix=
ed
> errors/lack of clarity
>
> "Zorba" <cr@altmore.co.uk> wrote in message
> news:gj68a0$u56$3@ger.gmane.org...
> > Here is a little exercise / tutorial / warm-up for someone starting=
 out
> > with Git. If you're anyting like me you may find the tutorials etc.=
 on
> > git.or.cz a bit daunting. I recommend you try this after reading th=
e=20
> > user
> > manual but before tearing your hair out trying to follow all the=20
> > examples
> > in the user manual. After you've followed this simple workflow, the=
n go
> > back to the more advanced stuff  in the tutorials and user manuals =
(like
> > cloning repositories and creating and merging branches).
> >
> > I created this exercise to try and model our workflow and what we w=
anted
> > to use git for =3D tracking a project with multiple files where the=
=20
> > filebase
> > might change frequently from one version to the next.
> >
> > http://siliconmouth.wordpress.com/category/nerdy/
> >
> > look for December 27, 2008 or "git warmup"
> >
> >
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=20
