From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/8] gitweb: Use different colors to present marked changes
Date: Sat, 11 Feb 2012 16:11:11 -0800 (PST)
Message-ID: <m3pqdksyg1.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-8-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 01:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwN2D-0000WP-WB
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab2BLALO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:11:14 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60496 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab2BLALN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 19:11:13 -0500
Received: by eekc14 with SMTP id c14so1404666eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=5IglfJ/vjBI21CahiSyOZy8LiAYMyu70kkW7R3gT7/I=;
        b=v7pRy4h15JQXx3cqcl9jRMqcIeNzEMa9yHAFLPX/mrqb5UP1KOznWj7rxgl9t6lEkQ
         Ua7m2Kq62tVyeGXEHGLpeKik5vC+Yp8LYhzXC8nOzA8S6dOgKtz9PUUqSDKdwjwALbCU
         qr73+ER/xZzszLVey18TRTxtNZ3AgXWVMiAqA=
Received: by 10.213.9.205 with SMTP id m13mr1160860ebm.66.1329005472081;
        Sat, 11 Feb 2012 16:11:12 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id z47sm41617745eeh.9.2012.02.11.16.11.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 16:11:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1C0BB4s022176;
	Sun, 12 Feb 2012 01:11:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1C0BAxq022170;
	Sun, 12 Feb 2012 01:11:10 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-8-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190550>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> This makes use of the highlight diff feature.
>=20
> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
> I decided to split mechanism (generate HTML page with <span> elements=
 that
> mark interesting fragments of diff output) from politics (use these
> particular colors for this <span> elements), but otherwise this commi=
t
> may be squashed with the previous one. These colors work for me but i=
f
> someone comes out with better ones, I'd be happy.

I think it would be better squashed with previous patch, otherwise it
is a bit not visible change...
=20
>  gitweb/static/gitweb.css |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>=20
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index c7827e8..4f87d16 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -438,6 +438,10 @@ div.diff.add {
>  	color: #008800;
>  }
> =20
> +div.diff.add span.marked {
> +	background-color: #77ff77;
> +}
> +
>  div.diff.from_file a.path,
>  div.diff.from_file {
>  	color: #aa0000;
> @@ -447,6 +451,10 @@ div.diff.rem {
>  	color: #cc0000;
>  }
> =20
> +div.diff.rem span.marked {
> +	background-color: #ff7777;
> +}
> +
>  div.diff.chunk_header a,
>  div.diff.chunk_header {
>  	color: #990099;
> --=20

I'd have to see those colors in use.  BTW what colors other
highlighting diff GUIs use?

--=20
Jakub Nar=EAbski
