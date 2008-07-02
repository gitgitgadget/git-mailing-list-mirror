From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/rfc] gitweb: open files (e.g. indextext.html) in utf8 mode
Date: Wed, 02 Jul 2008 06:37:38 -0700 (PDT)
Message-ID: <m3prpwflus.fsf@localhost.localdomain>
References: <20080702121317.10819.qmail@bca5b84cb0e0a0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?b?UmVjYWkgT2t0YcWf?= <roktas@debian.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2Xh-0001cm-EI
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYGBNhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 09:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbYGBNhn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:37:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20062 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbYGBNhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2008 09:37:42 -0400
Received: by ug-out-1314.google.com with SMTP id h2so538763ugf.16
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=H7dQJkTZdSE/cLfMJCeqNfqR9KQg7ee7Nbfc6uV8po4=;
        b=FLOZyMTyZcFhz75tz8PEBn9jdPjjMH3yynL2A9lP4EhG3MgOZ5Ek+hf80uWCl028TB
         W3lgG1mktwVkseypRijrGkePiYo6jGDG2D61gwGtWE2RoHKLtLNVKZ7Dqt00s/C+V6k0
         XLCyJ0Ub1ODX3/td9n9gqo+1JBzLNsHMv3D54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=fmI+BeZu0naU1ndUHu4/XCgrOk1nVa8aH6ZdINzRJhP4hhoZy04j2kZ9AV9UhlOJhk
         KutxGcpfmbP+iMyzLoQ85awm+3/pc0oqme33iwdJQ/pDHjsd+k6a5WdA/fQC9EBRO+gE
         gOY81Lw7xrq2ormxEpVmf/9O25OTRQxWOcClQ=
Received: by 10.210.25.19 with SMTP id 19mr6584633eby.141.1215005860291;
        Wed, 02 Jul 2008 06:37:40 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.250.156])
        by mx.google.com with ESMTPS id c25sm10330777ika.11.2008.07.02.06.37.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 06:37:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m62DbYcw018199;
	Wed, 2 Jul 2008 15:37:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m62DbWBT018195;
	Wed, 2 Jul 2008 15:37:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080702121317.10819.qmail@bca5b84cb0e0a0.315fe32.mid.smarden.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87135>

Gerrit Pape <pape@smarden.org> writes:

> From: =3D?utf-8?q?Recai=3D20Okta=3DC5=3D9F?=3D <roktas@debian.org>

You don't need to use quoted-printable in 'From:' header embedded in
the mail body.  It should probably read

  From: "Recai Okta=C5=9F" <roktas@debian.org>
=20
(provided that you can use utf-8 in email).

> gitweb used to use utf8 only in stdout.  As a result, included files
> like indextext.html appeared garbled if they contain utf8 characters.
> Now utf8 is also used when reading files.

It would better read as:

  Gitweb used to use utf8 mode only on STDOUT (actually ":utf8" output
  layer), relying on using to_utf8(...)  to convert input data from uft=
8
  to Perl internal form.  As a result, included files such as $home_tex=
t
  (indextext.html in default build configuration), or repository's
  README.html appeared garbled if they did contain UTF-8 characters.

  Now uft8 mode is used for all open invovations, also when reading fil=
es.

> The patch was submitted through
>  http://bugs.debian.org/487465
>=20

Probably should have here

  Reported-by: Recai Okta=C5=9F <roktas@debian.org>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 90cd99b..96cb4e0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -16,7 +16,7 @@ use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> -binmode STDOUT, ':utf8';
> +use open qw(:std :utf8);
> =20
>  BEGIN {
>  	CGI->compile() if $ENV{'MOD_PERL'};

It would be wonderfull if such simple solution worked.  We would be
then able to remove to_utf8() subroutine and do not worry that we
forgot to convert some string to Perl internal encoding, which could
result to curring wide (non US-ASCII) UTF-8 character to be cut in
half.  (On the other hand we wouldn't have $fallback_encoding).

Unfortunately there are two problem (or rather a problem and a half)
with this approach.


=46irst is that with this patch gitweb doesn't pass gitweb test
t/t9500-gitweb-standalone-no-errors.sh (this is with perl v5.8.6)

*   ok 63: encode(commit): utf8
*   ok 64: encode(commit): iso-8859-1
*   ok 65: encode(log): utf-8 and iso-8859-1
[...]
* FAIL 71: URL: no project URLs, no base URL
        gitweb_run "p=3D.git;a=3Dsummary"
[Wed Jul  2 13:10:15 2008] gitweb.perl: utf8 "\xC4" does not map to Uni=
code \
at /path/to/git/t/trash directory/../../gitweb/gitweb.perl line 2298, \
<$fd> line 1.
[Wed Jul  2 13:10:15 2008] gitweb.perl: Malformed UTF-8 character \
(unexpected end of string) at [...]/gitweb/gitweb.perl line 2303, \
<$fd> line 1.

which is

	open my $fd, '-|', git_cmd(), 'for-each-ref',
		($limit ? '--count=3D'.($limit+1) : ()), '--sort=3D-committerdate',
		'--format=3D%(objectname) %(refname) %(subject)%00%(committer)',
		'refs/heads'
		or return;
2298:	while (my $line =3D <$fd>) {
		my %ref_item;

		chomp $line;
		my ($refinfo, $committerinfo) =3D split(/\0/, $line);
2303:		my ($hash, $name, $title) =3D split(' ', $refinfo, 3);


Second, what is minimal Perl version and Perl configuration (installed
modules) that support "use open qw(:std :utf8);"?  We do have some
minimal requirements for gitweb, and it would be nice if we didn't add
to them.  But we already require PerlIO, so it probably doesn't matter.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
