From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Sun, 14 Sep 2008 14:12:28 -0700 (PDT)
Message-ID: <m3iqsymnyd.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
	<1221397685-27715-6-git-send-email-pclouds@gmail.com>
	<1221397685-27715-7-git-send-email-pclouds@gmail.com>
	<1221397685-27715-8-git-send-email-pclouds@gmail.com>
	<1221397685-27715-9-git-send-email-pclouds@gmail.com>
	<1221397685-27715-10-git-send-email-pclouds@gmail.com>
	<1221397685-27715-11-git-send-email-pclouds@gmail.com>
	<1221397685-27715-12-git-send-email-pclouds@gmail.com>
	<1221397685-27715-13-git-send-email-pclouds@gmail.com>
	<1221397685-27715-14-git-send-email-pclouds@gmail.com>
	<1221397685-27715-15-git-send-email-pclouds@gmail.com>
	<1221397685-27715-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Keyub-0005pG-Bo
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYINVMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 17:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbYINVMe
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:12:34 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:20109 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYINVMc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 17:12:32 -0400
Received: by el-out-1112.google.com with SMTP id z25so714640ele.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=tMcYntvy/uYb3b44yGZOBriIRXkuMEA1qlOflXMd8Rc=;
        b=SbAoGK/Y89cJNkuOwwXBTIV+x6TKnRsT4fkIB5wokOcndevAJBrjaWKEr2lR4Zs4pB
         UG9hblaUkuHnLdsX7akifHp+7QOzJttjImUz0ZODBQd7JLT/i3cfNjk2iAhL6P4L/CAY
         QQRT2IFKp6eplV3ZHXqreGJaCUHQ4V0fwgMOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=hJD7xUYUYwsIgq89K5/RTlChuI7sPP4uPMiOWLUNRn9lBQmJnNfPCSpIje2kXitNrc
         JQfU9ZOVIWUxGVz5FsGNopDEWnM/b0d4ux08NtOOP8X5XV3Bvotm19QfSpjqaoz3TFO+
         JqE6JrpBCV/7+nUVGGVwk4wtAQT4b/uQ71b7I=
Received: by 10.86.60.15 with SMTP id i15mr5327762fga.14.1221426749234;
        Sun, 14 Sep 2008 14:12:29 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id 4sm16310133fge.8.2008.09.14.14.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 14:12:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8ELCRcd014975;
	Sun, 14 Sep 2008 23:12:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8ELCQaJ014972;
	Sun, 14 Sep 2008 23:12:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-16-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95864>

I will comment only on the documentation...

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> These options include:
>=20
>  --full: return to full checkout (default)
>  --path: narrow checkout to some areas according to given spec
>  --add-path/--remove-path: adjust current narrow checkout

Hmmm... I'm not sure if such formatting of commit message, with
body being not independent on the subject (first line of commit
message) is a good idea.

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
[...]
> +--full::
> +	Quit narrow checkout mode. Return to full checkout.
> +
> +--path=3D<narrow_spec>::
> +	Re-apply new narrow spec on current working directory to
> +	form new checkout area.
> +
> +--add-path=3D<narrow_spec>::
> +	Checkout more areas specified by narrow spec to current
> +	checkout area.
> +
> +--remove-path=3D<narrow_spec>::
> +	Narrow checkout area by removing files specified by narrow spec
> +	from current checkout area. This operation will fail if there
> +	is unmerged or modified files in the removing areas.

Subversion from version 1.5 supports something called "Sparse directori=
es",
http://blogs.open.collab.net/svn/2007/06/sparse-director.html (as point=
ed
out by Bjorn Steinbrink (doener_) on #git).  Subversion has the followi=
ng
options for 'svn checkout':

  -N::
  --non-recursive::
         Checkout only the main directory of the trunk and not the
         sub-directories
   --depth=3Dempty::
         Updates will not pull in any files or subdirectories not
         already present.
   --depth=3Dfiles::
         Updates will pull in any files not already present,
         but not subdirectories.
   --depth=3Dimmediates:: =20
         Updates will pull in any files or subdirectories not
         already present; the subdirectories will have depth=3Dempty.
   --depth=3Dinfinity::
         Updates will pull in any files or subdirectories not
         already present; the subdirectories will have depth=3Dinfinity=
=2E
         Equivalent to today's default update behavior.

I'm not sure if those ways of limiting are worth implementing, but
I guess that they are at least worth thinking about.

> +Narrow checkout
> +---------------
> +
> +Normally when you do checkout a branch, your working directory
> +will be fully populated. In some situations, you just need to
> +work on certain files, no full checkout is required. Narrow
> +checkout is a mode that limits checkout area according to your
> +rules.

Perhaps s/required/needed/?

> +
> +Because narrow checkout uses new index format, it will be
> +incompatible with git prior to 1.6.0. In order to make your
> +working directory work with those versions, you can use `git
> +checkout --full` to return to normal mode (and compatible index
> +format).

Very nice to have those compatibility concerns mentioned upfront.
In short: new feature, wouldn't work with git prior to 1.6.0.

I hope that nobody mistakes _working_ with repository with=20
partial / sparse / narrow checkout, which requires >=3D 1.6.0,
with being able to clone / fetch such repository, where there
are no limitations, contrary for example to what was for submodule
support.

> +
> +Narrow works by applying your rules to the index, marking which
> +file you need and which file you need not. Modified/Unmerged
> +files cannot be marked unneeded. Unnecessary files will be
> +removed from working directory.  Note that after this step,
> +removed files can still be added to working directory when they
> +are needed by any git command. For example, when you have a merge
> +conflict, conflicted files will be checked out on working
> +directory and will no longer be marked "unneeded".

This paragraph I think need some more love...

So the "checkout rules" are meant to mark which paths are "wanted"
or "needed", and we would like to have in the checkout, and which
files are "unwanted" or "not needed" ("unneeded"?) and we want to
not have them present in working directory; something akin to accept
and deny rules, isn't it?

What are the rules, does all files except those marked explicitely
as needed are unneeded, or do you have to first mark all files as
unneeded?

How would the following table look like:

  working directory  || needed       | not needed    |
  ----------------------------------------------------
  file is absent     || checkout     | no change     |
  file is present    || no change    | removed       |
  file is modified   || conflict     | conflict?     |

> +
> +New files after merges will always be "needed". You can also
> +apply rules when switching branches to avoid unwanted new files.

Does it mean that if merge brings some new files, then those
files would be "needed" (without "no checkout" bit)?

What does it mean this sentence about switching branches:
how does partial/sparse/narrow checkout rules change when
switching to other branch (which, like 'html' and 'todo'
branches in git repository, can be completely unrelated)?

> +
> +Files that are marked "no-checkout" will be treated like entries
> +with "assume-unchanged bit" (see linkgit:git-update-index[1]). In
> +short, Git will never look for those files in working directory
> +no matter whether they exist in working directory.

Perhaps add that they would be marked with "no checkout" bit, and
refer to --no-checkout flag of git-update-index?  I'm not sure here
about that...

> +
> +You can apply your rules at once with --path option, or do it
> +incrementally with --add-path and --remove-path.

Nice.

> +
> +Narrow spec will be used to specify how you want to narrow your
> +checkout. It is a list of pathspecs separated by colons. Each
> +patchspec specifies what files should be checked out on working
> +directory. Pathspec can contain wildcards and is relative to
> +current working directory. Usually asterisk (*) does not match
> +slashes. If a pathspec is prefixed by a plus sign (+), then
> +any asterisk will match anything, even slashes.

=46irst, does this mean that you can specify paths containing colons
(':') only using --add-path and --remove-path, or does it mean that
you cannot specify paths containg colon ':' (which should be rare)
at all as checkout limiter / checkout narrowing rule?

Second, wouldn't it be better to use '**' to match also '/'?
Changing meaning of '*' using per-path flag seems a bit bad.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
