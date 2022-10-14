Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01ACC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 05:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJNFGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 01:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJNFGH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 01:06:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC35194215
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 22:06:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E7761BF624;
        Fri, 14 Oct 2022 01:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fnsEBZcTeddM702ASJNyFXs4gkd/+joGNbEdbv
        BWFsM=; b=M2IVOl/gEV2T/9qEVTRXMTBAHhwc0jWEYWNuI7dUN4mqK96td8OQTh
        N31+T9YYIaKJq24lp55HNxVorj3uuKLjYm253XPJtzCQQHJrjkQj2Qiqy5/iIfKs
        9qqPdXk8AU+oXnu4Ehl3CuSVgOZU/tj8WCqdn1cUJHLIDypC9NcBU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BED61BF622;
        Fri, 14 Oct 2022 01:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4CEFA1BF620;
        Fri, 14 Oct 2022 01:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH] [OUTREACHY] t1002: modernize outdated conditional
References: <pull.1362.git.git.1665713184304.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 22:05:57 -0700
In-Reply-To: <pull.1362.git.git.1665713184304.gitgitgadget@gmail.com>
        (nsengaw4c via GitGitGadget's message of "Fri, 14 Oct 2022 02:06:24
        +0000")
Message-ID: <xmqqy1tjatai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3CE8362-4B7D-11ED-BD38-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: wilberforce <nsengiyumvawilberforce@gmail.com>

This name must match ...

> Tests in this script use an unusual and hard to reason about
> conditional construct
>
>     if expression; then false; else :; fi
>
> Change them to use more idiomatic construct:
>
>     ! expression
>
> Cc: Christian Couder  <christian.couder@gmail.com>
> Cc: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Nsengiyumva  wilberfore <nsengiyumvawilberforce@gmail.com>

... the name you sign-off your work with.

> -     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
> +     ! read_tree_u_must_succeed -m -u $treeH $treeM'

OK.

