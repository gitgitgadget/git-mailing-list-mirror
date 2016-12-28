Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D4720441
	for <e@80x24.org>; Wed, 28 Dec 2016 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbcL1TA4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 14:00:56 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:32864 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbcL1TAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 14:00:55 -0500
Received: by mail-yw0-f178.google.com with SMTP id r204so193245091ywb.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 11:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fveCdwqJ0O0TFy4d9xf3c0zs/dL0Abcejg7ldhv3AmI=;
        b=CsPsRFZbhk+zr58SHV3zgNpBzcThhtXvDflHOZULKxCZL2lfNna49bAITj3toa7BBC
         i2nUajo5rbx2WeI210VrHWDDAaZNCT9Cpkv7Ey6enlo9motS2vPf9EkKTyITCnWAXgB2
         6vjHAOzspEhLe+shgQ5XSmH11X7Mm5/bQv3flreqAmbhREkW2oigWsdcVqsi20AT8IoQ
         vZhUk4E9hoy54AUAjvHXvEKyxpQunkUzJNvCOcN7wo7DgJ4F1aMRNUfSloyrR6hEZbue
         EPwIkpDyOGQHJIo59hu3djH5soYizjmo4n1DBetzpI1uoKK591DWm4vrB0KZr+WFGR+Y
         cROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fveCdwqJ0O0TFy4d9xf3c0zs/dL0Abcejg7ldhv3AmI=;
        b=okY3z64p0YXk/SMSf1ZU72wgueho3xXtTG79CeOgON5bD+50fBckleTyDVj0yye8KZ
         ZZT8FjH+X/+uim8BSgCiWDA3vntEBHBl7mYJ5XgzBlamBVa+tNSBTDQL0Ajo+8S+03zP
         oiPTspseykFtquFb6BbnPvoBH6eQZwxvU1dzHPTYo4M49lyht5NYEmwbk9xXdqs3QhgF
         n4bW1olgzg2UL/yE8FyFUkTChjpqyRT3sxTHGJ0R/tF/DUJAXoiG+H10cND9sx2rguBL
         Pl3p+irv+xEf0TVfRk/fMpE95VCRUH7Ui2e6BBHmGbNkgVjlzdF86iCaZjUOuYMTnPLQ
         80Tw==
X-Gm-Message-State: AIkVDXIRYqDYSg1k+BJH1RTBX+xDqiiVOMbQWzB95307KC3AKP0tqN9SKUtzxANZuDGwVIdQKkeDwkIbS4apQg==
X-Received: by 10.129.163.69 with SMTP id a66mr33785230ywh.175.1482951239984;
 Wed, 28 Dec 2016 10:53:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Wed, 28 Dec 2016 10:53:39 -0800 (PST)
In-Reply-To: <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
 <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com> <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 28 Dec 2016 10:53:39 -0800
Message-ID: <CA+P7+xoBpAV1hiZQ0WZHP-kbB9zhddMhtj_CZ1Wejdur3oPXhQ@mail.gmail.com>
Subject: Re: HowTo distribute a hook with the reposity.
To:     Jeff King <peff@peff.net>
Cc:     "John P. Hartmann" <jphartmann@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 10:08 PM, Jeff King <peff@peff.net> wrote:
>
>        https://github.com/Autodesk/enterprise-config-for-git
>
>      (with the disclaimer that I've never used it myself, so I have no
>      idea how good it is).
>
> I think you probably know all that, Jake, but I am laying it out for the
> benefit of the OP and the list. :)
>

Heh, well I didn't know about this last part so it's still useful to
me! I knew of the larger description for why not but wasn't exactly
clear how to word it so I am glad you filled that in. Thanks!

Regards,
Jake

> -Peff
