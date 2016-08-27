Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B061F859
	for <e@80x24.org>; Sat, 27 Aug 2016 08:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755117AbcH0IEN (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 04:04:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33813 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755112AbcH0IEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 04:04:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so2371047wma.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/vWLu7vhdyngL031LOF0hm+T1DqnujB6mzXZUkHGZ3M=;
        b=vsFDQI5zEhkWPwVM9LJpCvJxRJCs6Px/xqXtKlW3RtD8gidax8gFaD/KWsgfCZaQ0v
         EZiGG2owxSykzx8xsS6e+jZ2v5m7dnFyTBUfNmD59RhBQq0TuxXGUu/9447h8x7Fo1Q4
         H5i5cOSznmkMr7DLd3qf76QSyI/pO6nQevsGuhgpA+RFmJl5zB+XND6hgrnETe5QskR8
         Td7Tu1rqxTl68psSmrOvK7F2GvBNRyBAbF57t01nrPpcB09gn5XGsNUfScNwhLKjTWFg
         A/0eq3NmXMeuVYFDzT9O+6JZ7QfwyLCPbpG4pnhO6hCUN4DpRDJKHrZshqixaO7WruSH
         1Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=/vWLu7vhdyngL031LOF0hm+T1DqnujB6mzXZUkHGZ3M=;
        b=GHDzfF3ALIkKet6IoI3WE9Nirtbn9+hKnhPwLqLgHSaWrpMatdM+KpeLxbfaDFT9nJ
         8/Wvm0sda2YmUmTVPCLzj7enkrGxmuNqrLpu000VfnRDm1Mc/d9hOwo0xQWB37zQjbuX
         IW5BCnuTiYBaD5HDcLcZZtHKfqKxiJbp4l0cmmjHz0wnJ+sr4mdmOFE6zDoW2NWG6pXf
         xhQyqslBHlvUO1EQYJgYof+XQ/C/z9wkpXpmpzgnB6VBPN7RBT3ShzE0D4KX6KZ5YXip
         kuoOoqzK5UACrHlIXANsbiebgq0JojX1b5Jcch8euCgIiDrEw/ws6MwA4eo22JIbTvPV
         lSkg==
X-Gm-Message-State: AE9vXwOwhe3tQA9E//iD0vPg9ZqArA0d6UFM6GqdOxe/TS1TOsORsohpU1pGX+0mrDOIUw==
X-Received: by 10.28.45.65 with SMTP id t62mr2194256wmt.14.1472285049901;
        Sat, 27 Aug 2016 01:04:09 -0700 (PDT)
Received: from [192.168.1.26] (dav122.neoplus.adsl.tpnet.pl. [83.23.21.122])
        by smtp.googlemail.com with ESMTPSA id s6sm23466405wjm.25.2016.08.27.01.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 01:04:09 -0700 (PDT)
Subject: Re: [PATCH] Documentation/SubmittingPatches: add quotes to advised
 commit reference
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20160826222714.31459-1-sbeller@google.com>
 <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dev+git@drbeat.li
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0a480dd8-186f-8411-3f9b-371a4628b342@gmail.com>
Date:   Sat, 27 Aug 2016 10:04:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.08.2016 o 00:42, Junio C Hamano <gitster@pobox.com> pisze:
> Stefan Beller <sbeller@google.com> writes:

> -- >8 --
> From: Beat Bolli <dev+git@drbeat.li>

???
