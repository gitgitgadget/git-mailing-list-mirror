From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] l10n:gitk: Init Vietnamese translation
Date: Sat, 14 Dec 2013 10:13:04 +0700
Message-ID: <CACsJy8BAYeCDZkeNtGTKNGdYmWk=Ub8jV7uNhVU7bqZ1ko30kw@mail.gmail.com>
References: <1386988922-10199-1-git-send-email-vnwildman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-malling-list <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Tran Ngoc Quan <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 04:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrffy-00067c-1A
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 04:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab3LNDNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 22:13:36 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:56434 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3LNDNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Dec 2013 22:13:35 -0500
Received: by mail-qc0-f175.google.com with SMTP id e9so2200762qcy.34
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 19:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CuRfUS5cWG6CbXWmlSI62iKl3UbyQnTQSX/9jwuvd70=;
        b=vZOGw234+AJF4r9t+37nsmPr8VkGFICykA3ECHj0avZbOgIqArl2kR+eab6FdYy6Ap
         CCJqrjJTNahGEPFMAR2/CM57ZuxIYFrd+BIAru8h/qUuqLOFQJyVX/0SpdhD7bMuFnKz
         PISxwNpYEdy99padH3XFJy9mjUguRdmmQu/8SKQvpgG+Hb/Z8T/QY1x+ORhc/bhDlKp/
         HjdNOGcZtwsz5EBQLySUzefRD7EZWVpiN2g+FG4Dy2VT/m355U8E2UwBkkY9uCzOO6V4
         ZwDYPMcy1Zcu0Gm8GdAFnQFtwMviPfgPGXBBcByARhcJ13wAjnzp930B1746pyoStF+6
         Aumw==
X-Received: by 10.224.51.74 with SMTP id c10mr10830234qag.7.1386990815020;
 Fri, 13 Dec 2013 19:13:35 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Fri, 13 Dec 2013 19:13:04 -0800 (PST)
In-Reply-To: <1386988922-10199-1-git-send-email-vnwildman@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239279>

You should have copied Paul, gitk maintainer. I think Junio only pulls
gitk patches from him, not random ones on the list. +Paul as I have
something to say about gitk itself, not just the translations.

2013/12/14 Tran Ngoc Quan <vnwildman@gmail.com>:
> +#: gitk:494 gitk:4429
> +msgid "Reading commits..."
> +msgstr "=C4=90ang =C4=91=E1=BB=8Dc c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83=
n giao..."
> +
> +#: gitk:497 gitk:1635 gitk:4432
> +msgid "No commits selected"
> +msgstr "Ch=C6=B0a ch=E1=BB=8Dn c=C3=A1c l=E1=BA=A7n chuy=E1=BB=83n g=
iao"
> +
> +#: gitk:1738
> +msgid "No commit information available"
> +msgstr "Kh=C3=B4ng c=C3=B3 th=C3=B4ng tin v=E1=BB=81 l=E1=BA=A7n chu=
y=E1=BB=83n giao n=C3=A0o"

I'd rather keep "commit" untranslated until we find a Vietnamese word
that fits the concept. I see you keep "commit" in many strings down,
perhaps keep them here too for consistent?

> +#: gitk:2066
> +msgid "File"
> +msgstr "Ch=C3=ADnh"

This keeps bugging me. Why do GUI apps always name the first menu
"File" even if it has nothing to do with files? Should gitk rename
"File" to "General", "Main" or something?

> +#: gitk:2287 gitk:4757 gitk:6621
> +msgid "IgnCase"
> +msgstr "BquaHt"
> +
> +#: gitk:2287 gitk:4639 gitk:4755 gitk:6617
> +msgid "Regexp"
> +msgstr "BTCQ"

This is in a drop box whose width is auto adjusted to fit the text. I
think you could translate as if the original strings are "Ignore case"
and "Regular expression" (and perhaps gitk should update "IgnCase" to
"Ignore Case" as well)

> +#: gitk:2291 gitk:4774 gitk:6684 gitk:7220
> +msgid "Committer"
> +msgstr "Ng=C6=B0=E1=BB=9Di chuy=E1=BB=83n giao"

"Ng=C6=B0=E1=BB=9Di commit" may be more inline if you keep "commit" uns=
tranlated.

> +#: gitk:2330
> +msgid "Diff"
> +msgstr "Diff"

"So s=C3=A1nh" maybe?

> +#: gitk:3991
"> +msgid "Committer:"
> +msgstr "Ng=C6=B0=E1=BB=9Di g=E1=BB=ADi:"

Inconsistent with the previous translation above.

> +#: gitk:11235
> +#, tcl-format
> +msgid "Maximum graph width (% of pane)"
> +msgstr "=C4=90=E1=BB=99 r=E1=BB=99ng bi=E1=BB=83u =C4=91=E1=BB=93 t=E1=
=BB=91i =C4=91a (% c=E1=BB=A7a b=E1=BA=A3ng hi=E1=BB=83n)"

Not sure what "b=E1=BA=A3ng hi=E1=BB=83n" means, perhaps "b=E1=BA=A3ng"=
 is enough?

> +#: gitk:11341
> +msgid "Main font"
> +msgstr "C=E1=BB=A1 ph=C3=B4ng ch=E1=BB=AF ch=C3=ADnh"

Remove "C=E1=BB=A1"? There's no "size" in the original string.
--=20
Duy
