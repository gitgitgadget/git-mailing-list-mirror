Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DCC1F42D
	for <e@80x24.org>; Sun, 27 May 2018 04:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbeE0EQH (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 00:16:07 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46546 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeE0EQF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 00:16:05 -0400
Received: by mail-ot0-f196.google.com with SMTP id t1-v6so10198535ott.13
        for <git@vger.kernel.org>; Sat, 26 May 2018 21:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OgET+SIShc9ftBVsoMRUwkoKIDNitinQwWfMWztUFgs=;
        b=OMJnirYaAcV7Rh8SAjoM62JdcD6AvRA9dYkWIzx/ppkg4CDVBaxXlFwADdsJZ+c3GD
         ef2oG4+XeTVVPqutq4QEwoxOm0oFCbhL3MsMZPpYin3f4DL2/KmuyWM5wXKk7tveuoNh
         SimZeTKIhDgSNJKWcn6ZMe3A0rfbTFRhcJQe/z3ebFaBJxxXifol8Q9fpTeqczXWoBk4
         Olt4Otqws7Fwg+DvfPsc43/SKo3/E4+lvxaSvDZ6CzetwvMoFzMJcqEwp8IK6+ClmmFp
         lRK2bm5VZo+FwWyU8EdA/8R0EJlwzxVozSnvU5QqN3F3JIVJuu3hMRwtVlze+F0i8Uaj
         VoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OgET+SIShc9ftBVsoMRUwkoKIDNitinQwWfMWztUFgs=;
        b=O6uCfs+tAGmi4Jq1GaxcsyiIYboVmaRsV1x1m2UuXCr+UtFocXOe2bNTcU7k2Gp4br
         5S+rmN4GpvvFQ4xzTmUYbMZOjcNUW0J5FuEjCiPN82JGpH4cf79BwE1dybgI/j0x4O2V
         Qt3PiecEqi3jvhN4AcKJ5C09e59uQiTzxpoNS56wWbExMYwnRz+Fn2WqTXD0XtIX1B7P
         fOn18ioLHYEeZ6SZbqzk6tytOd7EwDFF8dsqfCofaUAB+H7JsYhKSiZwq4d/jlcXipNl
         nBoLkEJzBjWGR2CtELiqaQfVjXtLbWEWKU4JfzUtd2XaMtHXT+bzT/OL8ha1CgmtHxnF
         eGnA==
X-Gm-Message-State: ALKqPwfkwZSCeKk2gnr+itfkl4AyJrWbuWL1zXV3iAJofNc4+IflMU1y
        FLolkYPUJE3Fwrw/99pk5HsqfUH1
X-Google-Smtp-Source: ADUXVKI1CoiSxRDuj4s6iRmBQNG4Hb8Hs0Ww30xtADZbBxb5Lxz/x3NwbQVNM1yvfu1S9GQaHdPloQ==
X-Received: by 2002:a9d:2628:: with SMTP id a37-v6mr5739775otb.377.1527394565025;
        Sat, 26 May 2018 21:16:05 -0700 (PDT)
Received: from [172.16.100.100] (cpe-70-113-92-26.austin.res.rr.com. [70.113.92.26])
        by smtp.gmail.com with ESMTPSA id c21-v6sm16118169oih.27.2018.05.26.21.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 21:16:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: 2.17.0 Regression When Adding Patches Without Whitespace In
 Initial Column
From:   Jeff Felchner <jfelchner1@gmail.com>
In-Reply-To: <20180526210752.GA3094@zaya.teonanacatl.net>
Date:   Sat, 26 May 2018 23:16:01 -0500
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8B7F3D0-E0C3-4E11-92EC-567BEDF19037@gmail.com>
References: <C6CF9BE4-FC46-4B39-A862-AEBB5CD600E2@gmail.com>
 <20180526210752.GA3094@zaya.teonanacatl.net>
To:     Todd Zullinger <tmz@pobox.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd, it looks like that may very well be the same issue.  And it looks =
like it's planning on being fixed in the next release?  Would that be =
2.17.1 since it's a regression?

> On 2018 May 26, at 16:07, Todd Zullinger <tmz@pobox.com> wrote:
>=20
> Hi Jeff,
>=20
> Jeff Felchner wrote:
>> Ever since 2.17.0, when saving a patch (using add --patch
>> but probably other ways as well), if the whitespace is
>> removed from the initial column, the patch doesn't apply.
>=20
> This sounds a bit like the issue discussed in this thread a
> few weeks ago:
>=20
> =
https://public-inbox.org/git/e8aedc6b-5b3e-cfb2-be9d-971bfd9adde8@talktalk=
.net/
>=20
> But I didn't download or watch the video, so I'm not positive.
>=20
>> Full walkthrough (including comparison with 2.16.3) in the
>> video attached to this link:
>>=20
>> =
https://www.dropbox.com/s/s1ophi4mwmf9ogv/git-add-patch-whitespace-bug.mp4=
?dl=3D1
>=20
> --=20
> Todd
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Everybody knows how to raise children, except the people who have
> them.
>    -- P.J. O'Rourke
>=20

