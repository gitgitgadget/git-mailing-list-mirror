From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Initial Japanese gitk translation
Date: Sun, 05 Apr 2009 18:40:56 -0700
Message-ID: <7vws9ymudz.fsf@gitster.siamese.dyndns.org>
References: <FD6CAD0757FA434C91E904C1F202CBA1@DELL300>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "FORS Luis" <l-fors@cerca-jp.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 03:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqdrM-0003ZW-QL
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 03:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbZDFBlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 21:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbZDFBlH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 21:41:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZDFBlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 21:41:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A861AA8856;
	Sun,  5 Apr 2009 21:41:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 32BB0A8855; Sun,
  5 Apr 2009 21:40:57 -0400 (EDT)
In-Reply-To: <FD6CAD0757FA434C91E904C1F202CBA1@DELL300> (FORS Luis's message
 of "Mon, 6 Apr 2009 09:15:05 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC30EC5C-224B-11DE-995A-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115749>

"FORS Luis" <l-fors@cerca-jp.com> writes:

"FORS Luis" <l-fors@cerca-jp.com> writes:

> My name is Luis Fors. I'm not a great Japanese speaker, and I have
> almost zero knowledge of tcl and getttext, but all of my coworkers ar=
e
> Japanese, and I couldn't just wait around for a translation to appear=
=2E
>
> This is my first time contributing, and I have no idea what I'm doing=
,
> so be please be gentle.
>
> This is a patch against gitk.git 5fdcbb13904e6...
>
> Feel free to bang this into whatever shape is necessary to include
> this in the next release.
>
> Thank you.

Judged by a native speaker (that is me), there are some funny translati=
ons
we may want to fix up, but it should serve as a good basis for anybody =
to
whip it into shape good enough and forward it to Paul to be merged.

Thanks.

> +#: gitk:113
> +msgid "Couldn't get list of unmerged files:"
> +msgstr "=E6=9C=AA=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=95=E3=82=A1=E3=82=
=A4=E3=83=AB=E3=81=AE=E3=83=AA=E3=82=B9=E3=83=88=E3=82=92=E3=82=B2=E3=83=
=83=E3=83=88=E5=87=BA=E6=9D=A5=E3=81=9A=EF=BC=9A"

You are using =E3=81=A7=E3=81=99=E3=83=BB=E3=81=BE=E3=81=99 style throu=
ghout the translation, so you would
want to say:

    =E6=9C=AA=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=95=E3=82=A1=E3=82=A4=E3=83=
=AB=E3=81=AE=E3=83=AA=E3=82=B9=E3=83=88=E3=82=92=E5=8F=96=E5=BE=97=E3=81=
=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93

or something like that.

> +#: gitk:340
> +msgid "No files selected: --merge specified but no files are unmerge=
d."
> +msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=8C=E9=81=B8=E6=8A=
=9E=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93=EF=BC=
=9A--merge=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=E3=81=8C=E6=8C=87=
=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=9F=E3=81=AE=E3=81=AB=E6=9C=AA=E3=83=9E=
=E3=83=BC=E3=82=B8=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AF=E3=81=82=
=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82"
> +
> +#: gitk:343
> +msgid "No files selected: --merge specified but no unmerged files ar=
e within file limit."
> +msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=8C=E9=81=B8=E6=8A=
=9E=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93=EF=BC=
=9A--merge=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=E3=81=8C=E6=8C=87=
=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=9F=E3=81=AE=E3=81=AB=E9=81=B8=E6=8A=9E=
=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AA=
=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=
=E5=90=AB=E3=81=BF=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82No hay archivos s=
eleccionados: se seleccion=C3=B3 la opci=C3=B3n --merge pero los archiv=
os especificados no necesitan fusi=C3=B3n."

No habla Espa=C3=B1ol, perd=C3=B3name.

> +#: gitk:1813
> +msgid "Reread references"
> +msgstr "=E7=85=A7=E4=BC=9A=E6=83=85=E5=A0=B1=E5=86=8D=E8=AA=AD=E8=BE=
=BC"
> +
> +#: gitk:1814
> +msgid "List references"
> +msgstr "=E7=85=A7=E4=BC=9A=E6=83=85=E5=A0=B1=E5=87=BA=E5=8A=9B"

I have never seen ref and reference translated as =E7=85=A7=E4=BC=9A in=
 the context of
git.

There are some people working on translating the documentation; a good
starting point would be:

    http://www8.atwiki.jp/git_jp/

and the glossary's translation is here.

    http://github.com/yasuaki/git-manual-jp/blob?path[]=3DDocumentation=
&path[]=3Dglossary.txt&raw=3Dtrue

They translate "ref" as =E5=8F=82=E7=85=A7 which may not be best but lo=
oks better than
=E7=85=A7=E4=BC=9A.  I wrote a magazine article in Japanese and I ended=
 up calling them
just =E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9 --- write p=
ronunciation in kana which is a universal
cop-out X-<.

> +msgid "Exact"
> +msgstr "=E5=AE=8C=E5=85=A8=E3=81=AA=E4=B8=80=E8=87=B4"

I'd drop =E3=81=AA if I were translating this

> +#: gitk:1970
> +#: gitk:3773
> +#: gitk:5518
> +msgid "IgnCase"
> +msgstr "=E5=A4=A7=E5=B0=8F=E6=96=87=E5=AD=97=E3=82=92=E5=8C=BA=E5=88=
=A5=E3=81=9B=E3=81=9A"

I'd say =E5=8C=BA=E5=88=A5=E3=81=97=E3=81=AA=E3=81=84 instead of =E5=8C=
=BA=E5=88=A5=E3=81=9B=E3=81=9A as the rest is in =E3=81=A7=E3=81=99=E3=83=
=BB=E3=81=BE=E3=81=99
style.

> +msgid "Author"
> +msgstr "=E4=BD=9C=E8=80=85"
> +
> +msgid "Committer"
> +msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E8=80=85"

I used =E8=91=97=E8=80=85 for Author and =E8=A8=98=E9=8C=B2=E8=80=85 fo=
r Committer.  The translated glossary
I mentioned earlier seems to agree with me on Author (it cops out on
committer by saying "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=97=E3=81=
=9F=E4=BA=BA").

> +msgid "Diff this -> selected"
> +msgstr "=E3=81=93=E3=82=8C=E2=86=92=E9=81=B8=E6=8A=9E=E3=82=92diff"
> +msgid "Diff selected -> this"
> +msgstr "=E9=81=B8=E6=8A=9E=E2=86=92=E3=81=93=E3=82=8C=E3=82=92diff"

Perhaps

    =E3=80=8C=E3=81=93=E3=82=8C=E3=81=A8=E9=81=B8=E6=8A=9E=E3=81=97=E3=81=
=9F=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AE=E5=B7=AE=E5=88=86=E3=82=
=92=E8=A6=8B=E3=82=8B=E3=80=8D
    =E3=80=8C=E9=81=B8=E6=8A=9E=E3=81=97=E3=81=9F=E3=82=B3=E3=83=9F=E3=83=
=83=E3=83=88=E3=81=A8=E3=81=93=E3=82=8C=E3=81=AE=E5=B7=AE=E5=88=86=E3=82=
=92=E8=A6=8B=E3=82=8B=E3=80=8D

If you can affored to go a bit longer, I'd say =E3=81=93=E3=81=AE=E3=82=
=B3=E3=83=9F=E3=83=83=E3=83=88 instead of =E3=81=93
=E3=82=8C here, though.

> +#: gitk:2245
> +msgid "Blame parent commit"
> +msgstr "=E8=A6=AA=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E8=B2=
=AC=E3=82=81=E3=82=8B"

This is a hard one ;-) =20

> +msgstr "<%s-Down>\t=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AE=E3=83=
=AA=E3=82=B9=E3=83=88=E3=82=92=E4=B8=80=E8=A1=8C=E4=B8=8B=E3=81=B8=E3=82=
=B9=E3=82=AF=E3=83=AD=E3=83=BC=E3=83=AB"
> +
> +#: gitk:2532
> +#, tcl-format
> +msgid "<%s-PageUp>\tScroll commit list up one page"
> +msgstr "<%s-PageUp>\t=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AE=E3=
=83=AA=E3=82=B9=E3=83=88=E3=82=92=E4=B8=80=E3=83=9A=E3=83=BC=E3=82=B8=E4=
=B8=8A=E3=81=B8=E3=82=B9=E3=82=AF=E3=83=AD=E3=83=BC=E3=83=AB"
> +
> +#: gitk:2533
> +#, tcl-format
> +msgid "<%s-PageDown>\tScroll commit list down one page"
> +msgstr "<%s-PageDown>\t=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AE=
=E3=83=AA=E3=82=B9=E3=83=88=E3=82=92=E4=B8=80=E3=83=9A=E3=83=BC=E3=82=B8=
=E4=B8=8B=E3=81=B8=E3=82=B9=E3=82=AF=E3=83=AD=E3=83=BC=E3=83=AB"
> +
> +#: gitk:2534
> +msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
> +msgstr "<Shift-Up>\t=E5=BE=8C=E9=80=B2=E3=81=B8=E6=A4=9C=E7=B4=A2=EF=
=BC=88=E3=81=86=E3=81=88=E3=81=AE=E6=96=B0=E3=81=97=E3=81=84=E3=83=AA=E3=
=83=93=E3=82=B8=E3=83=A7=E3=83=B3=E3=81=B8=EF=BC=89"

=E9=80=86=E6=96=B9=E5=90=91=E6=A4=9C=E7=B4=A2 =E3=81=86=E3=81=88 should=
 be =E4=B8=8A

> +#: gitk:2535
> +msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
> +msgstr "<Shift-Down>\t=E5=89=8D=E9=80=B2=E3=81=B8=E6=A4=9C=E7=B4=A2=EF=
=BC=88=E4=B8=8B=E3=81=AE=E5=8F=A4=E3=81=84=E3=83=AA=E3=83=93=E3=82=B8=E3=
=83=A7=E3=83=B3=E3=81=B8=EF=BC=89"

=E5=89=8D=E6=96=B9=E5=90=91=E6=A4=9C=E7=B4=A2

> +msgid "Local changes checked in to index but not committed"
> +msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=
=AB=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=82=8B=E6=9C=AA=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E5=A4=89=E6=9B=B4"
> +
> +#: gitk:4220
> +msgid "Local uncommitted changes, not checked in to index"
> +msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=
=AE=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E6=9C=AA=E3=82=
=B3=E3=83=9F=E3=83=83=E3=83=88=E5=A4=89=E6=9B=B4"

=E3=80=8C=E3=81=AB=E3=80=8D=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=81=AA=
=E3=81=84=E3=80=82not=E3=80=8C=E3=81=AE=E3=80=8D

> +msgid "Short SHA1 id %s is ambiguous"
> +msgstr "%s=E3=82=92=E5=90=AB=E3=82=80SHA1=E3=81=8C=E8=A4=87=E6=95=B0=
=E5=AD=98=E5=9C=A8=E3=81=99=E3=82=8B"

Good job!!

> +#: gitk:7146
> +#, tcl-format
> +msgid "SHA1 id %s is not known"
> +msgstr "SHA1=E3=81=AE%s=E3=81=AF=E4=B8=8D=E6=98=8E"

You probably do not want =E3=81=AE here.

> +#: gitk:7430
> +msgid "Reverse"
> +msgstr "=E5=BE=8C=E9=80=B2"

I am not sure about the context of this message but shouldn't it be =E5=
=BE=8C=E9=80=80?

> +msgid "Tag \"%s\" already exists"
> +msgstr "=E3=82=BF=E3=82=B0\"%s\"=E3=81=8C=E6=97=A2=E3=81=AB=E5=AD=98=
=E5=9C=A8=E3=81=99=E3=82=8B"

=E3=83=BB=E3=83=BB=E3=83=BB=E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=
=E3=81=97=E3=81=BE=E3=81=99

> +#: gitk:7708
> +msgid "Cherry-picking"
> +msgstr "=E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=E3=83=B3=E3=82=92=E4=BB=
=BB=E6=84=8F=E3=81=AB=E5=BD=93=E3=81=A6=E3=81=AF=E3=81=BE=E3=82=8B=EF=BC=
=88cherry-picking=EF=BC=89"

=E5=BD=93=E3=81=A6=E3=81=AF=E3=80=8C=E3=82=81=E3=80=8D=E3=82=8B, perhap=
s?

> +#: gitk:7755
> +msgid "Soft: Leave working tree and index untouched"
> +msgstr "=E8=BB=9F=E3=82=89=E3=81=8B=E3=81=84=EF=BC=9A=E3=83=96=E3=83=
=A9=E3=83=B3=E3=83=81=E3=82=82=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=
=AF=E3=82=B9=E3=82=82=E3=81=9D=E3=81=AE=E3=81=BE=E3=81=BE"
> +
> +#: gitk:7758
> +msgid "Mixed: Leave working tree untouched, reset index"
> +msgstr "=E4=B8=AD=E5=BA=B8=EF=BC=9A=E3=83=96=E3=83=A9=E3=83=B3=E3=83=
=81=E3=82=92=E8=A7=A6=E3=82=8C=E3=81=9A=E3=81=AB=E3=82=A4=E3=83=B3=E3=83=
=87=E3=83=83=E3=82=AF=E3=82=B9=E3=82=92=E3=83=AA=E3=82=BB=E3=83=83=E3=83=
=88"
> +#: gitk:7761
> +msgid ""
> +"Hard: Reset working tree and index\n"
> +"(discard ALL local changes)"
> +msgstr ""
> +"=E7=A1=AC=E3=81=84=EF=BC=9A=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=
=A8=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=82=92=E3=83=
=AA=E3=82=BB=E3=83=83=E3=83=88\n"
> +"=EF=BC=88=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=E5=A4=89=E6=9B=B4=E3=81=
=8C=E5=85=A8=E3=81=A6=E7=A0=B4=E5=A3=8A=E3=81=95=E3=82=8C=E3=82=8B=EF=BC=
=81=EF=BC=89"

These are hard ones.  I'd leave Soft/Mixed/Hard labels in
English/alphabets if I were doing this, though.

> +msgid "The commits on branch %s aren't on any other branch.\nReally =
delete branch %s?"
> +msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81%s=E3=81=8C=E4=B8=80=E6=84=
=8F=E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=E3=83=B3=E3=82=92=E5=90=AB=E3=82=
=80=E3=80=82\n=E3=81=9D=E3=82=8C=E3=81=A7=E3=82=82=E5=89=8A=E9=99=A4=E3=
=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=9F"

=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81%s=E3=81=AB=E3=81=AF=E4=BB=96=E3=83=
=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=AB=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=
=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E3=82=B3=E3=83=9F=E3=83=
=83=E3=83=88=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82=E3=81=
=9D=E3=82=8C=E3=81=A7=E3=82=82=E3=83=BB=E3=83=BB=E3=83=BB

> +#: gitk:9934
> +msgid ""
> +"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
> +" Gitk requires at least Tcl/Tk 8.4."
> +msgstr ""
> +"gitk=E3=81=AF=E7=8F=BE=E5=9C=A8=E3=81=AETcl/Tk=E3=83=90=E3=83=BC=E3=
=82=B8=E3=83=A7=E3=83=B3=E3=81=A7=E3=81=AF=E5=AE=9F=E8=A1=8C=E3=81=A7=E3=
=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82\n"
> +"Tcl/Tk=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B38.4=E3=81=AFgitk=
=E3=81=AE=E6=9C=80=E4=BD=8E=E6=9D=A1=E4=BB=B6=E3=81=A7=E3=81=99=E3=80=82=
"

Gitk =E3=81=AB=E3=81=AF=E6=9C=80=E4=BD=8E Tcl/Tk=E3=83=90=E3=83=BC=E3=82=
=B8=E3=83=A7=E3=83=B38.4=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=99=E3=
=80=82

> +#: gitk:10098
> +#, tcl-format
> +msgid "Ambiguous argument '%s': both revision and filename"
> +msgstr "=E5=A4=9A=E7=BE=A9=E5=BC=95=E6=95=B0'%s'=EF=BC=9A=E3=83=AA=E3=
=83=93=E3=82=B8=E3=83=A7=E3=83=B3=E3=81=A7=E3=82=82=E3=83=95=E3=82=A1=E3=
=82=A4=E3=83=AB=E5=90=8D=E3=81=A7=E3=82=82=E3=81=82=E3=82=8A=E3=81=BE=E3=
=81=99"

=E5=BC=95=E6=95=B0'%s'=E3=81=AF=E6=9B=96=E6=98=A7=E3=81=A7=E3=81=99:=E3=
=83=BB=E3=83=BB=E3=83=BB
