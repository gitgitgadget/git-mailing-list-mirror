Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2B320A79
	for <e@80x24.org>; Thu,  2 Feb 2017 11:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdBBLX2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 06:23:28 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:36418 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdBBLX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 06:23:27 -0500
Received: by mail-ot0-f169.google.com with SMTP id 32so9371581oth.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 03:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TrWyZWYi0F6eCfTdMV6DH9DeSJ3qubsKH3oH/88ilTY=;
        b=bVDYv6+1IHUzPnn8Ew+OfV5dzIOSHksEBW8MkG7Vs+7OTZZj+OSvxticu7YTAuXL6Z
         t/nksPxx54O7FzEqrwNzBq7N1CEeI/xy6CNMy27oDUeNReiCcV00oV020cBpKySaQWea
         ZNi4EGo47ULB8Bp3imcs3L83BavXHgArWhAJ4vDJJQ9dUAsYWvEpxl+DvypEN6HikDHV
         uHHQabdeXIhZ4c9FEUn1H4zriW39bjs38AAgSrhmWT6tznbgWV3hkN4ZNM44JNMF0Rhx
         E7og4SARu3HbKJd0wllTc8FU8a5p56ixFCzDBA2+IPYYh0TjIQSMFp07oFtctYZ1UQfp
         BebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TrWyZWYi0F6eCfTdMV6DH9DeSJ3qubsKH3oH/88ilTY=;
        b=n/qsPwxX9yfksVK7gXNjxr0AvEMVDeGDsNsPOt55Yixix7Ts1NLfYnN7CIex2C/Q0+
         kWVlt7zrDVL2obI2L4b5QYJBmTzpOq8q7BXPugbFJPKjpGTS/Nvrx01T//JYgLrh0qEE
         StCGBAoeckcKbEyup4xI9wWYxgVjtEikRo7mhuRsVS92/lMFGw9hyQZrHTS38DlxCFK9
         1P7pBM9c/x3yrVXGhy+LvQ2xLoR6RYtHPgDOTXwKC9ztp8aBxQtrzF16pJ6M0AsjPPyr
         qpKdsuGqhJNu2yeoRFZ4RFjdHPkoYjWrabQcMlCk08qVY7miM7t+C3b1GKnprkPdagu+
         6xTQ==
X-Gm-Message-State: AMke39kRNampIHI2/OTCKU0EWl3FQ+ix6+d6NgmkJ9dloaMC36M/VQ+oOJa+shVcWOIwbH6B5UFbeF5/ujoqpg==
X-Received: by 10.157.20.146 with SMTP id d18mr3628297ote.37.1486034601512;
 Thu, 02 Feb 2017 03:23:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 2 Feb 2017 03:22:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1702021136210.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox>
 <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
 <alpine.DEB.2.20.1702021043110.3496@virtualbox> <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
 <alpine.DEB.2.20.1702021136210.3496@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Feb 2017 18:22:50 +0700
Message-ID: <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 5:37 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 2 Feb 2017, Duy Nguyen wrote:
>
>> On Thu, Feb 2, 2017 at 4:43 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Thu, 2 Feb 2017, Duy Nguyen wrote:
>> >
>> >> On Thu, Feb 2, 2017 at 4:16 PM, Johannes Schindelin
>> >> <Johannes.Schindelin@gmx.de> wrote:
>> >> >
>> >> > On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>> >> >
>> >> >> This squashes two changes from Johannes and Ramsay: [...]
>> >> >
>> >> > Sorry, I lost track of the worktree discussions... Could you remind
>> >> > me which patch is supposed to fix my continuous reflog corruption?
>> >>
>> >> The corruption caused by git-gc? It's not fixed. All the changes in
>> >> this series is shown here.
>> >
>> > Oh sorry, I meant to ask "and if it is not in this patch series, would=
 you
>> > mind pointing me at the patch series that has that fix?"
>>
>> You meant this one [1]? There is nothing substantial since then.
>>
>> [1] https://public-inbox.org/git/%3C20160601104519.16563-1-pclouds@gmail=
.com%3E/
>
> I guess I mean that.
>
> Given that this results in real data loss, it is surprising that this has
> not made it even into `pu` yet!

I  could rebase and clean it up a bit if you need it, but I don't
think it'll end up in 'pu' or anywhere near since Junio wanted a
cleaner approach [1]. That means (as far as I can see) a lot more work
around refs store and backend area before it's ready to handle "get
refs from this worktree store" (or "get refs from every reachable
stores").

[1] https://public-inbox.org/git/xmqqshwwzyee.fsf@gitster.mtv.corp.google.c=
om/

--=20
Duy
