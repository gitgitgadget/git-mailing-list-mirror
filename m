Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6AD20193
	for <e@80x24.org>; Thu, 27 Oct 2016 23:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942655AbcJ0XJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:09:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32859 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933978AbcJ0XJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:09:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id i127so211817oia.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Nvg/vltQWmE0kw9zzN7zS1IpxumR+o2bNTkx+jtSSZo=;
        b=QJb0hTykvhlvmzcYYhuX+gHYlkNN2ZmzMTZkQ7YUgoIXhN+sgK+w8uNJcJ00nKOrZ6
         aCzK5AgOhzkhF6tBY6Yh+JTesAJr8SFGfePDb7yQA5f01244vzHBobkYswU2xiCYSOtd
         pqCRoc6CLzYlT9kw+pwKhhP275er8RMSFsnrBrBLzqot7hxloX/xZYVpKoPYebTEs/Sc
         YBvvCkN4wYF9JJ/HWjns7mOqAwuUVoiPp7K7i3hPdEnvMkVk89r4MKn+ovq285tbysPE
         KL8D9BNwvBGZWfTdoWmlIOmvM+94g4vAq1k+c9c66XPp6uvcnF3giNMKomdypikbrjCn
         8XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Nvg/vltQWmE0kw9zzN7zS1IpxumR+o2bNTkx+jtSSZo=;
        b=W0Xr+Ym+Fubg2mlIK4/cbgC+60C5IObnTlam7u4Sh5U+fTFz6jbkfljvLAE5M2y0Yb
         E3kvrzAnsDduUX+D6qZmX0OoYHJQcMvdfwO0A2Y/zs4I/8bsXL2KICNZzvc6RRiZkW2c
         3jQEHfEpkBl/+y9sSx1ptd615mayS8pUe7xac0ma0xBs9bhMeHV/BO3nuwdGc3CgY4Ed
         9CVCmVd8iKSDbdbQo95UXInaawJUKhg4rWuv4i6PH0gmz1KQ3A9NyJmqAQmBUE9xJY9I
         93Nj8fZYr+5xdqq0rsdDXPWkirgzVg0KZ0GzzVc+PmzRV6PofxrJe82NZsSrol2/C66m
         6rYg==
X-Gm-Message-State: ABUngveYNRjWKcLCaLlsO+8l3LI/VaO/cY62Rb9LRIK5KZJS9c+0f+As4MyMm/hEMVEuutcNPPFbhpT5Zhi6rg==
X-Received: by 10.157.39.2 with SMTP id r2mr8505190ota.103.1477609780480; Thu,
 27 Oct 2016 16:09:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Thu, 27 Oct 2016 16:09:39 -0700 (PDT)
In-Reply-To: <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2016 16:09:39 -0700
X-Google-Sender-Auth: QhE8t3FmkRpFhWN6Asw6UmYbYvE
Message-ID: <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I also thought O_NOATIME shouldn't be an effective fcntl(2) thing,
> for the reasons you stated above, when I was studying the area
> because of the discussion on these patches.  I was surprised to see
> that http://man7.org/linux/man-pages/man2/fcntl.2.html contradicts
> by saying F_SETFL can take O_NOATIME.
>
> Perhaps it deserves a bugreport?

It's not a bug per se.

You can indeed change O_NOATIME with F_SETFL. And it actually does
matter, since atime is normally changed by mmap(), read() and write()
calls.

So F_SETFL O_NOATIME actually does make sense, but it doesn't cover
the atime update done by open() itself.

That said, now that I think about it, I should double-check: maybe
open() doesn't actually set atime at all, and we *could* do NOATIME
with SETFL after all.

The exact [acm]time semantics are damn subtle.

             Linus
