Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0142DC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAPTIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjAPTIM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 14:08:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E3D2A145
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 11:08:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 144A360C20;
        Mon, 16 Jan 2023 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673896089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GoRjl25TrlkeJegQmMAFiNbLuGvDyDX1x4ESS7iX7/E=;
        b=Amm8XtT3FAeqWzzpwoLXsVu54CsPrnmUBD4RQzcCgP7h6F2yGH0PET07r9ZJysRKce8WfM
        m0G1yX1EQ9H64ky8ogG8baJEPaYaq2rEeGYKMjy7IXTXxvAJso6dzleraA/bWj0ZDlj1Fx
        YG1e5rR5Qg+Xhwh6DmzFKp69fyjXboo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673896089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GoRjl25TrlkeJegQmMAFiNbLuGvDyDX1x4ESS7iX7/E=;
        b=vzxz2yYexFG+8OfTur+WKNP2e/tEYiEv2859fDSlzqtc9z5UqxDkjLPJeqIdGb6wB2nKoX
        YgDham/YjnvM2zDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F37762C141;
        Mon, 16 Jan 2023 19:08:08 +0000 (UTC)
Date:   Mon, 16 Jan 2023 20:08:07 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230116190807.GF16547@kitsune.suse.cz>
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <20230115135245.GB16547@kitsune.suse.cz>
 <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org>
 <20230116091346.GC16547@kitsune.suse.cz>
 <6a398405-e5f8-0b78-e463-41d79e49e78b@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a398405-e5f8-0b78-e463-41d79e49e78b@selasky.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 10:55:34AM +0100, Hans Petter Selasky wrote:
> On 1/16/23 10:13, Michal Suchánek wrote:
> > when that data is copied to a new location a new
> > CRC is calculated that can detect an error in that location.
> 
> Yes, that is correct, but what is "copying data"? Are you saying that
> copying data is always error free?

Maybe you should not cut out the answer to your qestion?

Thanks

Michal
