Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE4C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B7B60F4B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhG3OEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:04:55 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:36339 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhG3OEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 10:04:46 -0400
Date:   Fri, 30 Jul 2021 14:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627653874;
        bh=WzcdOx9aR0k4S/6gb8ZcIojFI+HdfE0o71b/ThH0ugI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=pKmTQQ7OsApWSu6wxqpT1GfiBrGPqkJKjSFqa1JFqzN9B/4udg89PdiQYzN0GuWEi
         dVKQJ2iM2V4ls7liEL5bJv9xSon4RQ/hnRNPvibN2ixiB4vNMBni5p0AaVa7u3yq3h
         687oc/vrRqK8UzoyxiMJMF9DlT1ng3EjJaJr0VK15z0emvtHpWHT9SCD0Q5qylHiuD
         3TOG6w9RSuN6QCt4eD73HC2mfzgRn3szD5ZDC0LtPG5/f0zVmLSNHHNEX61dad3TzQ
         IQHhF9GhKpAQ3bR73OwoBZNPpdCWCTVKG42paj5pERDl7UH1DpmrB9RGO4nIVUq8qm
         ulc9Rz/nSzmPA==
To:     Kim Altintop <kim@eagain.st>, git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     Brandon Williams <bwilliams.eng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH] upload-pack.c: treat want-ref relative to namespace
Message-ID: <CD6J50083UWZ.QYE3HJQ3D3B4@schmidt>
In-Reply-To: <20210730135845.633234-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please excuse my newbie ness.

Oops I'm sorry. `send-email` remembered this from a dry run.

Jonathan: I took the test code from your original patch introducing ref-in-=
want,
but modified it substantially. Let me know if it is conventional to credit =
you
anyway, and by which trailer.

