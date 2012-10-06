From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] gitignore.txt: suggestions how to get literal # or ! at the beginning
Date: Sat, 6 Oct 2012 12:33:14 +0100
Organization: OPDS
Message-ID: <01ADED0717024E6F93B7FBADB1AEAE6B@PhilipOakley>
References: <1349512701-29729-1-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 13:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKSdK-00069X-Ez
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 13:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2JFLdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 07:33:11 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:47915 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765Ab2JFLdI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 07:33:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAGEWcFBcGnKf/2dsb2JhbABFhhGFP7NQgQmCGwUBAQQBCAEBGQ8BBR4BASELAgMFAgEDFQUCBSECAhQBBAgSBgcXBgESCAIBAgMBh2IDCQqmfIhoDYlUgSGJNoVkMmADjWmGLYx4hQuCbg
X-IronPort-AV: E=Sophos;i="4.80,543,1344207600"; 
   d="scan'208";a="405441260"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip02ir2.opaltelecom.net with SMTP; 06 Oct 2012 12:33:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207141>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> We support backslash escape, but we hide the details behind the phras=
e
> "a shell glob suitable for consumption by fnmatch(3)". So it may not
> be obvious how one can get literal # or ! at the beginning of a=20
> pattern.
> Add a few lines on how to work around the magic characters.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> Asciidoc 8.2.6 does not like me writing
> "Put \# if you need a literal #.." so I go with "backslash" and
> "hash" instead. `\!` displays fine both in man page and html format.
> '!' changed to `!` because it looks clearer in monospace.

Why not put the backslash-hash in back quotes as well to give the same=20
look/feel consistency?

>
> Documentation/gitignore.txt | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.tx=
t
> index 96639e0..8c03ed4 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -74,11 +74,14 @@ PATTERN FORMAT
>    for readability.
>
>  - A line starting with # serves as a comment.

+  A line starting with `#` serves as a comment.

> +   Put a backslash in front of the first hash for the patterns
> +   that start with a hash.
>
+   Use `\#` if you need a literal `#` at the beginning of the pattern.

> - - An optional prefix '!' which negates the pattern; any
> + - An optional prefix `!` which negates the pattern; any
>    matching file excluded by a previous pattern will become
>    included again.  If a negated pattern matches, this will
> -   override lower precedence patterns sources.
> +   override lower precedence patterns sources. Use `\!` if
> +   you need a literal `!` at the beginning of the pattern.
>
>  - If the pattern ends with a slash, it is removed for the
>    purpose of the following description, but it would only find
> --=20
> 1.7.12.1.406.g6ab07c4
