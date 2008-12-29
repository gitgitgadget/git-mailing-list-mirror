From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Mon, 29 Dec 2008 15:05:57 -0800
Message-ID: <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 00:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHRCy-0004Jj-OP
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 00:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbYL2XGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 18:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYL2XGB
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 18:06:01 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:44506 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbYL2XGA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 18:06:00 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3894831qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XPuE8FGzwUTCXHabYJs+ON903Or3T2/Iv6610A9qAQg=;
        b=wzGaIhEujIpWNNeGKeWXHW99r8c4tkn5EE7oyLO5P0F/YGfzBot1HuFZlcBk2Mgce+
         ZFYo+kTpt66ebDD8wWIR8Q3PRk5IS20GyG7uvpZmP5FwKIGBYzxKXGe1VcRqJPywejx2
         yyyDVhPoRlO+QDa8mi01t2oFA9iU6o9pXFNwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wqwX4gWm1/NC+H9Jey2fdF/4Tlwk43z8I9ASAFcXtGsyLFSYj3Kqc31hlS4KIpQvIw
         jE42cfTpzJFOZGrYnyj7OS8VApXZyN2z0thkkwsxZsasnbS8TaCdw6WBppkSBNt+MxUp
         utxR7s+Y4Qw9vcdIru5cJKk9v4XtoEUBa9Gw0=
Received: by 10.214.182.14 with SMTP id e14mr11857034qaf.45.1230591957920;
        Mon, 29 Dec 2008 15:05:57 -0800 (PST)
Received: by 10.215.101.2 with HTTP; Mon, 29 Dec 2008 15:05:57 -0800 (PST)
In-Reply-To: <gj6kqq$nvh$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104139>

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

"Setup a git index in the project directory"
-this implies you're talking about the index.  you're not.  you're
talking about the repository.  either make it clear that the index is
an intermediary staging area, or ignore its existence and change all
git-add && git-commit references to git-commit -a references.  this
will ease the user of older scms into git.

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
e user
> > manual but before tearing your hair out trying to follow all the ex=
amples
> > in the user manual. After you've followed this simple workflow, the=
n go
> > back to the more advanced stuff  in the tutorials and user manuals =
(like
> > cloning repositories and creating and merging branches).
> >
> > I created this exercise to try and model our workflow and what we w=
anted
> > to use git for =3D tracking a project with multiple files where the=
 filebase
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
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
