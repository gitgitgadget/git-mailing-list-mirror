Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1DE1F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbcKOLop (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 06:44:45 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33574 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcKOLoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 06:44:44 -0500
Received: by mail-wm0-f48.google.com with SMTP id c184so22209155wmd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 03:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vd9XFgIykim/kqniNBvmusJcDd0Wnt6/QGI+BncKCQ4=;
        b=LjUlMudO7AEAKL5I0z3AGUjxv9vvQ/f5nUujZGPFZHllKuYnWcsBri4GlzNLJtF6GZ
         s3GEejN1Aehv8+jobUMxOU3DNYoioVbOMrEwoy2A4k2/jMnL1PoACyHuPTaeTSLH+war
         YGju5rd7vBEgHTg0C+wfGNzDvKCGuAmGTQMNzIyWEuaUUxdydL+OsDqZuhNc8b1Ef5cX
         w1qaHXf3mKMzBYIe9ZhZMmIh9vmUF/RaVURJOXHOs1TG/80s5aFgRZvb9jjSqxP/C7k5
         kfk6xckdrdRArB1n3+bZTBKH3hflmrDhhr4iMtP7+hnGV/FsEjw5QP9c9u2vyZMwA5KQ
         dAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vd9XFgIykim/kqniNBvmusJcDd0Wnt6/QGI+BncKCQ4=;
        b=EtSZ4zYFFAgaLzEAf1L06VaP17MaFKDMaRQteIefJV9kETzcGGyhJ3Z370X7ggR5WV
         +Te81KuMTwSnFWA6rvkEmrHP8wigsO9Uqf5BPPTtNdCASOV0hkbhMg033B4EKlERIP0Z
         lrsK7HTflZaA0dzb7JaYv0Lo6+dDFEy1gZL6qt5SooklbxC0a8IVvpZVOwZg4ODvEeDn
         +tcxUnDwf4XP/N2/mwjZd2am7Dt6t/YSnSO4wei4s2lC/Fqi9rIPv6Wk+9EEFtKluzLp
         uVEKY2SwbryiF3pzYnQBrTa8C7oPDKCzNp3xRfmoNDvAFRIoaDKlBFrxQAu5jrzWe3Es
         78pg==
X-Gm-Message-State: ABUngvc73tOkEFvXetqn9a0lx5zFdZzPSOd9RrU1/tfzrzHHXFi93wx/1ArSX9c5VfA6YzjE9AIvBDysa9sX+Q==
X-Received: by 10.25.199.198 with SMTP id x189mr10676727lff.164.1479210282590;
 Tue, 15 Nov 2016 03:44:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Tue, 15 Nov 2016 03:44:42 -0800 (PST)
In-Reply-To: <20161115102400.GC28860@paksenarrion.iveqy.com>
References: <1479202392275-7657456.post@n2.nabble.com> <20161115102400.GC28860@paksenarrion.iveqy.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Nov 2016 12:44:42 +0100
Message-ID: <CAP8UFD2tHW5_L4yPzVSxK2jpUKPKiq26sCnJ1Ts7R5TWiOpzEg@mail.gmail.com>
Subject: Re: Git status takes too long- How to improve the performance of git
To:     ravalika <prenuka@gmail.com>
Cc:     git <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 11:24 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrot=
e:
> On Tue, Nov 15, 2016 at 02:33:12AM -0700, ravalika wrote:

[...]

>> And I have experimented the following ways
>> -          -  Setting core.ignorestat to true
>> -          -  Git gc &git clean
>> -          -  Shallow clone =E2=80=93 Reducing number of commits
>> -          -  Clone only one branch
>>       - Git repacking - git repack -ad && git prune
>> -     - Cold/warm cache
>>
>> Could you please let me know, what are the ways to improve the git
>> performance ?
>> I have gone through the mailing lists.
>
> You could always check the --assume-unchanged bit, see the manual page
> for git update-index. However this is quite extreme and demanding for
> the user.

If you install a recent version version, you may be able to use the
untracked cache feature.
(See "core.untrackedCache" in the git config documentation and
--untracked-cache in the git update-index documentation.)
