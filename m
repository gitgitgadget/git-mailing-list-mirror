From: Jakub Narebski <jnareb@gmail.com>
Subject: Cross-Platform Version Control (was: Eric Sink's blog - notes on git, dscms and a "whole product" approach)
Date: Tue, 28 Apr 2009 04:24:31 -0700 (PDT)
Message-ID: <m3r5zdnhqu.fsf@localhost.localdomain>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 13:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LylQb-0004uQ-92
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 13:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbZD1LYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 07:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbZD1LYg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 07:24:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:63693 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZD1LYe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 07:24:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so369369rvb.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=VNItdk1Ihv+p8E1wUMNvLNKRWhJY+uXzx+gUafTzEsc=;
        b=AoTus9bdzdmniKSdpb6kcWvVXn/l+tq82bOY+ymTk9KDMZY0JlmimP7LXvbZnbT3Yz
         Ko6TVlii1mZGoiTC2+BAt2r0PPeMmPr+Nh0hZMOThKVEqYK7XxS0uqB9Yg2Byy3BOIwv
         vlYNUEV9YgHvysvbeajr8mXVGHRd9tCs1pOmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=e6XQ5cAtMSBnWIYbtFJt6Lz+3dxjd1ZW3JKkqjfEJ433dN2Qy1xE8UFiFAhpQ2mhl3
         ajBj+Thu03cEKhayz03UuFNbs+EkV4VxdOvXGQ+RyioKd1xsovi/u3LPXVjA9KL+6CDV
         gb/7v7yHUj4piM98O6qVOut/ZKryVEAR3oE4Q=
Received: by 10.142.125.4 with SMTP id x4mr1388567wfc.75.1240917873314;
        Tue, 28 Apr 2009 04:24:33 -0700 (PDT)
Received: from localhost.localdomain (abvq17.neoplus.adsl.tpnet.pl [83.8.214.17])
        by mx.google.com with ESMTPS id 31sm6725965wff.24.2009.04.28.04.24.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 04:24:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3SBOPjc020460;
	Tue, 28 Apr 2009 13:24:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3SBOPIv020457;
	Tue, 28 Apr 2009 13:24:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117763>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Eric Sink hs been working on the (commercial, proprietary) centralise=
d
> SCM Vault for a while. He's written recently about his explorations
> around the new crop of DSCMs, and I think it's quite interesting. A
> quick search of the list archives makes me thing it wasn't discussed
> before.
>=20
> The guy is knowledgeable, and writes quite witty posts -- naturally,
> there's plenty to disagree on, but I'd like to encourage readers not
> to nitpick or focus on where Eric is wrong. It is interesting to read
> where he thinks git and other DSCMs are missing the mark.
>=20
>    Maybe he's right, maybe he's wrong, but damn he's interesting :-)
>=20
> So here's the blog -  http://www.ericsink.com/

"Here's a blog"... and therefore my dilemma. Should I post my reply
as a comment to this blog, or should I reply here on git mailing list?
=20
> These are the best entry points

Because those two entries are quite different, I'll reply separately

1.  "Ten Quirky Issues with Cross-Platform Version Control"
>   http://www.ericsink.com/entries/quirky.html

which is generic comment about (mainly) using version control
in heterogenic environment, where different machines have different
filesystem limitations.  I'll concentrate here on that issue.

2.  "Mercurial, Subversion, and Wesley Snipes"
>   http://www.ericsink.com/entries/hg_denzel.html

where, paraphrasing, Eric Sink says that he doesn't write about
Mercurial and Subversion because they are perfect.  Or at least not
as controversial (and controversial means interesting).

>=20
> To be frank, I think he's wrong in some details (as he's admittedly
> only spent limited time with it) but right on the larger-picture
> (large userbases want it integrated and foolproof, bugtracking needs
> to go distributed alongside the code, git is as powerful^Wdangerous a=
s
> C).

Neither of mentioned above blog posts touches those issues, BTW...

----------------------------------------------------------------------
Ad 1. "Ten Quirky Issues with Cross-Platform Version Control"

Actually those are two issues: troubles with different limitations of
different filesystems, and different dealing with line endings in text
files on different platforms.


Line endings (issue 8.) is in theory and in practice (at least for
Git) a non-issue. =20

In theory you should use project's convention for end of line
character in text files, and use smart editor that can deal (or can be
configured to deal) with this issue correctly.

In practice this is a matter of correctly setting up core.autocrlf
(and in more complicated cases, where more complicated means for git
very very rare, configuring which files are text and which are not).


There are a few classes of troubles with filesystems (with filenames).

1. Different limitations on file names (e.g. pathname length),
   different special characters, different special filenames (if any).
   Those are issues 2. (special basename PRN on MS Windows),=20
   issue 3. (trailing dot, trailing whitespace), issue 4. (pathname
   and filename length limit), issue 6. (special characters, in this
   case colon being path element delimiter on MacOS, but it is also
   about special characters like colon, asterisk and question mark
   on MS Windows) and also issue 7. (name that begins with dash)
   in Eric Sink article.

   The answer is convention for filenames in a project. Simply DON'T
   use filenames which can cause problems.  There is no way to simply
   solve this problem in version control system, although I think if
   you really, really, really need it you should be able to cobble
   something together using low-level git tools to have different name
   for filename in working directory from the one used in repository
   (and index).

   See also David A. Wheeler essay "Fixing Unix/Linux/POSIX Filenames:
   Control Characters (such as Newline), Leading Dashes, and Other Prob=
lems"=20
   http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html

   DON'T DO THAT.


2. "Case-insensitive" but "case-preserving" filesystems; the case
   where some different filenames are equivalent (like 'README' and
   'readme' on case-insensitive filesystem), but are returned as you
   created them (so if you created 'README', you would get 'README' in
   directory listing, but filesystem would return that 'readme' exists
   too).  This is issue 1. ('README' and 'readme' in the same
   directory) in Eric Sink article.

   The answer is like for previous issue: don't.  Simply DO NOT create
   files with filenames which differ only in case (like unfortunate
   ct_conntrack.h and cn_CONNTRACK.h or similar in Linux kernel).

   But I think that even in case where such unfortunate incident (two
   filenames differing only in case) occur, you can deal with it in
   Git by using lower level tools (and editing only one of two such
   files at once).  You would get spurious info about modified files
   in git-status, though...  perhaps that could be improved using
   infrastructure created (IIRC) by Linus for dealing with 'insane'
   filesystems.

   DON'T DO THAT, SOLVABLE.


3. Non "Case-preserving" filesystems, where filename as sequence of
   bytes differ between what you created, and what you get from
   filesystem.  An example here is MacOS X filesystem, which accepts
   filenames in NFC composed normalized form of Unicode, but stores
   them internally and returns them in NFD decomposed form.  This is
   issue 9. (Espa=F1ol being "Espa\u00f1ol" in NFC, but "Espan\u0303ol"
   in NFD).

   In this case 'don't do this' might be not acceptable answer.
   Perhaps you need non-ASCII characters in filenames.  Not always can
   you use filesystem or specify mount point option that makes it not
   a problem.

   I remember that this issue was discussed extensively on git mailing
   list, but I don't remember what was the conclusion (beside agreeing
   that filesystem that is not "*-preserving" is not sane filesystem ;)=
=2E
   In particular I do not remember if Git can deal with this issue
   sanely (I remember Linus adding infrastructure for that, but did it
   solve this problem...).

   PROBABLY SOLVED.


4. Filesystems which cannot store all SCM-sane metainfo, for example
   filesystems without support for symbolic links, or without support
   for executable permission (executable bit).  This is extension of
   issue 10. (which is limited to symbolic links) in Eric Sink
   article.

   In Git you have core.fileMode to ignore executable bit differences
   (you would need to use SCM tools and not filesystem tools to
   maniulate it), and core.symlinks to be able to checkout symlinks as
   plain text files (again using SCM tools to manipulate).

   SOLVED.


There is also mistaken implicit assumption that version control
systems have (and should) preserve all metadata.

5. The issue of extra metadata that is not SCM-sane, and which
   different filesystems can or cannot store.  Examples include full
   Unix permissions, Unix ownership (and groups file belongs to),
   other permission-related metadata such as ACL, extra resources tied
   to file such as EA (extended attributes) for some Linux filesystems
   or (in)famous resource form in MacOS.  This is issue 5. (resource
   fork on MacOS vs. xattrs on Linux) in Eric Sink article.

   This is not an issue for SCM: _source_ code management system
   to solve.  Preserving extra metadata indiscrimitedly can cause
   problems, like e.g. full permissions and ownership.  Therefore
   SCM preserve only limited SCM-sane subset of metadata.  If you
   need to preserve extra metadata, you can use (in good SCMs) hooks
   for that, like e.g. etckeeper uses metastore (in Git).

   NOT A PROBLEM.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
