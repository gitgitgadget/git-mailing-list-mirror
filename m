Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4B7202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 10:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759625AbdKPK0O (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 05:26:14 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:43899 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759621AbdKPKZy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 05:25:54 -0500
Received: by mail-wm0-f43.google.com with SMTP id x63so1836304wmf.2
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 02:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xuiHyp/3k80wXxs0M5vJ23Rp9+23CJrsveb8anM1zMw=;
        b=nkgif/biqIH6CioyCT8ubaep/BX0g3PW+lrBu4VYnf0twk4ZhXo8MzhpA1z04z54nX
         HV6hpVm/50YCcjz0tm/SRaz/SGw4uMf2uWejVFNZ8t+YDd4z1lHCYG1BzvVxvG24Eo45
         Eqgibpd3x/rkgtHWO4qnATnU9D1cjmjILhou1jiuzdKbfBFIwbVkWQzTHAdsYd9LAJUH
         2i8fdKHK/lligtnafzeY8Ne4A2skKXbcM0Z8hU31iPkaZg4qFB5HAsR66ijWZul3Hj2M
         ohGVUx4vJjwEXNWvVPJJbijRUvbbdK6b+/G3TGfdnhei1r5YqZkvPCH97AHdI/o3ut2w
         qcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xuiHyp/3k80wXxs0M5vJ23Rp9+23CJrsveb8anM1zMw=;
        b=oQJHVOS1udTfpVNx2XbDrOY2kJ57wrJNDEt3PD11sz8ejzOXYefiwhkoF/E04/jdLp
         asKucx5c9NNC9X3kS/BV+7BtgWojYsRbzd3pwOa2H+ZIXy9KclsJFl3zY7dB4IpetsdH
         omz8Jqs8+l/QXSYibI6+xBbmuEXUi/p3NnQwx3LjZMgFx3cpl+L+VvBq57lCxTk6laWF
         224g2B1ioBzEpKJiaKmDobzLChnJM+4vp0+0mBJ5K5NyNKUOl6uQavAMfHmfOtBZQPv4
         SDM6GiLNZLdZvKJprBG1Y8ea+Kcv+wN57+Z2uAtEkgoOrR8ldiAKTPbJlxCglg4NrRZ4
         kU5g==
X-Gm-Message-State: AJaThX5Aiq7Fm6t5MX8S2qIbPiQunpNgxXhttWAKEvdfWm4uFCdzzUim
        pCkYE19ImqSClRbUU2NLqmyS3Fur
X-Google-Smtp-Source: AGs4zMY8gEsVRknKzVCbC/Wepmbgl1uIDtyJIhAk3YNj4u1X0rQpOpIse7mo6UP4Qi3HGRZrW1JohA==
X-Received: by 10.28.94.144 with SMTP id s138mr1029477wmb.0.1510827952787;
        Thu, 16 Nov 2017 02:25:52 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id s12sm2457893wrc.89.2017.11.16.02.25.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 02:25:51 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Nov 2017 11:25:50 +0100
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAEC36C7-AE09-4C9B-ACC4-07F2C5F2B97F@gmail.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com> <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Nov 2017, at 07:04, Junio C Hamano <gitster@pobox.com> wrote:

Wow. Thanks for the quick patch :-)


> When a graphical GIT_EDITOR is spawned by a Git command that opens
> and waits for it for the user input (e.g. "git rebase -i") pops its
> window elsewhere that is obscure, the user may be left staring the
> original terminal window s/he invoked the Git command from, without
> even realizing that now s/he needs to interact with another window
> the editor is waiting in, before Git can proceed.

Maybe:

When a graphical GIT_EDITOR is spawned by a Git command that opens
and waits for user input (e.g. "git rebase -i"), then the editor window
might be obscured by other windows. The user may be left staring at the=20=

original Git terminal window without even realizing that s/he needs to=20=

interact with another window before Git can proceed. To this user Git=20
appears hanging.


> Show a message to the original terminal, and get rid of it when the
s/to/in/ ?

> editor returns.



> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
> * I tried this with "emacsclient" but it turns out that Emacs folks
>   have already thought about this issue, and the program says
>   "Waiting for Emacs..." while it does its thing, so from that
>   point of view, perhaps as Stefan said originally, the editor Lars
>   had trouble with is what is at fault and needs fixing?  I dunno.

Based on my (not too extensive) testing, Emacs is probably the only=20
editor with this clever behavior.


>   Also, emacsclient seems to conclude its message, once the editing
>   is done, by emitting LF _before_ we have a chance to do the "go
>   back to the beginning and clear" dance, so it probably is not a
>   very good example to emulate the situation Lars had trouble with.
>   You cannot observe the nuking of the "launched, waiting..." with
>   it.
>=20
> editor.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>=20
> diff --git a/editor.c b/editor.c
> index 7519edecdc..1321944716 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -40,6 +40,28 @@ int launch_editor(const char *path, struct strbuf =
*buffer, const char *const *en
> 		const char *args[] =3D { editor, real_path(path), NULL =
};
> 		struct child_process p =3D CHILD_PROCESS_INIT;
> 		int ret, sig;
> +		static const char *close_notice =3D NULL;
> +
> +		if (isatty(2) && !close_notice) {
> +			char *term =3D getenv("TERM");
> +
> +			if (term && strcmp(term, "dumb"))
> +				/*
> +				 * go back to the beginning and erase =
the
> +				 * entire line if the terminal is =
capable
> +				 * to do so, to avoid wasting the =
vertical
> +				 * space.
> +				 */
> +				close_notice =3D "\r\033[K";
> +			else
> +				/* otherwise, complete and waste the =
line */
> +				close_notice =3D "done.\n";
> +		}
> +
> +		if (close_notice) {
> +			fprintf(stderr, "Launched your editor, =
waiting...");

I also noticed that some people don't get that they need to save and =
close the
file to continue. Plus, we should tell them that Git is waiting for =
*them* and
not anything else. Maybe we should also tell them the editor name, but =
that might
be too verbose. I dunno. How about this?

	fprintf(stderr, "Launched your editor ('%s'). Adjust, save, and =
close the file to continue. Waiting for you input... ", editor);
	=09

- Lars=
