Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65A21F516
	for <e@80x24.org>; Mon, 25 Jun 2018 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeFYRiW (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 13:38:22 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:55721 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755365AbeFYRiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 13:38:21 -0400
Received: by mail-it0-f41.google.com with SMTP id 16-v6so13629353itl.5
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebIpZr+5URZ4qHPJReryOnIjF+qOvh9fQb1hz2N6SOc=;
        b=DN33QWEEhJHkWbAYarqi+2mfX1zaOaFhTx3VtJVAcuPN979Fjcxb2izfPB8hS0Foey
         9lefIK2T0kily1eWQ896QbXMqQWe2TUjt0Fsf7QkRrfYSZCvAydAmFo7umqs1u0Ln+Ef
         2kJapbS7ly/xHUUhoGFMxU/0i/tucMUV5BpAEFzUCAuYb6bQQ6h8ts2naxBXsJSTQL5B
         SMc8y93secvfta0VpLQTFvxhB18OTrvtQKdfHLlOAQXctEidOX2CqYMXtljtIC4+GeQz
         rCxUJEC5/gShRrNnwVRZvVucDkekVt4bh6yDw2gylkEdlonuOeYxGGi8rZhx2BWOmIPa
         UnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebIpZr+5URZ4qHPJReryOnIjF+qOvh9fQb1hz2N6SOc=;
        b=CH+W2d3xZoJ0OI4dY+t+uaSW8I0hec1ElyBqBzTaJ/yRcPMuRESzXMeJBSLYdKe2wC
         syfnC8VpMv1VrXMXirUgZIo9Ya4jnztrHauwIXmucxzSaVa1z5MWMKyIiWGbMPwJq7VZ
         O3Xh6EWhUxLwYIvjm6I4BytWoKEZeVUYfmKnA64kXVUbyRnrUJ/8X23k2T7ZVz4zWun4
         TgPfy3w9epsGA2OziAP4V1K8kKM34A6GIcXR1WySt+vee2wPgUpAv3gsUkekHtRUS40u
         s7SzEKNSlea8aGu4zZHH58TCVqnmATt5DwpPfQi4UBnx4plcpDx4zwDvHTgVAj4irgCw
         30+g==
X-Gm-Message-State: APt69E2MO01apTQQNoCYF1C3L0ZJ3zuabb7M+NvCEQETdVBd9fAW6X2n
        9IVfk7cW0hfz8OKnIW1Bd1zH+4QcKoBr+S9tVbbobQ==
X-Google-Smtp-Source: ADUXVKLdAJivBQbG5mw0afF0U5lZ0hXZhVc3I6//JjBAvIHfTniNGOKN1e/HcFtErVvv3KRQYffroGkzTW3uV1MHEQU=
X-Received: by 2002:a02:946b:: with SMTP id a98-v6mr10361569jai.18.1529948300858;
 Mon, 25 Jun 2018 10:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
 <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org> <2cf2d884-de1a-7b9b-5aca-1f396ad205a2@syntevo.com>
 <CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com> <xmqqfu1aq0ya.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfu1aq0ya.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 25 Jun 2018 10:38:07 -0700
Message-ID: <CAGyf7-GeE8jRGPkME9rHKPtHEQ6P1+ebpMMWAtMh01uO3bfy8w@mail.gmail.com>
Subject: Re: Unexpected ignorecase=false behavior on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, j6t@kdbg.org,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 9:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bryan Turner <bturner@atlassian.com> writes:
>
> > Git on Windows is not designed to run with anything other than
> > core.ignoreCase=true, and attempting to do so will cause unexpected
> > behavior.
>
> Even though I fully agree with your conclusion that the document
> must make it crystal clear that core.ignoreCase must be set to
> reflect the reality, I found the above statement misleading and do
> not want it to be used as the basis of a documentation update.  But
> it is possible that I am misunderstanding the current state of
> affairs.
>
> Is the case insensitivity that deeply ingrained in the Git for
> Windows code?
>
> IOW, even if the code used to build Git for Windows were executed on
> a case sensitive filesystem, is there a case-smashing code on _our_
> side that kicks in to cause unexpected behaviour, _even_ when
> core.ignorecase is set to false to match (hypothetical) reality?
>
> To put it yet another way, if a case sensitive filesystem were
> available, wouldn't running "git init" from Git for Windows in a
> directory on such a filesytem set core.ignoreCase to false in the
> resulting repository and from then on wouldn't everything work fine?
>
> If my suspicion (i.e. the code for Git for Windows is perfectly
> fine---it is just the users are not running with case sensitive
> filesystems and flipping core.ignoreCase to true does not make case
> incapable filesystems suddenly capable) is correct, then it is not
> "Git on Windows is not designed to run" from two angles.  (1) it is
> not just Git for Windows---Git running on UNIX that mounts VFAT, or
> Git running on macOS with default HFS+, would exhibit the same
> symptom, and (2) it is not "Git is not designed to run"---it is
> core.ignoreCase that is not designed to be a way to make case
> incapable filesystems suddenly capable of distinguishing cases in
> filesystems.

Apologies for the unclear word choice. Given Git was designed first to
work with case-sensitive filesystems, certainly the obvious (and
correct) conclusion is that Git itself is fine in a case-sensitive
environment. It wasn't my intention to suggest otherwise.

Note that my word choice was not "Git _for_ Windows", however; it was
"Git _on_ Windows". (This still doesn't change the correctness of your
clarification, let me be quick to add. I'm only pointing it out
because it's relevant to what I intended the comment to say.) On
Windows, the default filesystem is NTFS, and NTFS is not case
sensitive. Hence, Git on Windows (by which I'm implying Git on NTFS),
is not designed to run with anything other than core.ignoreCase=true,
because that setting aligns Git's expectations with how the underlying
filesystem actually works. In other words, Git on a case-insensitive
filesystem (APFS, HFS+, FAT32, exFAT, vFAT, NTFS, etc.) is not
designed to be run with anything other than core.ignoreCase=true.

Bryan

>
> Thanks.
