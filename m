Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297B2207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 06:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046487AbdDXGOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 02:14:20 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33628 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046483AbdDXGOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 02:14:18 -0400
Received: by mail-lf0-f46.google.com with SMTP id 88so68113873lfr.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uc7JTA+L8CDuBQ+rxNunMur6DMBLF0E9PbNnZ5SHH3s=;
        b=Hj4952/u+Ic7DCnhcJczL7Za/8lcP6ptFIn0Nzgkn9VmiA1sph1/laVnh+WPcKT0eC
         AJiqm5DBPCQBu0GDqJFAoOGUVKG/D/wy+iFALbQCd8Q818TE2u+BVuQ9Ucncz4Bpb4tg
         aMFMldT6egilB6AbgBpqEQZpHHQSOrNIqtZxl42xWUfAy4kxxtXe5Uhjz+SnQ4x7Vjrp
         u8QQ23aH3O06fsipXnKYnuK1tuhypiMYXdxPEeZCbc7oHmkAEzYBcHHNdtK0I4f+6oqM
         bQnO9HPTBlc3zYsTgrERlS7GvtfTTCQ/PKY4lPwVjYrisNohStzySyNQnKHFHTYnoMrH
         N3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uc7JTA+L8CDuBQ+rxNunMur6DMBLF0E9PbNnZ5SHH3s=;
        b=k4daRnmRfFyQwZnBIOKdjG1Nw0gwO8WRQtbjdrG+iJ/+ecWnYBhXOusJE6vrEewZkn
         9SwPi1eDMCBZhOHQqZzPhQkhX4JYxpCoo7611Y8hL/YDWGb3uKYVpdg8pI8P+oCBvH44
         3eM3WVBva8HY17hZTuhFSQYUO/7GvKsbh9gqkMMg5AZ6urG9vBY8dv2twemp+lJYD9my
         +AZMhbY+z9Pt7MBcO1vWSsvqbkobW9kmB6fU9/O5ziD61HwTicrLLSo+Z07WLoUXlf75
         Oo/8kJRKyLPTRQH8VtPQmwm+EXH+erxRPJZoZyw0P38vRA8twOCstmGahH3yUnhM6QzS
         Qzfg==
X-Gm-Message-State: AN3rC/7Cdv2tvt78gs1U0ktmX7h5YdaXJGLK21rfkmD8h+592i9rxC06
        Se7E5EKYw9cuPhu/Sn6mKsWqAcWpow==
X-Received: by 10.25.162.211 with SMTP id l202mr8341817lfe.147.1493014456921;
 Sun, 23 Apr 2017 23:14:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Sun, 23 Apr 2017 23:13:56 -0700 (PDT)
In-Reply-To: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
References: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 23 Apr 2017 23:13:56 -0700
Message-ID: <CA+P7+xppiCsco2RmP_KeKO=yVO1LPvTgvBaEuMf1yVBNPtmnGw@mail.gmail.com>
Subject: Re: I suggest a new feature: One copy from files
To:     Rm Beer <rmbeer2@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 8:47 PM, Rm Beer <rmbeer2@gmail.com> wrote:
> I have a several directories with binary files datas that is discard
> by .gitignore.
>
> I recommend make a new .gitonecopy or .gitonelog or something that
> take the directories with only 1 copy of last updated and not take
> history of files in the repository.
> Maybe anyone found other best method for apply this idea.

So, clearly you haven't defined the request very well. It *sounds*
like what you want is the ability to say "git please store and
copy/send this file to other people, but only store it once, and don't
allow storing history of it". This pretty much defeats the entire
point of revision control and doesn't make sense to me as part of a
revision control system.

Thanks,
Jake
