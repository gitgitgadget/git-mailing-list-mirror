From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Tue, 3 Aug 2010 23:50:38 +0200
Message-ID: <201008032350.40117.jnareb@gmail.com>
References: <20100801195138.GA1980@pengutronix.de> <m3lj8qozan.fsf@localhost.localdomain> <20100803210730.GA1254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de,
	Stephen Boyd <bebarino@gmail.com>
To: "Uwe =?utf-8?q?Kleine-K=C3=B6nig?=" <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Aug 03 23:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgPNU-00035j-6E
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 23:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab0HCVuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 17:50:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39588 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab0HCVuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 17:50:21 -0400
Received: by bwz1 with SMTP id 1so2123916bwz.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pFZHQY9/phSF01ijEnLL8WgvwMBURNstIDiOKyqUyXk=;
        b=JYuukvy7lwtRUB0wMk4haHYKdicxnafI/ojh2H57MopaG0o0O9pF1JTBZ6QGcCPH39
         TKRk6oE7rJa66hswTdZY17MHEFVG46LIp+6rNW6MMbovKOuRO3wwfOnexyJsZevBV5/3
         THQxYRK23PDgnn1IRIv9K/BuP6DZcSNLm3Udw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YayLaCAA8KuqkCbjq6S065CWd2oPAb4XDFPSrzF3BcZStrMLcfpShKwSy9IWbroE7x
         SujissF1dlQgvoS09fvZBcVLbmSo1hM+D09uQA5AKXJe0SYvfnO507wGr8m40SF6aDkG
         uP+p4my+jRDlaNsx3pJIR3ly9GyVhdHXkHPaQ=
Received: by 10.204.175.9 with SMTP id v9mr5718031bkz.13.1280872219681;
        Tue, 03 Aug 2010 14:50:19 -0700 (PDT)
Received: from [192.168.1.13] (abwi87.neoplus.adsl.tpnet.pl [83.8.232.87])
        by mx.google.com with ESMTPS id o20sm5366841bkw.15.2010.08.03.14.50.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 14:50:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100803210730.GA1254@pengutronix.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152543>

On Tue, Aug 03, 2010, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Aug 01, 2010 at 01:26:16PM -0700, Jakub Narebski wrote:
> > Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:
> >=20
> > > Hello,
> > >=20
> > > gitweb (at least) doesn't quote author names enough.
> > >=20
> > > Firefox barfs for me at looking at
> > >=20
> > > 	http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3D=
v2.6.16.10
> > >=20
> > > with an error:
> > >=20
> > > 	XML Parsing Error: not well-formed Location:
> > > http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3D=
v2.6.16.10
> > > Line Number 112, Column 81:
> > > <td class=3D"author"><a title=3D"Search for commits authored by Y=
OSHIFUJI Hideaki / ?$B5HF#1QL@?(B" class=3D"list" href=3D"/?p=3Dukl/lin=
ux-2.6.git;a=3Dsearch;h=3Dv2.6.16.10;s=3DYOSHIFUJI+Hideaki+/+%1B%24B5HF=
%231QL@%1B(B;st=3Dauthor"><span title=3D"YOSHIFUJI Hideaki / ?$B5HF#1QL=
@?(B">YOSHIFUJI Hideaki...  </span></a></td><td><a class=3D"list subjec=
t" title=3D"[PATCH] IPV6: XFRM: Fix decoding session with preceding ext=
ension header(s)." href=3D"/?p=3Dukl/linux-2.6.git;a=3Dcommit;h=3Dfa39d=
f2ff7f6102f1f37d3cf1f68243534d56253">[PATCH] IPV6: XFRM: Fix decoding s=
ession with preceding... </a></td>
> > > -----------------------------------------------------------------=
---------------^
> > >=20
> > > This is with git 1.7.1 and Iceweasel (aka. Firefox) 3.5.10.
> > >=20
> > > Making
> > >=20
> > > 	title=3D>"Search for commits $performed by $author"
> > >=20
> > > in line 1694 of Debian's /usr/lib/cgi-bin/gitweb.cgi from the git=
 1.7.1
> > > package read
> > >=20
> > > 	title=3D>esc_html("Search for commits $performed by $author")
> > >=20
> > > this problem goes away.  (Still my browser barfs when clicking at=
 the name.)
> > >=20
> > > I'm not sure if this is the right way to fix this and I'm too tir=
ed now
> > > to do a complete patch, so I let this for someone else.
> >=20
> > Actually gitweb leaves quoting of tag attributes to CGI module:
> >=20
> >   return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash=
,
> >                                 searchtext=3D>$author, searchtype=3D=
>$searchtype),
> >                   -class =3D> "list",
> >                   -title =3D> "Search for commits $performed by $au=
thor"},
> >                  $displaytext);
> >=20
> > I am worrying (perhaps unnecessary) that using esc_html would resul=
t
> > in double escaping.  But it looks like the problem is with Unicode,
> > so perhaps using
> >=20
> >   	title =3D> to_utf8("Search for commits $performed by $author")
> >=20
> > in place of
> >=20
> >   	title=3D>esc_html("Search for commits $performed by $author")
> >=20
> > would be a better fix?  Does this fix work for you?
>
> No, this doesn't help.  Firefox still barfs with to_utf8.
>=20
> With esc_html the code generated is:
>=20
> <a title=3D"Search for commits authored by YOSHIFUJI Hideaki / <span =
class=3D"cntrl">\e</span>$B5HF#1QL@<span class=3D"cntrl">\e</span>(B" c=
lass=3D"list" href=3D"/?p=3D.git;a=3Dsearch;h=3Df66ab685594d49e570b2176=
cfa20b03360e9a6e9;s=3DYOSHIFUJI+Hideaki+/+%1B%24B5HF%231QL@%1B(B;st=3Da=
uthor"><span title=3D"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B">YOSHIFUJI Hid=
eaki...  </span></a>

As you can see the HTML code generated with esc_html solution is way wr=
ong
because of embedded '<span class=3D"cntrl">\e</span>' as you see _witho=
ut_
'"' being escaped, so HTML is wrong.

Nevertheless it shows what's the problem.  Somehow (perhaps wrong
encoding, perhaps screw up with quoted-printable and git-am, perhaps
copy'n' paste included ANSII color codes from terminal, perhaps somethi=
ng
different altogether) you got control characters (\e =3D ESC) in $autho=
r.
In strict XHTML mode (with 'application/xml

Please try the following patch

-- >8 --
=46rom: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Harden format_search_author()

Protect format_search_author against control characters in $author.
While at it simplify it a bit, and use spaces for align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8b02767..ea9c09c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1856,23 +1856,22 @@ sub format_search_author {
 	my ($author, $searchtype, $displaytext) =3D @_;
 	my $have_search =3D gitweb_check_feature('search');
=20
-	if ($have_search) {
-		my $performed =3D "";
-		if ($searchtype eq 'author') {
-			$performed =3D "authored";
-		} elsif ($searchtype eq 'committer') {
-			$performed =3D "committed";
-		}
-
-		return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
-				searchtext=3D>$author,
-				searchtype=3D>$searchtype), class=3D>"list",
-				title=3D>"Search for commits $performed by $author"},
-				$displaytext);
+	return $displaytext unless ($have_search);
=20
-	} else {
-		return $displaytext;
+	my $performed =3D "";
+	if ($searchtype eq 'author') {
+		$performed =3D "authored";
+	} elsif ($searchtype eq 'committer') {
+		$performed =3D "committed";
 	}
+
+	my $title =3D to_utf8("Search for commits $performed by $author");
+	$title =3D~ s/[[:cntrl:]]/?/g;
+
+	return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
+	                              searchtext=3D>$author, searchtype=3D>$s=
earchtype),
+	                -class=3D>"list", -title=3D>$title},
+	               $displaytext);
 }
=20
 # format the author name of the given commit with the given tag
--=20
1.7.2.1
