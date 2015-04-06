From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 25/25] list-files: documentation
Date: Mon, 6 Apr 2015 17:37:09 -0400
Message-ID: <CAPig+cR+-j6HJffMjhWiVjd1tVKaQKe9-dgJMtOcB_7AeKE9UQ@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-26-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEho-0007Ug-Go
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbbDFVhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:37:12 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33171 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbDFVhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:37:10 -0400
Received: by lbbzk7 with SMTP id zk7so28909444lbb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=96lkqItNoFdClGj6uvxx1pRETwXbN/NLSNRx3+j8nvc=;
        b=DJOAkcDSP9kJfXEOaxfG/kHm6zm95mLyMc3jgHLDpp7c3E32tUoEtis/DX5417+JoR
         2KZIGyy0akbJ5gzBjWNP26LcPiQ85d6xd8o5m6tAonCQPRhgdNl7M5ykk9LQQzWPVo63
         2vKnkb/WgU4bICJxLXtjAZkwdr4O3s9aicknsoFaEZ2UEiPCO1/08ulJ0gzyQFFxsoix
         CUMG6I+U/1YpGAhJ9NZcWLvfBQ/bRhLD91NzMgRFUqOpP6aJ4Roy09llM4rP3brVfrpX
         9fzX98k8N6Pb5zGMGHlZmuKyPRxLXnQhfJWsLu8QiFOg+MEX1YMuJ5/3gg4d2Qv2XPZR
         3pHQ==
X-Received: by 10.152.2.130 with SMTP id 2mr14912801lau.120.1428356229117;
 Mon, 06 Apr 2015 14:37:09 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:37:09 -0700 (PDT)
In-Reply-To: <1428328354-14897-26-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: MaazvHzbMuPkKr_xKcbq---aDVU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266888>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-list-files.txt b/Documentation/git-lis=
t-files.txt
> new file mode 100644
> index 0000000..9b9edce
> --- /dev/null
> +++ b/Documentation/git-list-files.txt
> @@ -0,0 +1,115 @@
> +git-list-files(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-list-files - List files
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git list-files [options] [<pathspec>...]
> +
> +DESCRIPTION
> +-----------
> +List files (by default in current working directory) that are in the
> +index. Depending on the chosen options, maybe only modified files in
> +working tree are shown, or untracked files... The builtin alias "ls"
> +is set to "list-files".
> +
> +OPTIONS
> +-------
> +-c::
> +--cached::
> +       Show cached files (default)

Here and elsewhere: s/$/./

> +-d::
> +--deleted::
> +       Show deleted files in index, compared to HEAD
> +
> +-a::
> +--added::
> +       Show added files in index, compared to HEAD
> +
> +-m::
> +--modified::
> +       Show modified files in index, compared to HEAD. This implies
> +       --deleted and --added

s/--deleted/`--deleted`/
s/--added/`--added`/

> +-D::
> +--wt-deleted::
> +       Show deleted files in working directory
> +
> +-A::
> +--wt-added::
> +       Show added files in working directory
> +
> +-M::
> +--wt-modified::
> +       Show modified files in working directory. This implies
> +       --wt-deleted and --wt-added

s/--wt-deleted/`--wt-deleted`/
s/--wt-added/`--wt-added`/

> +-o::
> +--others::
> +       Show untracked files (and only unignored ones unless -i is

s/-i/`-i`/ ...or... s/-i/`--ignored`/

> +       specified)
> +
> +-i::
> +--ignored::
> +       Show only ignored files. When showing files in the index,
> +       print only those matched by an exclude pattern. When showing
> +       "other" files, show only those matched by an exclude pattern.
> +
> +-u::
> +--unmerged::
> +       Show unmerged files
> +
> +-F::
> +--classify::
> +       Append indicator (one of `*/=3D>@|&`, which is executable,
> +       directory, socket, Solaris door, symlink, fifo, or submodule
> +       respectively) to entries.
> +
> +--color[=3D<when>]::
> +--no-color::
> +       Color file names. The value must be `always`, `never`, or
> +       `auto`. `--no-color` is equivalent to
> +       `--color=3Dnever`. `--color` is equivalent to
> +       `--color=3Dauto`. See configuration variable `color.list-file=
s`

Is 'color.list-files' documented anywhere?

> +       for the default settings.
> +
> +--column[=3D<options>]::
> +--no-column::
> +-1::
> +       Display files in columns. See configuration variable column.u=
i

s/column.ui/`column.ui`/

> +       for option syntax. `--column` and `--no-column` without optio=
ns
> +       are equivalent to 'always' and 'never' respectively.
> +       `-1` is a shortcut for --no-column.

s/--no-column/`--no-column`/

> +--max-depth=3D<depth>::
> +--recursive::
> +-R::
> +       For each <pathspec> given on command line, descend at most <d=
epth>
> +       levels of directories. A negative value means no limit.
> +       This option is ignored if <pathspec> contains active wildcard=
s.
> +       In other words if "a*" matches a directory named "a*",
> +       "*" is matched literally so --max-depth is still effective.

s/--max-depth/`--max-depth`/

> +       `-R` or `--recursive` is equivalent of `--max-depth=3D-1`
> +       (infinite recursion).  The default is `--max-depth=3D0`.
> +
> +--tag::
> +--no-tag::
> +       Usually when tags are displayed by the left of the file name =
if
> +       there are more than one file selection. Use either of these o=
ptions
> +       to force always or never display tags.

This is somewhat difficult to parse. Perhaps it could be rephrased
something like this:

    If the disposition of listed files differs from one another, then
    tags ("D" deleted, "M" modified, etc.) are displayed in front of
    the file names; otherwise tags are suppressed. These options
    override the the behavior and explicitly show or suppress tags,
    respectively.

> +
> +<pathspec>::
> +       Files to show. :(glob) magic is enabled by default.
> +
> +SEE ALSO
> +--------
> +linkgit:git-ls-files[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> --
> 2.3.0.rc1.137.g477eb31
