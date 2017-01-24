Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25932092F
	for <e@80x24.org>; Tue, 24 Jan 2017 11:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbdAXLoC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 06:44:02 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:36679 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdAXLoB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 06:44:01 -0500
Received: by mail-it0-f52.google.com with SMTP id c7so83657343itd.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0TdcCzWhGpzGn+Fu1mUqVd/tvQXyygCqtgDSx9i+I7s=;
        b=uZiDzRGVkKwMgpY4eH3Yw/ghW7h3o4kmXdRBrZg9wduBBZu5x65qHIgC1VmMuALur3
         keNbyADEK0X2MO4AQcYdIcEc+GUhOKWdLtx2cTCoAEWzzHCblWAtk1+MFzkhk2HJTXKR
         ujCrNw2a6+/YUFE2jvUeymqmc1Ez50gDiZR0goE3EYW8ELn80L0D69fl7nfY1GFDXagl
         U6ATXJqrKCCO47x6SulEGvVlYbyyz/y+kLq+wq4VE3XDfpAENq5f2mFFl8OiDJSICZz3
         goYsZazyoZE+qvxQNs/YBF14ETlARrRyc0LqpPryWZwpJXFAOppAhJeY+8rn3PHgGfD2
         KjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0TdcCzWhGpzGn+Fu1mUqVd/tvQXyygCqtgDSx9i+I7s=;
        b=hdcuf0icI+PI9peEbJYWOJyuz3LNBNwH9mBVqRMADrMeKpu/O9KveoWX5HmW3aEnJB
         nOtb5j8koAEi2T3uVqKVSabOWZ/sSd7YQACzXNC9d5QZov+FlwwN6RtxdBSMxTcG8Pw1
         lIqImeRm1slAErxe1WWsv5n+RbNFCJTh61J/r75hOCrtUBzrV6zwFIOctd8dnYbdLjjN
         uwJpHTZ/BuZoRe36xcqMSdpkuzt/dq2ZmnUtqL3wj8M+eGUma9Cy0pUTflWHxxcJuxc0
         +BJormiMZI6wgdg8RPZuwQ205fmRm+ePIAfb223i0SOYAUDgmQ2blSor9y9mRU/Nts/N
         IyUQ==
X-Gm-Message-State: AIkVDXKpOL+fjvZLr0ADjvwJonEeYvIWA4+5+zbXZr85WzN4wlsFkzPiUqtKFA9p+BaAzYJR+d21LvOKEQm2Bg==
X-Received: by 10.36.245.5 with SMTP id k5mr19684376ith.100.1485257819075;
 Tue, 24 Jan 2017 03:36:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Tue, 24 Jan 2017 03:36:58 -0800 (PST)
In-Reply-To: <xmqqr33tsjwx.fsf@gitster.mtv.corp.google.com>
References: <20170122212855.25924-1-eantoranz@gmail.com> <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
 <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com> <CAOc6etY5odte=TKyWX3Wf1BVaNTfDeA-xsGOKiyuH88HZgqFDQ@mail.gmail.com>
 <xmqqlgu2u0qx.fsf@gitster.mtv.corp.google.com> <CAFZEwPPx2vDJVf=uk0iUJ2sh9DxWwp2Lp1k-APz9n=7NYMN5uQ@mail.gmail.com>
 <xmqqr33tsjwx.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 24 Jan 2017 17:06:58 +0530
Message-ID: <CAFZEwPNGzFhocgXwKA3UjXQdwBmWTCsvSdy47Y+qFfZ6JJpJ4A@mail.gmail.com>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Tue, Jan 24, 2017 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> We can probably make it useful with some extended efforts. I use
>> git-blame and I sometimes find that I don't need things like the name
>> of the author, time, timezone and not even the file name and I have to
>> use a bigger terminal. If we could somehow remove those fields then
>> maybe this would be a useful feature.
>
> I admit that I didn't recall the option until somebody else told me,
> but I think "blame -s" or something like that for that purpose ;-)

Ah! Thanks a lot!

Regards,
Pranit Bauva
