Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AE920798
	for <e@80x24.org>; Wed,  4 Jan 2017 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030404AbdADN0H (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 08:26:07 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35445 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030284AbdADNZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 08:25:56 -0500
Received: by mail-io0-f196.google.com with SMTP id f73so59729685ioe.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 05:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=22en2SVTsRAZo3jDx2iiL9wNftVclm5HlKT2ACRmo7A=;
        b=ARS1LkAQUTf6/IYnterV4stgGISCJOtxs7E95AmOuXltItdjCnMHu6TEuzIiRpeMgF
         deJ6H47JjLuvD/3aYbj/wvRMZ1kl7IvStWZMDup4BucmJpnncH6SEN70SIsZWDv2T9J/
         S+VOlDtPCrv5ArQpKFL6KvzYYCLvx5kS3+WVLsTTfiqMfbHD+IKhbTI4SCrULTpB16MD
         4CwU2Wx2lUlsBsYI+30M5ed6UPwIFiiYht8fUOrFWvkfGJ90BxRsU/C7KoJFGjwGSVo6
         Zm9V5ldBulqgSL9GhECFLEnJOuKGgs14a/HT/TR9lmBXNzWv7cq48EZBE0TcOUWwrwFz
         tddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=22en2SVTsRAZo3jDx2iiL9wNftVclm5HlKT2ACRmo7A=;
        b=NMjspyo3Tz7YG79V92rMzAxPeQGoF+1Cc8GlD0EwNADIJ9gII0IAUiUllXM+rTmnT6
         KRLtp6UNA/FdKXrlbg2jNakENjjzM6y+n6wKXmr5+7myRPMEDDWo18Bw1K+UeWD3K9/6
         0CBxn26fSYl2wjrMowjRIxb5ZPFwYcW143sZkDkA5vjCLrrjY1BnnVnsYqx+edEljr66
         FqzkTN0p/6CUN3/rIk3UOi8fWaLvGD0pCCBnExsfVVvMMszHmMToD5VNbza/B27XcZ3c
         MiB76QJ/Q/DN5S7Ote+Hf92OK2xXCiPiydYW1tvAeyh6Av8tkILw4EuOrrAAen6s39W5
         +38A==
X-Gm-Message-State: AIkVDXLmcly8AeRIaxQHH5rfdQ6Ni3bkBTM+bV3W3PpQFnfyozpNNkc6yY9o7RIRMqYyS9JnqXbTp9uFGt23NA==
X-Received: by 10.107.44.137 with SMTP id s131mr49528520ios.212.1483536355872;
 Wed, 04 Jan 2017 05:25:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 4 Jan 2017 05:25:25 -0800 (PST)
In-Reply-To: <CAGZ79ka-FXfFN8ZqE6+v06o3nKa7ad0iWttn99Y2wf5m6wfs8A@mail.gmail.com>
References: <cover.1483354746.git.git@drmicha.warpmail.net> <CAGZ79ka-FXfFN8ZqE6+v06o3nKa7ad0iWttn99Y2wf5m6wfs8A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 4 Jan 2017 20:25:25 +0700
Message-ID: <CACsJy8B0UT4_CF=qu081ep6nzdBXxnnNbma-wCYeajAuXaKg5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 4, 2017 at 2:45 AM, Stefan Beller <sbeller@google.com> wrote:
>> In this implementation, the gettext call for the header and the body are done
>> in different places (error function vs. caller) but this call pattern seems to
>> be the easiest variant for the caller, because the message body has to be marked
>> for localisation in any case, and N_() requires more letters than _(), an extra
>> argument to die() etc. even more than the extra "_" in the function name.
>
> I see. We have to markup the strings to be translatable such that the .po files
> are complete. It would be really handy if there was a way to say "anything that
> is fed to this function (die_) needs to be marked for translation.
>
> Looking through
> https://www.gnu.org/software/gettext/manual/html_node/xgettext-Invocation.html
> such a thing doesn't seem to exist.

I think --keyword is exactly for that purpose: marking more text for
translations besides standard markers like _() or N_(). Yes we need to
call gettext() explicitly in die_() later on. We already do that for
parse-options. We just need to N_() the strings, without actually
spelling it out.

>
> So in that case die_(_(...)) seems to be the easiest way forward.

I still prefer changing the die_routine though since die() in many
cases could be used in both plumbing and porcelain contexts. And we
have tried to keep plumbing output (and behavior) as stable as
possible. The approach has some similarity to unpack_trees() which
shares the same porcelain/plumbing problem.
-- 
Duy
