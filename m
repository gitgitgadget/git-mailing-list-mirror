From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 10:19:36 -0700
Message-ID: <CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Schneider <thosch97@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0aE-0003AA-MT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbbCTRTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2015 13:19:38 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35995 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbCTRTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 13:19:37 -0400
Received: by iedm5 with SMTP id m5so33816688ied.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fjsWBzS2d8kE9ishG9OsbE8Un8NAUcbSwUleS5Aq+Tc=;
        b=VN8uy7IM1ZZ5WvwijDdDeZPe/nbUlC2oPULYv86ifYmsXim2EHnez3u9+YBIeze+/n
         i7Kz5XfapIfT+9Vn4hH8rZZwsZKjoGPr09yzvP8cLV867cBUNMU5c+BW62VdV9R9g1RE
         8KRH3Zw2TRWEnH3UQZPhpADQm24JC+JuAF9va9UCntVklkE3n5+xMzqpQIDIKPREMRMV
         dju4iXDjNJ2qO64+GDRDpej0G5YB+B8fdXFhojnLLuIpOVvEyAmmZLMMR0PQuYOcC3qu
         urMMQhxTH8Y8/yTUcCIEbQIrm9NCAvYJofsC5ECpuWp+VAfoidf8Hrt7xLJXS0uiUuEh
         XPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fjsWBzS2d8kE9ishG9OsbE8Un8NAUcbSwUleS5Aq+Tc=;
        b=Y8WOc8KnTIGmJKl/9QlB58cRgNK7uXu6O/8NAo9eNH1fmB6U5Xq03z95nCiwUcObXC
         YoDpNGy0qSIAGS1Wm5GIDc0kY7DZG2vEkML1V5sf1vfuOLPaG9SZs4a2dVvjTaNm9jWf
         H1xHwe6I+V2spZG6WQOSLI0hdzAOlf3FLZDDWoPQ4kAt2d2STYXhk3PXycOgh92heZdF
         6tcOMikbLveqUCV/LIFLtKLhkQgs5UqFO9zHvI5bCbEozBTcH6WYeqV6Xpfl2cZB/tme
         2+sqoSUFcPKFx3nNZagxBoCkgZ1YhF2SYc5vHcUgjwlC6OoW3iGl6j3dRTiyg9rkpScx
         Dsig==
X-Gm-Message-State: ALoCoQnzyiVNyjWIRYGLkfRbJXIbtfE0PSZGbxu7t8Qyd+dbgjCKunvii7TMlYShKPtVVnYI7Zxm
X-Received: by 10.42.92.16 with SMTP id r16mr5542272icm.95.1426871976532; Fri,
 20 Mar 2015 10:19:36 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 20 Mar 2015 10:19:36 -0700 (PDT)
In-Reply-To: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265912>

On Fri, Mar 20, 2015 at 4:23 AM, Thomas Schneider <thosch97@gmail.com> =
wrote:
> Signed-off-by: Thomas Schneider <thosch97@gmail.com>
> ---
> dblatex does print some warnings, but they seem to be irrelevant.
> Besides, first patch I submit to git or even to any project using a
> mailing list =E2=80=A6 let=E2=80=99s hope I did everything right :)

Welcome to the git community!

The patch itself applies cleanly and the generated pdfs look
really great, though how would I read man pages in pdf
format? I tried searching the web and all I can find is how
to convert the a man page to pdf. So is there a conveniant
way to tell `man` to prefer opening pdfs when available?

>
>  Documentation/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3e39e28..158cbd9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -38,6 +38,7 @@ MAN7_TXT +=3D gitworkflows.txt
>  MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
>  MAN_XML =3D $(patsubst %.txt,%.xml,$(MAN_TXT))
>  MAN_HTML =3D $(patsubst %.txt,%.html,$(MAN_TXT))
> +MAN_PDF =3D $(patsubst %.txt,%.pdf,$(MAN_TXT))
>
>  OBSOLETE_HTML +=3D everyday.html
>  OBSOLETE_HTML +=3D git-remote-helpers.html
> @@ -223,7 +224,7 @@ man7: $(DOC_MAN7)
>
>  info: git.info gitman.info
>
> -pdf: user-manual.pdf
> +pdf: user-manual.pdf $(MAN_PDF)
>
>  install: install-man
>
> @@ -248,6 +249,7 @@ install-info: info
>  install-pdf: pdf
>         $(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
>         $(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
> +       $(INSTALL) -m 644 $(MAN_PDF) $(DESTDIR)$(pdfdir)
>
>  install-html: html
>         '$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
> @@ -328,6 +330,11 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
>         $(QUIET_XMLTO)$(RM) $@ && \
>         $(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>
> +%.pdf: %.xml
> +       $(QUIET_DBLATEX)$(RM) $@+ $@ && \
> +       $(DBLATEX) -o $@+ -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex=
=2Exsl -s $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
> +       mv $@+ $@
> +
>  %.xml : %.txt asciidoc.conf
>         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>         $(TXT_TO_XML) -d manpage -o $@+ $< && \
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
