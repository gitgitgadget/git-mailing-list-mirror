Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5A21F453
	for <e@80x24.org>; Tue, 16 Oct 2018 05:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJPNYY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 09:24:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeJPNYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 09:24:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so20898881wmg.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pgwpzzH3k7SBAJZghdvFDoTxs8RZExWn+xKrSVqTuDY=;
        b=n0mK/zr0HWWP3zM349Cqiqah7IJwP0btwlHddlpYJF4Z8uIgH4H68xshvz8Dd3ZCFA
         sC0VAY0DFYGVqboFmUECTsZFlVzmBJD7G17wzdqDkuJ8vCtjmL1BH1WiCygbhUH/cnvF
         b9wYei943qBXrSzY/e9lNajjC6u1iS8rXosDOGanraZ7ukmiTeVMjGSU7Br3b4QYxfTX
         IOlkEVNiBwVgxcGIembbEXqB5S76TD7dXb1SQkMEg340BpqrtIgqPDTx+bWj25xwycPd
         +nFvgZkVnhSs6vqL34IWb7Py2xpLIp47IzpnTKUhXAn5PV9Qlvwmg9VfB7MkbbsUhCzz
         0dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pgwpzzH3k7SBAJZghdvFDoTxs8RZExWn+xKrSVqTuDY=;
        b=kMXbocDNnKzjqajISibmmtefAWhL8RowhQFn60rt3VSOPEbJ9ZQ77ehuqjW5AWT4mQ
         IELyFeKq+aLiQlHcuZu7bNAAjFKs7TpHX0q0lBjOV5nAv6piAyEnk4fRlBkyjBHu9sGy
         C9xq7G0xmPP3wXq6TBtUzu3ZM4dbVLSCaExaC7+or/VqqSRl4HZ+M7iZiMflV7NitEYw
         Z5M6TI9cbAHnZvWCUWIOMFV8aRlsJGaUHz4s28urWTfudz2opbCcMCYr38Ltyi1q1A4Z
         dX2HaFNQlrPnzlhK4qstDXQlXxyrCFz/aX5+zKvxk0wumJ47LRPBiJq++BYEeL48R3Yj
         lrCQ==
X-Gm-Message-State: ABuFfoiEXnxsKbY+RJAqfQiZGQmm5Dd+OoJtgIj5ogYt3ZA0/L7+LiSv
        FEBjQJJ5tn0bs3Tnm3787UY=
X-Google-Smtp-Source: ACcGV60K63V/LdBK9F2P9Ok60qVroUsf59zAY2sDxtl0H3Li+FqvgWHu9kQTZpXciiqLSCrXLSrSEQ==
X-Received: by 2002:a1c:8085:: with SMTP id b127-v6mr15455974wmd.146.1539668140646;
        Mon, 15 Oct 2018 22:35:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 82-v6sm12452857wms.17.2018.10.15.22.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:35:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 06/13] Add a build definition for Azure DevOps
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
        <1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com>
Date:   Tue, 16 Oct 2018 14:35:38 +0900
In-Reply-To: <1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 15 Oct 2018
        03:12:06 -0700 (PDT)")
Message-ID: <xmqqsh16zc5x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Also, we make use of the shiny new feature we just introduced where the
> test suite can output JUnit-style .xml files. This information is made
> available in a nice UI that allows the viewer to filter by phase and/or
> test number, and to see trends such as: number of (failing) tests, time
> spent running the test suite, etc.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  azure-pipelines.yml   | 319 ++++++++++++++++++++++++++++++++++++++++++
>  ci/mount-fileshare.sh |  26 ++++
>  2 files changed, 345 insertions(+)
>  create mode 100644 azure-pipelines.yml
>  create mode 100755 ci/mount-fileshare.sh

I wonder if there is a need to keep what is tested by this and
Travis in sync in any way, but most of the logic is not defined in
these "steps" but implemented in ci/*.sh scripts to be shared, so it
would be OK, I guess.

> diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
> new file mode 100755
> index 0000000000..5fb5f74b70
> --- /dev/null
> +++ b/ci/mount-fileshare.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +die () {
> +	echo "$*" >&2
> +	exit 1
> +}
> +
> +test $# = 4 ||
> +die "Usage: $0 <share> <username> <password> <mountpoint"

Missing closing '>'.

> +
> +mkdir -p "$4" || die "Could not create $4"
> +
> +case "$(uname -s)" in
> +Linux)
> +	sudo mount -t cifs -o vers=3.0,username="$2",password="$3",dir_mode=0777,file_mode=0777,serverino "$1" "$4"
> +	;;
> +Darwin)
> +	pass="$(echo "$3" | sed -e 's/\//%2F/g' -e 's/+/%2B/g')" &&
> +	mount -t smbfs,soft "smb://$2:$pass@${1#//}" "$4"
> +	;;
> +*)
> +	die "No support for $(uname -s)"
> +	;;
> +esac ||
> +die "Could not mount $4"
> +

Trailing blank line.

Thanks.
