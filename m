Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF51220966
	for <e@80x24.org>; Mon, 10 Apr 2017 12:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbdDJMFz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:05:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34984 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdDJMFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:05:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so1461844wrc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F50T8dHKUvCTf67c6HsXd5V8ovUmuPPmtOsCJXinCYQ=;
        b=cjIoIrf5EcYojNxz/sHlKVK3MtRm/yZEORKZY64lUiHPnjTomGpHTh7GWH9SXUTyQe
         8veXRNgZMFSlVb+HDS73GPLl9ti0bo5o3cRxh9wcyTE2lC0+LpCFJHqy9txuXuZn3H1W
         VN7z3lZntO9XTA4r4rAggVELpmAtTSD9wKKohcLEwIbgRB8KxIk5jn3BEoh5n0hRxg8k
         gqS1x1xYPIZJuhdsZbPKzDWl5qQhgZNQgCmkI1/hE/50JXESiY5Wy3hTjr0VROC6BExf
         bVk2as6YrL3kSKrNtZ+niH+430k9W6FGEEPMJ3D8WH1r1S0j+s06FvNoSLJkqKKBhG0g
         yzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F50T8dHKUvCTf67c6HsXd5V8ovUmuPPmtOsCJXinCYQ=;
        b=DYjw2RDSUzTkwEC0mehNB1/hPKEoXdv1s1TPggNNVlHE6/d9nj8Iegl7RfNZ3e52RJ
         KbrRYtZu1KrQYpdYN5+cr2SJ46JXBv3IiT39dxirUEd4DQtTSEq+Ziu7gwVuTVzXeESt
         EAk1LzkZG9NCuWKpIzBrq4ccOmlhxAxRnI3srWqkKWec01I+6OSh+vMBa6tObMawvJs+
         1JDxOXcWInP2kQF4eQ/CVdFkvuloKSOygWhkRAvGShsu4aYxng2kGVx51CYxxG/nC1Zn
         o7K7SHsuAiUa00FKtz/5fL15unC5DBnuJI3dPHvMvQ6fYbW+iF9QLYCk+qf6r6wBH+dZ
         NjSw==
X-Gm-Message-State: AFeK/H1tBvCckgLfm2wuWO8bpIzOupO+YKwQomtIPm3WgBNFSFAfmTbfBePTksnZw1DR8w==
X-Received: by 10.223.128.194 with SMTP id 60mr38179902wrl.175.1491825953552;
        Mon, 10 Apr 2017 05:05:53 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k13sm10028604wmi.28.2017.04.10.05.05.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 05:05:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 5/8] convert: Update generic functions to only use generic data structures
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-6-benpeart@microsoft.com>
Date:   Mon, 10 Apr 2017 14:05:52 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5900F7F1-89D9-433E-A6C3-0AB27C815BE6@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-6-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> Update all functions that are going to be moved into a reusable module
> so that they only work with the reusable data structures.  Move code
> that is specific to the filter out into the filter specific functions.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> convert.c | 46 ++++++++++++++++++++++++++++------------------
> 1 file changed, 28 insertions(+), 18 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index f569026511..747c0c363b 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -576,14 +576,15 @@ static void stop_multi_file_filter(struct =
child_process *process)
> 	finish_command(process);
> }
>=20
> -static int start_multi_file_filter_fn(struct cmd2process *entry)
> +static int start_multi_file_filter_fn(struct subprocess_entry =
*subprocess)
> {
> 	int err;
> +	struct cmd2process *entry =3D (struct cmd2process *)subprocess;

I wonder if a "subprocess_entry" should rather have a generic data =
pointer
for any extra information. However, this is probably bikeshedding and I =
think
this solution is equally good.


> 	struct string_list cap_list =3D STRING_LIST_INIT_NODUP;
> 	char *cap_buf;
> 	const char *cap_name;
> -	struct child_process *process =3D &entry->subprocess.process;
> -	const char *cmd =3D entry->subprocess.cmd;
> +	struct child_process *process =3D &subprocess->process;
> +	const char *cmd =3D subprocess->cmd;
>=20
> 	sigchain_push(SIGPIPE, SIG_IGN);
>=20
> @@ -638,17 +639,21 @@ static int start_multi_file_filter_fn(struct =
cmd2process *entry)
> 	return err;
> }

> ...

> static int apply_multi_file_filter(const char *path, const char *src, =
size_t len,
> @@ -692,9 +698,13 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
> 	fflush(NULL);
>=20
> 	if (!entry) {
> -		entry =3D start_multi_file_filter(cmd);
> -		if (!entry)
> +		entry =3D xmalloc(sizeof(*entry));
> +		entry->supported_capabilities =3D 0;

If we would use a generic data pointer then we could initialize
supported_capabilities in "start_multi_file_filter_fn".


Apart from the bike shedding above this patch looks good to me.
Minor nit: It breaks t0021 "invalid process filter must fail (and not =
hang!)"
test case but I assume this is corrected in a later patch.


Cheers,
Lars


