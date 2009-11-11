From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Consensus on "Git"
Date: Wed, 11 Nov 2009 09:21:26 +0000
Message-ID: <3f4fd2640911110121y17f0d78boadf803502e04475d@mail.gmail.com>
References: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:21:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N89OR-0006zZ-Vr
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 10:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbZKKJVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 04:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbZKKJVX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 04:21:23 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:60127 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbZKKJVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 04:21:21 -0500
Received: by vws30 with SMTP id 30so262294vws.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 01:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IouP42hqDwciVsJn78Z6XqTOMq/WZzLZ23qvRFkXq84=;
        b=RLmpO9D29T/z+kyuqAN8DJ0XA9g+rC7zvtVUh7t8TKo2jGdjSlsDY/Ere/S28InuJp
         5LiIVoFKgm1u7p2Lw17WWqtM/rirIzmuYfBUfsyF0ZbJAtAUKMgsh6TW/ojTvquzYfC8
         pezw4kSdZqaTI3VmasFuSHJRrM84QxQqEZBXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sJTP1TCjWq8qGJNzpPPXSgEWlBUWhZDo+cgzmAj4ztqwvONdfXG1Bt4iwdeUJIFLEq
         7/EbgTFZe7uR7dtSe3sY2hOzW6LxwLsrKvUwINwvUpQWviK50K7Qpn9s2TcSV903D6Q4
         wuCPv5Ypg5ZNS1PQbJeIf58O2YUkYR8HV4rEU=
Received: by 10.220.125.7 with SMTP id w7mr1537163vcr.14.1257931286126; Wed, 
	11 Nov 2009 01:21:26 -0800 (PST)
In-Reply-To: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132629>

2009/11/11 David Symonds <dsymonds@gmail.com>:
> Hi folks,
>
> Is there consensus on "Git" being the standard capitalisation, versus
> "GIT"? I only really see "git" and "Git" on the mailing list and in
> most external documentation and websites (e.g. git-scm.com and
> github.com), but git's source tells a different picture:
>
> $ cat *.[ch] | egrep -o '\bG[Ii][Tt]\b' | sort | uniq -c
> =A036 GIT
> =A0 7 Git
> $ cat Documentation/* 2> /dev/null | egrep -o '\bG[Ii][Tt]\b' | sort =
| uniq -c
> =A0284 GIT
> =A0155 Git

All upper case in the sources and documentation will mean that it is
either an environment variable (e.g. GIT_INSTALL_DIR as Sverre has
noted), and for preprocessor constants/definitions.

However, those are not what you are searching for. I.e.

$ grep -P '\bGIT\b' *.[ch]
builtin-apply.c:	 * We have read "GIT binary patch\n"; what follows is =
a line
builtin-apply.c:		static const char git_binary[] =3D "GIT binary patch\=
n";
builtin-cat-file.c: * GIT - The information manager from hell
builtin-check-ref-format.c: * GIT - The information manager from hell
builtin-commit-tree.c: * GIT - The information manager from hell
builtin-diff-files.c: * GIT - The information manager from hell
builtin-init-db.c: * GIT - The information manager from hell
builtin-ls-tree.c: * GIT - The information manager from hell
builtin-mktree.c: * GIT - the stupid content tracker
builtin-read-tree.c: * GIT - The information manager from hell
builtin-update-index.c: * GIT - The information manager from hell
builtin-write-tree.c: * GIT - The information manager from hell
config.c: * GIT - The information manager from hell
date.c: * GIT - The information manager from hell
diff.c:	fprintf(file, "GIT binary patch\n");
diff-delta.c: * Rewritten for GIT by Nicolas Pitre <nico@fluxnic.net>,
(C) 2005-2007
fast-import.c:     # GIT does not permit ':' in ref or tag strings.
fast-import.c:  path    ::=3D # GIT style file path, e.g. "a/b/c";
fast-import.c:  ref     ::=3D # GIT ref name, e.g.
"refs/heads/MOZ_GECKO_EXPERIMENT";
fast-import.c:  tag     ::=3D # GIT tag name, e.g. "FIREFOX_1_5";
fast-import.c:  sha1exp ::=3D # Any valid GIT SHA1 expression;
fast-import.c:  name  ::=3D # valid GIT author/committer name;
fast-import.c:  email ::=3D # valid GIT author/committer email;
fast-import.c:  tz    ::=3D # GIT style timezone;
fast-import.c:		die("Branch name doesn't conform to GIT standards: %s",=
 name);
hash-object.c: * GIT - The information manager from hell
progress.c: * Simple text-based progress display module for GIT
read-cache.c: * GIT - The information manager from hell
read-cache.c: * cache, ie the parts that aren't tracked by GIT, and onl=
y used
sha1_file.c: * GIT - The information manager from hell
sha1_file.c:				     " (try upgrading GIT to a newer version)",
sha1_file.c:		return error("file %s is not a GIT packfile", p->pack_nam=
e);
sha1_file.c:			" supported (try upgrading GIT to a newer version)",
trace.c: * GIT - The information manager from hell
usage.c: * GIT - The information manager from hell
var.c: * GIT - The information manager from hell

And selected extracts from:

$ grep -P '\bGIT\b' Documentation/*
Documentation/asciidoc.conf:# Show GIT link as: <command>(<section>);
if section is defined, else just show
Documentation/everyday.txt:Everyday GIT With 20 Commands Or So
Documentation/everyday.txt:My typical GIT day.::
Documentation/git-tools.txt:   providing generally smoother user
experience than the "raw" Core GIT
Documentation/git-tools.txt:   is now in core GIT.
Documentation/git-tools.txt:   pg is a shell script wrapper around GIT
to help the user manage a set of
Documentation/git-tools.txt:   Stacked GIT provides a quilt-like patch
management functionality in the
Documentation/git-tools.txt:   GIT environment. You can easily manage
your patches in the scope of GIT
Documentation/git-tools.txt:   gitk is a simple Tk GUI for browsing
history of GIT repositories easily.
Documentation/git-tools.txt:   GITweb provides full-fledged web
interface for GIT repositories.
Documentation/git-tag.txt:GIT
Documentation/RelNotes-1.6.1.txt:GIT v1.6.1 Release Notes

- Reece
