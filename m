Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D20D20756
	for <e@80x24.org>; Wed, 11 Jan 2017 00:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759691AbdAKAzq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 19:55:46 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36829 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759670AbdAKAzo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 19:55:44 -0500
Received: by mail-io0-f169.google.com with SMTP id j13so64080095iod.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JRCmBG6db/r+5ZOO924cRxdkQK0ijgT93qlKatGMqs8=;
        b=MnEsYx6MqGet83umCYO7wVHWH0bWfjFmPHeqorWTXniMJan4ZEWrn9Vrv0ekl9yFpc
         JEAbZGTn8vh91KPUelGN2Zqb1lGuW7kR2ZhrlFVDMjxAUKs3FRLt2gGxEAx/dll82xKB
         GIv9GnTs4OcKMwWjcUCTIIwapN1Vz0NO8c+W0imXEEciqzgwERXVtlbwaJwIJuxhGh71
         S8RsT08k446F+f6EwGE+Ul+Dy7MTfM7MpxWxgIwrgOfUuY3WmBzKNf/g5mD3Pv4IUgUG
         HRNn45FDOBegReVsANGjnJ3Urhre1SeqWNl9F/iFpp5KUKNhwXN1N2qpHl+A4DMGAKLI
         d+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JRCmBG6db/r+5ZOO924cRxdkQK0ijgT93qlKatGMqs8=;
        b=fOgk2lPXzFR4GMCOuS5Ow5+UYaBzLBac2rrBr2Tv/xnZiJhzFNQ6xW3cWlynNaxbab
         VPBwXPfvu8zn6sI1TyJYbmuCI7A+88l8PzE3f40EkIPdCdEVnokfK1srkCQ1BCmgmwG1
         39ZCvkhjQk3kiffNU3Odrti4M4K2sKxRQA96iWtv0MHOvTSiQFZVVWE5z6TDQMWXYIDa
         3X8iPYkZVKPL5NjtMdUbkJ9rivUpIbcIgMI6/86Pi3q+QnHNFVMyKGB3go6KzQcqbwVr
         6/WocCwRkQeDzTqxtrUCOuqgklmtSExVO7zIvGCU9aEFNFt6wsZW0qB/eTeYOAcYr+lT
         sLoA==
X-Gm-Message-State: AIkVDXLC9Wy/AqdUWbXUKb57znic6vx/ga+IZDFAgfFQ26p8hjr/o1r5Jip8bDa6/jP+mVCT55qh5wi+3a1lONFB
X-Received: by 10.107.37.148 with SMTP id l142mr5475077iol.159.1484096143769;
 Tue, 10 Jan 2017 16:55:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 16:55:43 -0800 (PST)
In-Reply-To: <xmqqd1fupjbs.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1fupjbs.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 16:55:43 -0800
Message-ID: <CAGZ79kbfc+VeLYptDzmcUF+feimUZuDF9HCw9oJN4iCRcL0LYw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2017, #01; Tue, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 3:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.

These two are not included:

A bug fix (regression from rewriting submodule stuff in C)
http://public-inbox.org/git/20170107001953.3196-1-sbeller@google.com/

And another cleanup series
http://public-inbox.org/git/20161227193605.12413-1-sbeller@google.com

I just assume you're still back-logged due to your travel around new year,

Thanks,
Stefan
