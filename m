Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100E61F454
	for <e@80x24.org>; Sat, 20 Oct 2018 06:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJTOgU (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 10:36:20 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:37537 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTOgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 10:36:20 -0400
Received: by mail-io1-f47.google.com with SMTP id m16-v6so24284189ioj.4
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i9BqQwZdNhzFVa//WYu/569iSRKYey+BVuy8EV38mNM=;
        b=pfawZ2SWJk7OmG2DFU8yfGH4ZEGhEOEKB3dk0EeegLieJn2Zv4Yp+5W9LNsJH5y2Ca
         AFirqgBQztf/NYi0BZdZGKJ/v8fSMKcOtWAoaWBp+J8Gx3DpzfPXuC9UXVqZPNWetlXZ
         1d3K2oNt611iueUdUfz7JLCJQX8JptAV0z2nz9Yld3EYruIwcrV2PnSm/TB4koI0LmV8
         MdnwjrE3xuPmcURjJJvfxUlRANiPC20R5E8q5ehAq1vts0JTR+KMBjBIqev6Aw/wRIQP
         QIxld6k/JqFMNB+sM/c08KF1pEclVcqTHE/7QI9DN/E8bxRDbh8lbu2kkra9/vPQvHIr
         9VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i9BqQwZdNhzFVa//WYu/569iSRKYey+BVuy8EV38mNM=;
        b=NH7IN9y3vWg7lE8j9Et3Po6jDbo6mAcaSjw5+DcVlgH7SfQpA9s6gl8z9MAhVLN9tW
         lYOXIRNCXmB2jPHEo6BZCKuYQmzVqR2ixMIGJtCgxsUICUJVy5ZkNelPQWbS7kdbR1Fa
         1o/oxQrgO0PzIi0I4m8SXtTVboUUKGKF6HulCiL5n7Tui0ZC1rtBXWm6mhrMrwCwd0GL
         4zbsKDfWDdCGcdg7jseHriedR4fPCUtrAIhgnx4OrMe6l900/IyY+GBxFjFjY+QX7Vj7
         arkhi/epIFodBklnCvbflwdD0JB7r+ik1J1wRViyNZvMG+iPNMCPItjCmPzlT4Ljfx3J
         pNEg==
X-Gm-Message-State: AGRZ1gK9oh8CyKQpawuVtVFtpo759HOg7AtPHQRUIiSL6vtR7eeGxRWL
        1P//VeAwoeuelomJvBS142MlFA==
X-Google-Smtp-Source: AJdET5es+U+j1V3prGE2/CRXlVaYSPrsmyLbp3DLH+DSVNMmcJpj+bmFwbfb6NUJvOkrP8qMFkMCxw==
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr4850279iob.73.1540016820499;
        Fri, 19 Oct 2018 23:27:00 -0700 (PDT)
Received: from heartswap.lan.dana.is (173-21-17-19.client.mchsi.com. [173.21.17.19])
        by smtp.gmail.com with ESMTPSA id s10-v6sm2365572itb.38.2018.10.19.23.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 23:27:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
From:   dana <dana@dana.is>
In-Reply-To: <CACsJy8CMSQZ7guGAyDqU_xdJrt7BiEDwdtePdfmgagnvSb2p=Q@mail.gmail.com>
Date:   Sat, 20 Oct 2018 01:26:59 -0500
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, jamslam@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C1E9A1B-9FA6-40C6-95E0-6C90271C37C1@dana.is>
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
 <20181020052624.GA31433@duynguyen.home>
 <AFFFEB92-0CFE-45BA-8BE3-105E8963A121@dana.is>
 <CACsJy8CMSQZ7guGAyDqU_xdJrt7BiEDwdtePdfmgagnvSb2p=Q@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 Oct 2018, at 01:03, Duy Nguyen <pclouds@gmail.com> wrote:
>foo**bar would match foobar as well as foo/bar, foo/x/bar and
>foo/x/y/bar... Its behavior is error prone in my opinion. There's also
>some concerns in early iterations of this "**" support that we would
>need to revisit if we want 'rsync' behavior. I'm not very excited
>about doing that.

That's fair.

I guess another point in favour of your second option is that it's =
essentially
the same behaviour used by bash (with the `globstar` option) and zsh =
(with the
default options); they also give `**` special recursion powers only when =
used in
a path component by itself, otherwise it acts like `*`. So there's =
precedent
there.

dana

