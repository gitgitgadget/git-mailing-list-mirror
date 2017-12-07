Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB7D20C33
	for <e@80x24.org>; Thu,  7 Dec 2017 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbdLGQgY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 11:36:24 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46465 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdLGQgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 11:36:22 -0500
Received: by mail-wr0-f194.google.com with SMTP id x49so8100551wrb.13
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 08:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=APO+wAqTDgrwzPz2XaJzxIM5OO3vHHhKGLOiIkz2spM=;
        b=WAh/az82R1lvd9Agj+Tsc4yoxkxp1SjYU4QgHzhxxWcuAVkTdG483wKDykkT9aNzDb
         J9Wr1lQI35kzQrwGmVlbNNRyEFhFUvQAYZAPH0Lcj3VrhczRpOXdX//ggyh9SOsIOesb
         txLqVMIG56Js7csxKTL2p7uOwD5CBG3anK1zgwpiUM5G8vQkoi0l5t2HAPGvBm1lWQwE
         zX+IGicWVqHz7PZZIzXWqdUHA/et+W32BacDNimuE8X3bwEgTYJt4U4N+IFSp+pQFQHg
         p4H3tBmOEOcTG6swdCcUGjT+JH3dhGbIDpaQAqs2QskgEWQ5/TxbP0VTlBHdky+JAKLl
         UROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=APO+wAqTDgrwzPz2XaJzxIM5OO3vHHhKGLOiIkz2spM=;
        b=NJKimqNQ3ooJBRVzUV2gJFEYcMgPoY/4Nsuwxr+lzrnRBwRU9LzYoNNnlF0VU1VjTg
         QgT2/fkoKuIJoGFHuPff8OMhi9YWGEqqn1hs3ZPtb8RLVGkrrhxyH36/3la4n7HqCQfI
         kROc9bhGZiZv1iFUBr/Abg3VmeI/9UxDERXXoOBAfmaHrEomO0EE2fpIXoDzeJpdH/xJ
         E/yFgN+OnTSRn6/0CH8vcTIp3ubGo6EgmEGcvKXNQuHvQop9D0Ea+kwGRATKprnqtbDj
         ejxxVlWdVD7Yh9t8Wxh41EULvEwFPwCd6gBSEHaAd3d4mHTIjO5WGI0/Q2OqPIqbXZh0
         VTug==
X-Gm-Message-State: AJaThX65CpftvyB5mtKMq+0zRKjqfFBXNU2cRgkz0g3hIsxKBgeD8U6V
        TeAwOQD32T+TJaWDMxNpYcIv754/
X-Google-Smtp-Source: AGs4zMY6cDHSvFWpduDPQ7+WoH9JyuEL0BZo8gvhMdnzAzfqYjW7onwmDybngssbth16jrKqBty5QA==
X-Received: by 10.223.195.103 with SMTP id e36mr24311854wrg.10.1512664581221;
        Thu, 07 Dec 2017 08:36:21 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 192sm6294040wmg.32.2017.12.07.08.36.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 08:36:20 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqmv2uec0p.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 7 Dec 2017 17:36:19 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5CBD713-5F68-4704-B110-66689A1678E0@gmail.com>
References: <20171207151641.75065-1-lars.schneider@autodesk.com> <20171207151641.75065-3-lars.schneider@autodesk.com> <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com> <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com> <D17F94FA-702E-4E37-BDA5-94F0FFD5BD01@gmail.com> <xmqqmv2uec0p.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Dec 2017, at 17:30, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> Can you squash that if you like it?
>=20
> I thought you also had to update the log message that you forgot to?
>=20
> Here is the replacement I queued tentatively.

Perfect. Thanks a lot for your additional fixes!

- Lars

>=20
> -- >8 --
> From: Lars Schneider <larsxschneider@gmail.com>
> Date: Thu, 7 Dec 2017 16:16:41 +0100
> Subject: [PATCH] launch_editor(): indicate that Git waits for user =
input
>=20
> When a graphical GIT_EDITOR is spawned by a Git command that opens
> and waits for user input (e.g. "git rebase -i"), then the editor =
window
> might be obscured by other windows. The user might be left staring at
> the original Git terminal window without even realizing that s/he =
needs
> to interact with another window before Git can proceed. To this user =
Git
> appears hanging.
>=20
> Print a message that Git is waiting for editor input in the original
> terminal and get rid of it when the editor returns, if the terminal
> supports erasing the last line.  Also, make sure that our message is
> terminated with a whitespace so that any message the editor may show
> upon starting up will be kept separate from our message.
>=20
> Power users might not want to see this message or their editor might
> already print such a message (e.g. emacsclient). Allow these users to
> suppress the message by disabling the "advice.waitingForEditor" =
config.
>=20
> The standard advise() function is not used here as it would always add
> a newline which would make deleting the message harder.
>=20
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/config.txt |  3 +++
> advice.c                 |  2 ++
> advice.h                 |  1 +
> editor.c                 | 24 ++++++++++++++++++++++++
> 4 files changed, 30 insertions(+)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9593bfabaa..6ebc50eea8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -351,6 +351,9 @@ advice.*::
> 	addEmbeddedRepo::
> 		Advice on what to do when you've accidentally added one
> 		git repo inside of another.
> +	waitingForEditor::
> +		Print a message to the terminal whenever Git is waiting =
for
> +		editor input from the user.
> --
>=20
> core.fileMode::
> diff --git a/advice.c b/advice.c
> index d81e1cb742..af29d23e43 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -17,6 +17,7 @@ int advice_set_upstream_failure =3D 1;
> int advice_object_name_warning =3D 1;
> int advice_rm_hints =3D 1;
> int advice_add_embedded_repo =3D 1;
> +int advice_waiting_for_editor =3D 1;
>=20
> static struct {
> 	const char *name;
> @@ -38,6 +39,7 @@ static struct {
> 	{ "objectnamewarning", &advice_object_name_warning },
> 	{ "rmhints", &advice_rm_hints },
> 	{ "addembeddedrepo", &advice_add_embedded_repo },
> +	{ "waitingforeditor", &advice_waiting_for_editor },
>=20
> 	/* make this an alias for backward compatibility */
> 	{ "pushnonfastforward", &advice_push_update_rejected }
> diff --git a/advice.h b/advice.h
> index c84a44531c..f7cbbd342f 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -19,6 +19,7 @@ extern int advice_set_upstream_failure;
> extern int advice_object_name_warning;
> extern int advice_rm_hints;
> extern int advice_add_embedded_repo;
> +extern int advice_waiting_for_editor;
>=20
> int git_default_advice_config(const char *var, const char *value);
> __attribute__((format (printf, 1, 2)))
> diff --git a/editor.c b/editor.c
> index c65ea698eb..8acce0dcd4 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -45,6 +45,23 @@ int launch_editor(const char *path, struct strbuf =
*buffer, const char *const *en
> 		const char *args[] =3D { editor, real_path(path), NULL =
};
> 		struct child_process p =3D CHILD_PROCESS_INIT;
> 		int ret, sig;
> +		int print_waiting_for_editor =3D =
advice_waiting_for_editor && isatty(2);
> +
> +		if (print_waiting_for_editor) {
> +			/*
> +			 * A dumb terminal cannot erase the line later =
on. Add a
> +			 * newline to separate the hint from subsequent =
output.
> +			 *
> +			 * In case the editor emits further cruft after =
what
> +			 * we wrote above, separate it from our message =
with SP.
> +			 */
> +			const char term =3D is_terminal_dumb() ? '\n' : =
' ';
> +
> +			fprintf(stderr,
> +				_("hint: Waiting for your editor to =
close the file...%c"),
> +				term);
> +			fflush(stderr);
> +		}
>=20
> 		p.argv =3D args;
> 		p.env =3D env;
> @@ -63,6 +80,13 @@ int launch_editor(const char *path, struct strbuf =
*buffer, const char *const *en
> 		if (ret)
> 			return error("There was a problem with the =
editor '%s'.",
> 					editor);
> +
> +		if (print_waiting_for_editor && !is_terminal_dumb())
> +			/*
> +			 * Go back to the beginning and erase the entire =
line to
> +			 * avoid wasting the vertical space.
> +			 */
> +			fputs("\r\033[K", stderr);
> 	}
>=20
> 	if (!buffer)
> --=20
> 2.15.1-480-gbc5668f98a
>=20

