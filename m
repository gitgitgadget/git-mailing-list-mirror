Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687B81FF76
	for <e@80x24.org>; Mon, 26 Dec 2016 20:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbcLZUds (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 15:33:48 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35004 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbcLZUdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 15:33:47 -0500
Received: by mail-qt0-f179.google.com with SMTP id c47so314663736qtc.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P4gI0vxpfOAulviRh3dVcEHR43uFshEwe9eUEHhfh0k=;
        b=DnVacvdamWLMROf5E8ExwI55j48+xhVBjRi3k/Y396VTBj8XgAY4RGg4IgoIcfskCC
         p4Fpa55mjpGm7k7U1pOxdczzSGuZjawUKUKC4L5ve1o/FD0fxRufKduGHd5fkRlz7DJO
         jrR19PnanGKUhpC+BSIZo5leCzYOb45elVBPrsHPPfytm6qgNdNnv2qcBSfcpIegm4a6
         Gi51L7SMLjvnPEZF9V+0ACpsQ0fx14VZd35KlF7NYM4lyKW1gVnIDmHJnGhuQv/qkrTP
         KkFA7JknvHYZvQf0TnKQWQ5vJnTKyk2XaAndNLjEE0W4UsbPOgzw9x8WtZo8Bvw+too/
         6G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P4gI0vxpfOAulviRh3dVcEHR43uFshEwe9eUEHhfh0k=;
        b=HxOVT9UdrS23vT9BvfYdBbD42h5IkqYGib8ytZaccG8LxbbkmcZ7Q9qOQ514Rby4nK
         dGgwuY/qBG+lV0H2lDX6cr0PEFf46yNa3Wcarbr9mANh5yO7LY/QhLyom8VnL+fiFSPC
         kyfwYkWOzMRTf4a0F6GBKUB4FzNhBBZxnuPPdcz4y/6Xhszka/ne7qHZMqw2lg3iGPRj
         OV0RNF3sS9PKHay7N+FyVUhsra8uJzIsaSXqBRhp5fJovwNwiFzQaQ6khvf8TosZJoaf
         MounCrX3Kf405ermiAoCvM9WjsNrgbeco97H3ydfeNilyVDOnEjAgsM+S8k18F0+TPI5
         DvEg==
X-Gm-Message-State: AIkVDXJID2lKZq9UGDc3Wt7BhAfDhApgrE18o4X7pc5wSd5UGD0DdKFrcyMz0N0d7G+Eesrc8yKCvDroDoQH2BGt
X-Received: by 10.200.44.217 with SMTP id 25mr23805969qtx.176.1482784426109;
 Mon, 26 Dec 2016 12:33:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.210 with HTTP; Mon, 26 Dec 2016 12:33:44 -0800 (PST)
In-Reply-To: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
References: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com> <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Dec 2016 12:33:44 -0800
Message-ID: <CAGZ79kbWEjQxE2S9RVyUsSd9OPwk1U-EMwDxf6C17+tg2q6w=g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #07; Thu, 22)
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 3:55 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> "next" seems to generate a small error on macOS. Probably introduced in
> "worktree: check if a submodule uses worktrees" (1a248cf)

Thanks for reporting, will send a fix on Tuesday.
