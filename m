Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C1C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 22:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiADWMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:12:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64088 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiADWMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 17:12:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88AFE115B4C;
        Tue,  4 Jan 2022 17:12:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=45RHY0Ti0otyDDBRBh/m9fe2tLZR8Q20p1PjGb
        XYQu4=; b=HPLdiVmiQMviT3l6MQgbK8E2SNt1e2K5m6WkrfkVphHKu6XwOWn2Sm
        qX356CKxtzoIBwYftPTzHr1EOyQ1KYtURdxOacvHm041KVhu3xLJYO2u/Y+qymAn
        m9jZJa0KSq9avpjAon1sRfgGwFLH7tRQOgPu5WVX2MnZae8J+9ke0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81340115B4B;
        Tue,  4 Jan 2022 17:12:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8599115B4A;
        Tue,  4 Jan 2022 17:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
        <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 14:12:10 -0800
In-Reply-To: <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 04 Jan 2022 14:49:35
        +0000")
Message-ID: <xmqqzgob9mmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DA75918-6DAB-11EC-9CDB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	altogether.
> +
> +For example:
> +
> +----------
> +$ cat sample.txt

Because this example is a part of description of `--annotate-stdin`,
not an example after a list that ends with `--annotate-stdin`, you
would want to tweak the above a bit.


diff --git i/Documentation/git-name-rev.txt w/Documentation/git-name-rev.txt
index 96e8fd5ea4..0f32d74de0 100644
--- i/Documentation/git-name-rev.txt
+++ w/Documentation/git-name-rev.txt
@@ -47,9 +47,9 @@ OPTIONS
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	--name-only, substitute with "$rev_name", omitting $hex
 	altogether.
-
++
 For example:
-
++
 ----------
 $ cat sample.txt
 
