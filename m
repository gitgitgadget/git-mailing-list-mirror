Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6762D205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941256AbdAGJfc (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 04:35:32 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34912 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbdAGJf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 04:35:26 -0500
Received: by mail-it0-f68.google.com with SMTP id 203so1203986ith.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 01:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nfiV4Gp/MeGPk1x4dhku6y5413OI/XmmoTE8c0+bWg0=;
        b=DpHpRqrS64nihr3nqe3XpTLv8LYlPkbSxB6NKT8NzQJ8fgJfAfNOpGvyM6zxXEk+r+
         S6qMbWDaUMxsCi/dhrt2XVOg3WhBfJnFsny5gskomqYGz4gmyy9Y0/AD5JngggapTbJu
         Y381x8xtLY2y+aMJG5fLU2JeWaTXB+R8uTYNJaZs+R9m8nkgU2CP8SFpOmSaPRKlDc/a
         E/o9jH/wV8FNp/qmcJCSWY4v5ERC7OO/k6t6TE13TMnuGHJLp0PmgSjkg6R4hjZDoXb0
         aNHsZdr1tWOgfCuXjAoc0i9t8kP/0DPCcI/7AtLKN9m5y59wXFtDvuQEMcVMxaQb7oEX
         S2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nfiV4Gp/MeGPk1x4dhku6y5413OI/XmmoTE8c0+bWg0=;
        b=d2iZXR+DzxicxsE/dI2FTzWjWP6SvPw5zO7PaF3Qdsp/nQAO3SXBneDFnod3ZyJPaO
         7TTnX4vDc0EKkYgt/28Ra/5RN7gLniTMT+2oo6eOE1YrusrH9BvDgxD/0b3Y+VBHegh4
         c9FS9WJ26hfrzuX5QZl53P0IW+dxQppD3efqE3zjZJn+MeJz5aFwTevSmnlyNEuF56H0
         Qr0OBMORnc/ATxWdJchxnZnnk4km7jbXePxEQHOzi/Lm6ViSroBF+006mSMYan793VW+
         pbitabyg7Gt1+9+IRWwpeAK7s7v3dTOXzxJzzm2XsweZ8ZWRTVZWm9gtS/IXEDrDjgL6
         FBeA==
X-Gm-Message-State: AIkVDXJvuq0uVKH6Pp4KOAAz2LmB3KauiEEe8OylO/ivWyOfK9/cdcyZ/nD4TMDb2nt8jLd5Bk0uWMUHhOF5iw==
X-Received: by 10.36.159.3 with SMTP id c3mr2255603ite.50.1483781725483; Sat,
 07 Jan 2017 01:35:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 7 Jan 2017 01:34:54 -0800 (PST)
In-Reply-To: <CACsJy8B0UT4_CF=qu081ep6nzdBXxnnNbma-wCYeajAuXaKg5w@mail.gmail.com>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <CAGZ79ka-FXfFN8ZqE6+v06o3nKa7ad0iWttn99Y2wf5m6wfs8A@mail.gmail.com> <CACsJy8B0UT4_CF=qu081ep6nzdBXxnnNbma-wCYeajAuXaKg5w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 7 Jan 2017 16:34:54 +0700
Message-ID: <CACsJy8ALXkkEnQPvpMx4nrPjD=fpGNDkbC_oqMrj3KRdRr_-eQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 4, 2017 at 8:25 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 4, 2017 at 2:45 AM, Stefan Beller <sbeller@google.com> wrote:
>>> In this implementation, the gettext call for the header and the body are done
>>> in different places (error function vs. caller) but this call pattern seems to
>>> be the easiest variant for the caller, because the message body has to be marked
>>> for localisation in any case, and N_() requires more letters than _(), an extra
>>> argument to die() etc. even more than the extra "_" in the function name.
>>
>> I see. We have to markup the strings to be translatable such that the .po files
>> are complete. It would be really handy if there was a way to say "anything that
>> is fed to this function (die_) needs to be marked for translation.
>>
>> Looking through
>> https://www.gnu.org/software/gettext/manual/html_node/xgettext-Invocation.html
>> such a thing doesn't seem to exist.
>
> I think --keyword is exactly for that purpose: marking more text for
> translations besides standard markers like _() or N_(). Yes we need to
> call gettext() explicitly in die_() later on. We already do that for
> parse-options. We just need to N_() the strings, without actually
> spelling it out.
>
>>
>> So in that case die_(_(...)) seems to be the easiest way forward.
>
> I still prefer changing the die_routine though since die() in many
> cases could be used in both plumbing and porcelain contexts. And we
> have tried to keep plumbing output (and behavior) as stable as
> possible. The approach has some similarity to unpack_trees() which
> shares the same porcelain/plumbing problem.

On the other hand, making die(), not die_(), translatable means the
translators will have to translate them _all_ even if only some will
end up being displayed. That's 2000+ strings according to git-grep.
And some of them, like die("BUG:..") should definitely not be
translated. So +1 to die_(), unless we decide all strings are safe to
translate.
-- 
Duy
