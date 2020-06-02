Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8371AC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9BD20734
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 21:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="CfvQxMD8";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="CfvQxMD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFBVdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:33:53 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:38002 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBVdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 17:33:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id C1F0E4055A;
        Tue,  2 Jun 2020 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1591133631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xIqVbXoJCC7mWuuyhh8CbvpTQak7zeUk2cJlwYXvt4=;
        b=CfvQxMD8l2lmse15/pD4uTrHBmI97u+0/lYd+HOa3IfwiXmaeeA2BP/ntDloktwUV6XjHd
        DcnoeGnNLbEbYDiM5i/aemSnEVOn1Ym4hMWCjcQQ5C38Gms1wsr+hoc7h3woe3V8lCLDNh
        uKTZtDSDZftIjTaB9djco0WiiW6HtC4=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 6C1D140295;
        Tue,  2 Jun 2020 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1591133631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xIqVbXoJCC7mWuuyhh8CbvpTQak7zeUk2cJlwYXvt4=;
        b=CfvQxMD8l2lmse15/pD4uTrHBmI97u+0/lYd+HOa3IfwiXmaeeA2BP/ntDloktwUV6XjHd
        DcnoeGnNLbEbYDiM5i/aemSnEVOn1Ym4hMWCjcQQ5C38Gms1wsr+hoc7h3woe3V8lCLDNh
        uKTZtDSDZftIjTaB9djco0WiiW6HtC4=
Date:   Tue, 2 Jun 2020 23:33:51 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: generate valid patch with diff.noprefix
 config
Message-ID: <20200602213351.GB1853335@spk-laptop>
References: <20200602204924.GA1853335@spk-laptop>
 <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 02, 2020 at 02:12:37PM -0700, Junio C Hamano wrote:
> Some projects (not this one) do not want to see a/ and b/ prefix in
> their patches, and noprefix is an option for those who needs to give
> patches to such projects.  As "am" can be told with -p<num> to accept
> such a patch just fine, I do not think this change is appropriate.
> 
> > Solution is to force a_prefix and b_prefix on diffopt.
> 
> Sorry, I do not think there is any problem to be solved here ;-)

Haha I see thanks for the explanations

-- 
Laurent
