From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 04:24:25 -0000
Message-ID: <gjc7qa$jdj$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 05:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHWBP-0004zf-Ni
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 05:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYL3EY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 23:24:58 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbYL3EY5
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 23:24:57 -0500
Received: from main.gmane.org ([80.91.229.2]:46040 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbYL3EY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 23:24:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHW9x-0002UR-Ik
	for git@vger.kernel.org; Tue, 30 Dec 2008 04:24:49 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 04:24:49 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 04:24:49 +0000
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104155>

Hi Jeff,

Thanks for your contrib. I'll pick these up for sure, but right now I'm=
=20
despo to make some progress getting this confounded real-life project=20
versioned.

But where I'm stuck now touches on your post.

I've just made a commit I want to retract.

I have been using $ git reset --hard <version> as an escalator to ascen=
d /=20
descend the versions up and down
Surely it doesn't alter the history, as I can commit versionA, versionB=
,=20
versionC, and then reset to A, then reset to C, then reset to B.

so when I reset to A, I've still got the ability to get to B or C again

Now I appreciate that if I commit a new change from versionA (lets call=
 it=20
B1), then HEAD is now at B1, and B, C etc are lost, correct ?

Its pertinent to where I am right now, as I've goofed a commit, and wan=
t to=20
reset, and commit again but I'm worried about leaveing garbage lying ar=
ound=20
(the commits for version B and C in the example above).

NB if you read my latest posts you will see why I chose the example I d=
id=20
for my "warm-up" as it closely models what I'm trying to do for real.


BTW: sdf=3DSyntax Definition Formalism?

"Jeff Whiteside" <jeff.m.whiteside@gmail.com> wrote in message=20
news:3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com...

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


gl with your gitting.

whiteside




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
