Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA00C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhKXAw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:52:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58008 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhKXAw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 19:52:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2BF0F3DD3;
        Tue, 23 Nov 2021 19:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CHerDVYIyc9SRHxMg9+oBGU8Y3FpOHfl2dAIRE
        wN8qs=; b=qTEUnhYfgN3HVGcP2BwYFSn/IuWViMmD9LyQJJ2wWZ+0vEQlEQsoUj
        elsDi0tHUurpWK2fRmWPZVlXAnjdz9vhd1nFyro72hzzmFDhW9Zq5C7d3NyDHoml
        /n3K00ZUn96qO2HFP/TN81J3a0vszGBIA49MEBCr8FHMFP+87VYf4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAF27F3DD2;
        Tue, 23 Nov 2021 19:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46C94F3DD0;
        Tue, 23 Nov 2021 19:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marcos Alano <marcoshalano@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "format-patch" command doesn't support SSH signing
References: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com>
Date:   Tue, 23 Nov 2021 16:49:46 -0800
In-Reply-To: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com> (Marcos Alano's
        message of "Tue, 23 Nov 2021 10:04:17 -0300")
Message-ID: <xmqqczmq5qdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CB7982A-4CC0-11EC-86A0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marcos Alano <marcoshalano@gmail.com> writes:

> I was trying to generate a patch to send to a project (Linux
> specifically) but when I generate the patch using "format-patch" I saw 
> there was no "Signed-Off" line, but my commit is signed using SSH. My
> git version is the latest, 2.34.

Sign-off in Linux kernel project is to certify that you have the
right to contribute the change to the project under Developers
certificate of origin.  I believe in thier project, the document
in Documentation/process/submitting-patches.rst describes the
process (look for "Sign your work")

The "commit -s" signing has nothing to do with it.  It may prove it
was written by the key holder, but it does not prevent the key
holder to steal intellectual property from their employer and
contribute it as if it is their own, and Sign-off exists as a
separate procedure to have you raise your right hand and swear that
your contribution is kosher wrt DCO.


