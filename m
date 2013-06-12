From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 29/31] git-remote-mediawiki: Add a .perlcriticrc file
Date: Tue, 11 Jun 2013 22:02:59 -0400
Message-ID: <CAPig+cR+E7QN7H5hCLR-62soBpt7R2eqS05CyNbNUC09g1V9FQ@mail.gmail.com>
References: <1370989102-24942-1-git-send-email-celestin.matte@ensimag.fr>
	<1370989102-24942-30-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 04:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmaP0-0005Ws-GE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 04:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab3FLCDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 22:03:04 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:44008 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab3FLCDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 22:03:03 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so7492844lab.14
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wtc8JLLvb//1y+7dGZhvCtUEZj+rU0ywpN1HVOIVjA4=;
        b=Z/POsxPlH5g8fsCPCWHeJRNj7Re2e5vvjM/8qyjhFRN5+cDSOWlLzNFKM/mDY+4ReE
         NG85Ad6MdvnVhyTQV/QaIB5QQRjpWbMKvVug91Y/UbYwWPVLww5Rxi45DInm7dDfbaWq
         1x8GZ1sC4TvSYv+3kX6H4cMqqFQrVjCRHQA2bJLc0uHyxEM/9T0HHX3OBhs6Ye83mYUo
         M1TIKlT+vU2XmxVDwEcimrg+XpWfrmISy7xVnCYANCL/KbKSeR1msPWavRgi8DB3VnWD
         by+g/0AsLuuGCfmyFHZ2h0mvsDEuBeJ1AgwCc07nR8zMdmO2uJwGGbbaJDGDpREgrwyw
         FrdQ==
X-Received: by 10.112.205.69 with SMTP id le5mr9999180lbc.3.1371002579630;
 Tue, 11 Jun 2013 19:02:59 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Tue, 11 Jun 2013 19:02:59 -0700 (PDT)
In-Reply-To: <1370989102-24942-30-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: EoGbwPUi0xKB_y3nHBCc5jLlHEc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227586>

On Tue, Jun 11, 2013 at 6:18 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Such a file allows to configure perlcritic.
> Here, it is used to prevent to remove many unwanted rules and configu=
re one to

s/to prevent//

> remove unwanted warnings.
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/.perlcriticrc |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 contrib/mw-to-git/.perlcriticrc
>
> diff --git a/contrib/mw-to-git/.perlcriticrc b/contrib/mw-to-git/.per=
lcriticrc
> new file mode 100644
> index 0000000..a1f8451
> --- /dev/null
> +++ b/contrib/mw-to-git/.perlcriticrc
> @@ -0,0 +1,28 @@
> +# These 3 rules demand to add the s, m and x flag to *every* regexp.=
 This is
> +# overkill and would be harmful for readability.
> +[-RegularExpressions::RequireExtendedFormatting]
> +[-RegularExpressions::RequireDotMatchAnything]
> +[-RegularExpressions::RequireLineBoundaryMatching]
> +
> +# This rules says that builtin functions should not be called with p=
arenthesis

s/rules/rule/
s/parenthesis/parentheses/

> +# e.g.: (taken from CPAN's documentation)
> +# open($handle, '>', $filename); #not ok
> +# open $handle, '>', $filename;  #ok
> +# Applying such a rule would mean modifying a huge number of lines f=
or a
> +# question of style.
> +[-CodeLayout::ProhibitParensWithBuiltins]
> +
> +# This rule states that each system call should have its return valu=
e checked
> +# The problem is that it includes the print call. Checking every pri=
nt call's
> +# return value would be harmful to the code readabilty.
> +# This configuration keeps all default function but print.
> +[InputOutput::RequireCheckedSyscalls]
> +functions =3D open say close
> +
> +# This rules demands to add a dependancy for the Readonly module. Th=
is is not
> +# wished.
> +[-ValuesAndExpressions::ProhibitConstantPragma]
> +
> +# This rule is not really useful (rather a question of style) and pr=
oduces many
> +# warnings among the code.
> +[-ValuesAndExpressions::ProhibitNoisyQuotes]
> --
