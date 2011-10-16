From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] gitweb: add extensions to highlight feature map
Date: Mon, 17 Oct 2011 00:18:07 +0100
Organization: OPDS
Message-ID: <C6FB1388B4E54701B6610875A3367BE2@PhilipOakley>
References: <201110161859.49817.lenaic@lhuard.fr.eu.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?iso-8859-1?Q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr.eu.org>
X-From: git-owner@vger.kernel.org Mon Oct 17 01:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFZwd-0003LU-1c
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 01:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab1JPXQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 19:16:17 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:20587 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752363Ab1JPXQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 19:16:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ag8BADxlm05cHKAK/2dsb2JhbABCikKOf48ggQYPAQGBWAEEAQEEAQgBASgBBREFCAEBIQsCAwUCAQMUAQELJRQBBBgCBgcXBggLCAIBAgMBDASHVggCBrQrgyuDfGEEh1Kdfw
X-IronPort-AV: E=Sophos;i="4.69,355,1315177200"; 
   d="scan'208";a="363342151"
Received: from host-92-28-160-10.as13285.net (HELO PhilipOakley) ([92.28.160.10])
  by out1.ip03ir2.opaltelecom.net with SMTP; 17 Oct 2011 00:16:15 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183743>

=46rom: "L=E9na=EFc Huard" <lenaic@lhuard.fr.eu.org>
Sent: Sunday, October 16, 2011 5:59 PM
> added: hpp, m

'm' files can be matlab files, and matlab can benefit from git's branch=
=20
model. Matlab expectes filenames to be identical to function names(!), =
so=20
branching function variants makes for easier development. Without git y=
ou=20
can't easily refactor.
Philip

>
> Signed-off-by: L=E9na=EFc Huard <lenaic@lhuard.fr.eu.org>
> ---
> gitweb/gitweb.perl |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 85d64b2..75e4854 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -262,11 +262,12 @@ our %highlight_ext =3D (
>        # alternate extensions, see /etc/highlight/filetypes.conf
>        'h' =3D> 'c',
>        map { $_ =3D> 'sh'  } qw(bash zsh ksh),
> -       map { $_ =3D> 'cpp' } qw(cxx c++ cc),
> +       map { $_ =3D> 'cpp' } qw(cxx c++ cc hpp),
>        map { $_ =3D> 'php' } qw(php3 php4 php5 phps),
>        map { $_ =3D> 'pl'  } qw(perl pm), # perhaps also 'cgi'
>        map { $_ =3D> 'make'} qw(mak mk),
>        map { $_ =3D> 'xml' } qw(xhtml html htm),
> +       'm' =3D> 'objc',
> );
>
> # You define site-wide feature defaults here; override them with
> --=20
> 1.7.7
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.1831 / Virus Database: 2090/4554 - Release Date: 10/1=
5/11
>=20
