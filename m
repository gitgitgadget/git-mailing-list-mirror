From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] config.txt: stick to CamelCase naming convention
Date: Tue, 10 Mar 2015 16:34:35 -0400
Message-ID: <CAPig+cRkV++D9-yYWOv3FmBtTuWz1_Et23Xk=8cg8=7_E1PZug@mail.gmail.com>
References: <1425983981-634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 21:34:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVQrR-00019j-Dr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 21:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbbCJUeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 16:34:37 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35966 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbCJUeg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 16:34:36 -0400
Received: by ykp9 with SMTP id 9so1942732ykp.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=UGEZmROUxHBzFWzLCfkgxtSj1PldZrcK/lkjSe7R98E=;
        b=fe4B5/drgy5IVdjNV1AD3TJbFvQcBWn8Xw1q+CFSiSq0X/vIbEp/jccxhbfVsMln6e
         NLbaOdBYEyFFoLVJKO1Bqi9KZyyzr3qSpepIp+EWZcTUigokh8YbsCwAuoz+//lroxWw
         utOqpQJmwqOfMM+F1nq68+wNf4T8npZwry3ycZ4tVM1ShNkGKvtDRg9+E7Syz7O5FmZA
         re0rz8H04bkm6G9DivGPJY4MTb+YznTqseezjKlm3i+erkdxZi5Gh49cccLC4uFAPyw/
         GGzMag83ar4J56Y7rGl7QPcGjT9Cv+cPNRCi3S6YXPq2iylAvYrPT5zq5IEBnwnEX0y6
         h9JQ==
X-Received: by 10.236.45.106 with SMTP id o70mr34305894yhb.180.1426019675701;
 Tue, 10 Mar 2015 13:34:35 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 13:34:35 -0700 (PDT)
In-Reply-To: <1425983981-634-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: aL0cdeLjX8op9T8WWR0PfWExVB0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265262>

On Tue, Mar 10, 2015 at 6:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1530255..b4cc577 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -257,20 +257,20 @@ core.protectNTFS::
>         8.3 "short" names.
>         Defaults to `true` on Windows, and `false` elsewhere.
>
> -core.trustctime::
> +core.trustCTime::

I personally find this a bit odd. 'ctime' is always typed exactly like
that; never 'cTime' or 'Ctime' or 'CTime'.

>         If false, the ctime differences between the index and the
>         working tree are ignored; useful when the inode change time
>         is regularly modified by something outside Git (file system
>         crawlers and some backup systems).
>         See linkgit:git-update-index[1]. True by default.
>
> @@ -290,7 +290,7 @@ core.eol::
>         linkgit:gitattributes[5] for more information on end-of-line
>         conversion.
>
> -core.safecrlf::
> +core.safeCRLF::

Here, you uppercase the entire acronym, "CRLF"...

>         If true, makes Git check if converting `CRLF` is reversible w=
hen
>         end-of-line conversion is active.  Git will verify if a comma=
nd
>         modifies a file in the work tree either directly or indirectl=
y.
> @@ -1281,11 +1281,11 @@ gitcvs.enabled::
>         Path to a log file where the CVS server interface well... log=
s
>         various stuff. See linkgit:git-cvsserver[1].
>
> -gitcvs.usecrlfattr::
> +gitcvs.useCrlfAttr::

But, here you only capitalized it: "Crlf".

>         If true, the server will look up the end-of-line conversion
>         attributes for files to determine the '-k' modes to use. If
>         the attributes force Git to treat a file as text,
> @@ -1403,39 +1403,39 @@ gui.encoding::
>         "true" if linkgit:git-gui[1] should prune remote-tracking bra=
nches when
>         performing a fetch. The default value is "false".
>
> -gui.trustmtime::
> +gui.trustMTime::

Ditto comment regarding strangeness of seeing 'mtime' typed any way
other than 'mtime'.

>         Determines if linkgit:git-gui[1] should trust the file modifi=
cation
>         timestamp or not. By default the timestamps are not trusted.
>
>         Specifies the threshold to use in 'git gui blame' original lo=
cation
>         detection, measured in alphanumeric characters. See the
>         linkgit:git-blame[1] manual for more information on copy dete=
ction.
>
> -gui.blamehistoryctx::
> +gui.blameHistoryCTX::

You've uppercased acronyms (such as CRLF, URL, SSL), however, "ctx" is
merely an abbreviation of "context", not an acronym. As such, "Ctx"
seems more correct.

>         Specifies the radius of history context in days to show in
>         linkgit:gitk[1] for the selected commit, when the `Show Histo=
ry
>         Context` menu item is invoked from 'git gui blame'. If this
> @@ -2308,14 +2308,14 @@ sendemail.identity::
>         See linkgit:git-send-email[1] for description.  Note that thi=
s
>         setting is not subject to the 'identity' mechanism.
>
> -sendemail.smtpssl (deprecated)::
> +sendemail.smtpSSL (deprecated)::

Here, "SSL"...

>         Deprecated alias for 'sendemail.smtpencryption =3D ssl'.
>
> -sendemail.smtpsslcertpath::
> +sendemail.smtpSslCertPath::

But here, inconsistently, "Ssl".

>         Path to ca-certificates (either a directory or a single file)=
=2E
>         Set it to an empty string to disable certificate verification=
=2E
>
