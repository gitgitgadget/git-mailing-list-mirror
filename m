Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C4C1F42D
	for <e@80x24.org>; Fri, 25 May 2018 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966593AbeEYPol (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 11:44:41 -0400
Received: from mail.javad.com ([54.86.164.124]:34155 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeEYPok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 11:44:40 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id DF3583E99B;
        Fri, 25 May 2018 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527263079;
        bh=2BFv+nNy7pDbKeYOnvOzhSe2gHA8m1n2vVJlcmz552Q=; l=285;
        h=Received:From:To:Subject;
        b=a/vAq597VW/TOQDZ6KIvqcM89UH4sOheqZdenH1mz2UMn4/JczGlsXiWCuJ8wW6s4
         hSzOd5exDYFyj50zzLrmwGWgGLv0mLhuADLpb/EqOGb1hfaFa0HPgDVQYJ3xugYhfC
         NfMKfrVZVDd1oyDTrSYnY2c9kBr5OHWnVHWpyK80=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1fMEtQ-0002gf-Cj; Fri, 25 May 2018 18:44:36 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v9 00/17] rebase -i: offer to recreate commit topology by rebasing merges
References: <cover.1524306546.git.johannes.schindelin@gmx.de>
        <cover.1524659287.git.johannes.schindelin@gmx.de>
        <87zi0nvmvx.fsf@javad.com>
Date:   Fri, 25 May 2018 18:44:36 +0300
In-Reply-To: <87zi0nvmvx.fsf@javad.com> (Sergey Organov's message of "Fri, 25
        May 2018 17:19:14 +0300")
Message-ID: <87vabbu4d7.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This has been sent by mistake, I'm sorry, please disregard.

Sergey Organov <sorganov@gmail.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Junio, I think this is now ready for `next`. Thank you for your patience
>> and help with this.

[...]

