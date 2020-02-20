Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F71C11D07
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A5A208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bYGh/i7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBTOIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:08:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:47917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBTOIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582207709;
        bh=sHHAcpcVNOB+ngGuQfhhAEmCn+r/Cpia1zx3zcRjVFk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bYGh/i7Y7HXFInpZH1/N8Y4dxM4v8fxuDIPQLOI8J1wx90CCVLb0NJLX1wXQdE7R+
         d2A9eOwMCwuQjGANT7oryX79SBRYt9ge0Aa/g71b5/El+6QMNj4eqtI9dA6sk6eIQk
         +kyJSNiDwXJnAL9c4IMVADqsQzc/SfZixPQjQrao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1iuAZo141Z-00Sv5p; Thu, 20
 Feb 2020 15:08:29 +0100
Date:   Thu, 20 Feb 2020 15:08:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 15/15] bugreport: summarize contents of alternates
 file
In-Reply-To: <20200220015858.181086-16-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002201458120.46@tvgsbejvaqbjf.bet>
References: <20200220015858.181086-1-emilyshaffer@google.com> <20200220015858.181086-16-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mGKmBQBPIFya8Pl1knIPPOIKFBGuFj05igS8p5NxR1iGkPgQo2g
 W83tUSb68CBak2GaWtIrS5DBmJCtmVFem0i7WaDdH2h6Vc+5idXvurkbFHkH4Eoe5xKHrJp
 cLvWKzyvSE8VFh3shqnRztoZgJYCS34JQ+/2GWrt9+LUEb+D2nxrp+XsKNFWqbwiHfOcca8
 kMCa5jwzgQydEemgMWbpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NjxRFGr18E=:Rtq8ZCX3m3IgfL3HATs/em
 e9A/8d1Qgu3nvKv0mAtufSnpk0pKA3l/hUo7nqyke33JOQm3tZKtNCsd3LxR1qI91A9baiNj+
 C4tOZ/mG5Glmbubz+H20f2hHRx+R0khhwyhsBmk82VoV9AZ/Zw5BqGEeIScN4gfHgPgxZRNTN
 kFHslE0RJLL5TW+IT3xWra7nOwcLdYiHvJp+z0iT5hyBBMdtiYsXYb7Phh8J93BwY+6r+ffG4
 WpMn++vlEb2zepSmIX0wLYwgGqSlZR1Rr1ufYUspUz+L8V2eVP55IccBkaEM9gbxHnBS+3+pw
 w6xWYjTtlPZzYFNnQoazku7jredkkOK5BvaaEq66pB8SCIVvB/Xn9gvp6BpxZavWnKhh6Fg9+
 ktSZXyNHzaJ6oHNW5baAwlmnKz0Kfcq/6ogRahBXC0vpQQh3taGVHnWz46g6wjZtTlgZlJQIT
 IsSyRQ7T7kYtX53pDtnCpvbIO+yxoHnRRns1m036AwJc3GABmGHRl3uXwaM0qdKRPTqXv66SA
 Jlm87w0v2auz7v1si6/xoCO0qRBYJMgmaScNus+zM5aNYZpAlBb7FkPgiv7CK7N4rDdupNPGh
 zyGa8flteGNVWycIf2lAAZNhG8veswJLGKqB56Nl48ByTDpwgr0KtOo3jIf5yAqX61azZul/H
 FqKLZpoY0KNZaMkk3vrgamtDWcm6J8YMIAiwcyHgn8feNU+eV+qzsGBOu60ogup6rYdxLnU6q
 5PW04d1Msh8p5LAMNqic1cPGY2tmDBWDECx1aEWrN9wNg1T07yJqgO+J3W6pBD1pQ+EBvjF2X
 y7yE88lF6hrXeDhf6K9ChNKOUZgMDsv0mzTbcuCQjYWp3ZZdkW/tAqyYLO1kqtVvE+5Rv3JnB
 nSbih/eKapg17PPyb1fLS0ZusOX+JR2upy3kuzh8g5EPpVL66lI0ufpueM/yCI00nfpnnnzhE
 pn7/1kau8EmJ2dyZEYP4wws4nvfKjmq6vf7TUWqfBi2iO7mRWwpBTK28xNCni2wXcm0NtuGyF
 Cx7ILtwcOw0429IVhH4qg0wNM4BRXGilaynsywSejzHSFmkWAxKdw1TWt3fHZWYz8aD7Ki22V
 7CxODD45KMPzQu5lAt70kIAVsrdEhR5bOFbdGOLekkbSIHEYdqgrxSxlQDvZq6yE0fj30XM1e
 5Mo/EvTP88LVm39ARvzNW/P6hNR6umJClPyZEZOvG5y0Jj2g2Yw0hmIHswpfwE/iwMYg0DLiD
 ICZ31DbIk0hP6uMRo
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 19 Feb 2020, Emily Shaffer wrote:

> In some cases, it could be that the user is having a problem with an
> object which isn't present in their normal object directory. We can get
> a hint that that might be the case by examining the list of alternates
> where their object may be stored instead. Since paths to alternates may
> be sensitive, we'll instead count how many alternates have been
> specified and note how many of them exist or are broken.
>
> While object-cache.h describes a function "foreach_alt_odb()", this
> function does not provide information on broken alternates, which are
> skipped over in "link_alt_odb_entry()". Since the goal is to identify
> missing alternates, we can gather the contents of
> .git/objects/info/alternates manually.

Makes sense.

> diff --git a/bugreport.c b/bugreport.c
> index 1d61e0f642..1640a71086 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -255,6 +255,48 @@ static void get_object_info_summary(struct strbuf *=
obj_info, int nongit)
>  	strbuf_release(&dirpath);
>  }
>
> +static void get_alternates_summary(struct strbuf *alternates_info, int =
nongit)
> +{
> +	struct strbuf alternates_path =3D STRBUF_INIT;
> +	struct strbuf alternate =3D STRBUF_INIT;

I am not sure that those variables and the parameter need to repeat
"alternate", I find it rather distracting. If it were me, I would rename
the parameter to `info`, the first strbuf to `path` and the second to
`line`. This function is so specific to read the alternates file that it
is quite obvious what their roles are.

> +	FILE *file;
> +	size_t exists =3D 0, broken =3D 0;
> +
> +	if (nongit) {
> +		strbuf_addstr(alternates_info,
> +			"not run from a git repository - alternates unavailable\n");
> +		return;
> +	}
> +
> +	strbuf_addstr(&alternates_path, get_object_directory());
> +	strbuf_complete(&alternates_path, '/');
> +	strbuf_addstr(&alternates_path, "info/alternates");
> +
> +	file =3D fopen(alternates_path.buf, "r");
> +	if (!file) {
> +		strbuf_addstr(alternates_info, "No alternates file found.\n");
> +		strbuf_release(&alternates_path);
> +		return;
> +	}
> +
> +	while (strbuf_getline(&alternate, file) !=3D EOF) {
> +		if (!access(alternate.buf, F_OK))

Should we make sure that the alternate is actually valid objects directory
here? Like, look whether it is a directory, not a file or a (possibly
dangling) symbolic link. This seems to be the only check
`alt_odb_usable()` performs, so that should probably be good enough here,
too.

> +			exists++;
> +		else
> +			broken++;
> +	}
> +
> +	strbuf_addf(alternates_info,
> +		    "%zd alternates found (%zd working, %zd broken)\n",

Sadly, `%zd` is not portable. Therefore, `pu` (and `es/bugreport`) do not
even _build_ on Windows. I need this to make it work:

=2D- snip --
diff --git a/bugreport.c b/bugreport.c
index 3770aa73fae..5033668e22f 100644
=2D-- a/bugreport.c
+++ b/bugreport.c
@@ -287,10 +287,11 @@ static void get_alternates_summary(struct strbuf *al=
ternates_info, int nongit)
 	}

 	strbuf_addf(alternates_info,
-		    "%zd alternates found (%zd working, %zd broken)\n",
-		    exists + broken,
-		    exists,
-		    broken);
+		    "%"PRIuMAX" alternates found "
+		    "(%"PRIuMAX" working, %"PRIuMAX" broken)\n",
+		    (uintmax_t)(exists + broken),
+		    (uintmax_t)exists,
+		    (uintmax_t)broken);

 	fclose(file);
 	strbuf_release(&alternate);
=2D- snap --

Could you incorporate that into the next iteration, please?

Thanks,
Dscho

> +		    exists + broken,
> +		    exists,
> +		    broken);
> +
> +	fclose(file);
> +	strbuf_release(&alternate);
> +	strbuf_release(&alternates_path);
> +}
> +
>  static const char * const bugreport_usage[] =3D {
>  	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>=
]"),
>  	NULL
> @@ -355,6 +397,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Object Info Summary");
>  	get_object_info_summary(&buffer, nongit_ok);
>
> +	get_header(&buffer, "Alternates");
> +	get_alternates_summary(&buffer, nongit_ok);
> +
>  	report =3D fopen_for_writing(report_path.buf);
>
>  	if (report =3D=3D NULL) {
> --
> 2.25.0.265.gbab2e86ba0-goog
>
>
