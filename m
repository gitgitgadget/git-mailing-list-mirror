From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: The "Owner" column can be hidden
Date: Wed, 31 Mar 2010 03:28:24 -0700 (PDT)
Message-ID: <m3eij0iy5m.fsf@localhost.localdomain>
References: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Jan_St=EApie=F1?= <jstepien@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 12:28:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwvA2-0002um-JK
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 12:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001Ab0CaK23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 06:28:29 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:50404 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563Ab0CaK22 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 06:28:28 -0400
Received: by bwz1 with SMTP id 1so5071966bwz.21
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 03:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=D+bN3PpCp/24qBMwLa1mlShmFeqagniw8RnC1PEQRjk=;
        b=BcNLTTduCNs2/bKMuy+fovIrDJ9XLoj24FID+46eo01HA2QE55MuZ9VaR0uCVkTi4/
         308nvIj0trxgNahfayHJBdrmEhMG7RqMZ336/G/fkBGqYgbaYanK37cUJ9wsGNu/ePuX
         FY6rOY3N7J1YcBIYVn8HXdOXWD/OvoTL6XhfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=KrrMHahtBkrPlkDqYLDgZhy1T3B5TdttS/x0OqxZRezMrQxqGNjwFYOITuSk6WKTav
         j/pCny3vZmDR7daV1tUI55NtIh52hYjN51PMmJSMbXdlAYrC0qDQx1MUDasX5mW2MyAu
         KivwM/OqD2pvWFZDiTWoiOa8TT83BBCLNRfVs=
Received: by 10.204.4.135 with SMTP id 7mr6004825bkr.99.1270031306433;
        Wed, 31 Mar 2010 03:28:26 -0700 (PDT)
Received: from localhost.localdomain (abuz2.neoplus.adsl.tpnet.pl [83.8.197.2])
        by mx.google.com with ESMTPS id 15sm3533019bwz.0.2010.03.31.03.28.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 03:28:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2VARoVr030739;
	Wed, 31 Mar 2010 12:28:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2VARYjh030734;
	Wed, 31 Mar 2010 12:27:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143658>

Jan St=EApie=F1  <jstepien@users.sourceforge.net> writes:

> This commit adds $show_owner_column configuration variable which allo=
ws
> to hide the project list "Owner" column if desired.
>

This commit message is a bit lacking, in that it does not describe
*why* one would want to hide "Owner" column in projects list page.
It is not described either why "Owner" column is unique among all
other columns, in that it is the only column that can be hidden.

Besides for completeness you might want to hide "Owner" row in project
summary page.
=20
> Signed-off-by: Jan St=EApie=F1 <jstepien@users.sourceforge.net>
> ---
>  gitweb/gitweb.perl |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

While "Gitweb config file variables" section in gitweb/README does not
need to include _all_ gitweb configuration variables, you should thing
about it whether to include description of '$show_owner_column' (or
just '$show_owner') in gitweb/README, and whether to include note
about this variable in "Projects list file format" in this file.

>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a2d2283..95f7f06 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -160,6 +160,9 @@ our @diff_opts =3D ('-M'); # taken from git_commi=
t
>  # the gitweb domain.
>  our $prevent_xss =3D 0;
> =20
> +# presense of the projects list "Owner" column

I'd rather have here

+# If false, hide "Owner" column on projects list page, and "Owner" row
+# in the project summary page.

> +our $show_owner_column =3D 1;

Perhaps it should be '$show_owner', or '$hide_owner'.

BTW. if it would hide owner everywhere, you might want to skip
generating / reading projects owners.

> +
>  # information about snapshot formats that gitweb is capable of servi=
ng
>  our %known_snapshot_formats =3D (
>  	# name =3D> {
> @@ -4430,7 +4433,7 @@ sub git_project_list_body {
>  		}
>  		print_sort_th('project', $order, 'Project');
>  		print_sort_th('descr', $order, 'Description');
> -		print_sort_th('owner', $order, 'Owner');
> +		print_sort_th('owner', $order, 'Owner') if $show_owner_column;
>  		print_sort_th('age', $order, 'Last Change');
>  		print "<th></th>\n" . # for links
>  		      "</tr>\n";
> @@ -4469,8 +4472,8 @@ sub git_project_list_body {
>  		                        -class =3D> "list"}, esc_html($pr->{'path'=
})) . "</td>\n" .
>  		      "<td>" . $cgi->a({-href =3D> href(project=3D>$pr->{'path'}, =
action=3D>"summary"),
>  		                        -class =3D> "list", -title =3D> $pr->{'des=
cr_long'}},
> -		                        esc_html($pr->{'descr'})) . "</td>\n" .
> -		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i><=
/td>\n";
> +		                        esc_html($pr->{'descr'})) . "</td>\n";
> +		print "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) .  "</i>=
</td>\n" if $show_owner_column;
>  		print "<td class=3D\"". age_class($pr->{'age'}) . "\">" .
>  		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No com=
mits") . "</td>\n" .
>  		      "<td class=3D\"link\">" .
> --=20
> 1.7.0.3
>=20

--=20
Jakub Narebski
Poland
ShadeHawk on #git
