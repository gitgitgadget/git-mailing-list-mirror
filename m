Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C491DC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 09:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiAXJSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:18:47 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:56840 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAXJSq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 04:18:46 -0500
Date:   Mon, 24 Jan 2022 09:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643015923;
        bh=o7GbTTNTnLiSQWVrNWLsKHvutLv5dxTF19UGCAG9BDw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=OYzXlc6z1mALyXPDZuyWySkaWyAYq+ktEdAeLQXDbzWW2CBZh4e9D2Wf9j/iO+S6E
         qRxiTlwsj1Aq7QAeJ7geAbhdeVFqRVXPC49OdqvtIRYZR9YFo8OoLftPByhZ/aBA7E
         MEBFZQRjkpwttBok6p9E25MXDHEeJGP2J760EfxRJ5t38V9EujOy0rCmEvjnWkbMXY
         F0Yv0eVqTvUXTrHnwr3sEh7F5eir9usPOBTDJkw0It3seOOCHgK2WmWuqa+xpwVvZR
         7iao/DVpDw7DfYGDZAqOJDQBrV3ePdSF6Cdrz4+Hqbxur86NOfvCHHB2JQcLw86iqk
         tdaDfBVdluBsQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Git List <git@vger.kernel.org>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Some sub-commands can't be completed by TAB key.
Message-ID: <Odvn8_XIojrgpHG7xMtrBXdhoxr20X_fFRYoDtvkUKb1FOd-13j_l40TBAc1hn7rSddJ-YrQak8AuetNQ9LkeVeVoS3RTlIeSQ9znqyMApc=@protonmail.com>
In-Reply-To: <xmqqpmoi9qna.fsf@gitster.g>
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com> <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org> <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com> <5a30ac1f-d414-0976-cd08-7b059117af41@gmail.com> <xmqqpmoi9qna.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is also worth noting that completion will also include whatever
> alias.  I get "lg" in the mix because I have...

That sounds like something that should be hidden, no?
Like, all aliases are left unmentioned?
