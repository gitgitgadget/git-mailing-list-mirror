Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7FC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348561AbiDZPq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiDZPq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:46:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3A74DCF
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650987816;
        bh=yoIRe+4u+bIvYVrgD3rDKbLfo1rlDsjVBMCB7Rh+gdE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MT7i+6fqsFEX6+/v15Lg3FWu5fx3qHJrrD8BHXBw4ZOobN2EhHhlhQLhb+gxr9dkm
         fLbZPFPsW9HBShvP6JRFbS3/CGlvZ6uqW4ScghZnfcVvOVPHQY8LfyD1TfLnFsH2De
         C3sE+fIpZWdmJXxvpMZZ71PyvKrMdC0QUkbMx+kE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([89.1.215.71]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1oHtkj05IT-00d1KG; Tue, 26
 Apr 2022 17:43:36 +0200
Date:   Tue, 26 Apr 2022 17:43:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
In-Reply-To: <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan>
Message-ID: <nycvar.QRO.7.76.6.2204261742120.355@tvgsbejvaqbjf.bet>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de> <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g> <xmqqk0bf1i12.fsf@gitster.g> <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan> <xmqqy1zty8dc.fsf@gitster.g>
 <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan> <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1895126993-1650987816=:355"
X-Provags-ID: V03:K1:QSqthL8gV6vT1+BPFuYDjXfTuPjEEEqQJ7pcB4OaIhWz6MpSsFX
 T2/sS+/6LR0DYso2mA4Xg7lYnRWsZSj4WhA/Q6hNsF6vrLqNysO3dfBkFI9fhdeEYDtyJ//
 YmzHHoBwaIp6clQ+9UwMMe9OA7r6HieqSdSDAhAtuXYCP47mFtT7gsYXFHRau81ZzSST5SZ
 JRqugLbyYLcYxOnPwi0nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yrw7u17OV3A=:PiPMUUfdh8RdHbniIW/dp/
 6ubmA+GYu32mA0kprHATeRN/vGJ/mZfxeRg1xBzJq6YGihzPRxFoLUh9KODvk/deYFzG5W8CZ
 VKOrfuOuDDf54EsQNfLYrLxKFVLA1cxd0s4JuISJc3T075htT222hcrplD1061iYMM7haTPsV
 RB8125I3uq44GRg3gt6ok/wJ8P0j6IAEqKZQx6Vl+EulucjltCZqmKUqqOE0iyxHQiW9GB7VK
 EfLkhxyQGBvAqw+i/ElowdxSOLmDlt+JmZol/qv54LaBzwW6PQbLKHx+mzrvxO0GX6eB8KnL5
 fppH9g7X37cirsQXavhwMTpYEMUYga95BcTZzj0Md0gfVY4nX3ipH/uqO4jXksqucgST4Y4nj
 SA4oocBiAnDSqGUFb/UQY5q1xhivhUTPpH2tdI7hXftf6daRJDy+r5j6luKZZW5kmyHSTWQxB
 OvzVsCuBirZfE0CWSMdnBGlIhxVUa1EMVnYtj3XaCIfnkUuZ6wAPoop2NfFHRoYPIgl4Xi2O5
 GREjwtLhggteH/ePdjbZkpBmqTdo1st4hjnOsZiQ/8+6PprMftYeA6j9DBWi3uyZ4FeWcN7x7
 YniUlfbjZGzs0sxkrIiGlm/ocZmpJdsPA/+UkzIbE36QNe6ffHGjuIQzKfEYu49t3rjrHxKFK
 /yfinB2on7gwy789ff6Y9M1Rp37FxIVqk8QqBstdcoOzrwnOEwk0gVL4OcYUESqh1Ib5cdtRD
 WXrFvt5r7t48HaQsLRn3J00DTCyyMiKoFtNg0EmBuJwR66kLYvOqfJy63BKvvi+KKXeTg4ICN
 ZCHQ9O2YbFTNppidUFUrRr4kfgsbWjarAiLXOqKAsyJXowP7jNUAPTcmVGC0AtnBqNqAlMYSs
 DH7pInWAO3Yv3ypExh5SDRyH4knnUCDjuE9NaOIbIHhQ3Acq7tBCEbIs/8Z6ANk5nm8M4mDud
 KEygMRNqlCcFPJEemleBM/uoQio/DM2jvf8WeYiEiQlKkP6R9HohwXV3Hxo7GzMNLrPi0BkTt
 QBCOKAb/PlebxlCoki648ji4Wx6LIw4svS2dqgYmAnVUjeGjTDDJXtVZBukGlL555JkO/X6nG
 y+bj3HCh3AzWFY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1895126993-1650987816=:355
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 25 Apr 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Mon, Apr 25, 2022 at 12:02:45AM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
> > On Sun, Apr 24, 2022 at 11:39:27PM -0700, Junio C Hamano wrote:
> > > Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
> > >
> > > > At that point, though you might as well excempt root from this che=
ck
> > >
> > > But "root" or any higher-valued account is what needs this kind of
> > > protection the most, no?
> >
> > correct, and I didn't meant to excempt root from the protection, but
> > from the check that requires that the config file ownership matches.
> >
> > if the config file is owned by root, we already lost, regardless of wh=
at
> > uid git is running as.
>
> apologies for my confusing english, hopefully this C is clearer
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58fd813bd01..6a385be7d1d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -440,9 +440,19 @@ static inline int git_offset_1st_component(const ch=
ar *path)
>  static inline int is_path_owned_by_current_uid(const char *path)
>  {
>  	struct stat st;
> +	uid_t euid;
> +
>  	if (lstat(path, &st))
>  		return 0;
> -	return st.st_uid =3D=3D geteuid();
> +
> +	euid =3D geteuid();
> +	if (!euid && st.st_uid && isatty(0)) {
> +		struct stat ttyst;
> +		if (!stat(ttyname(0), &ttyst))
> +			euid =3D ttyst.st_uid;
> +	}
> +
> +	return st.st_uid =3D=3D euid;
>  }
>
>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
>
> it uses stdin instead not to fall in the issue that was raised by
> G=C3=A1bor, but I am affraid that it might need to check all stdnandles =
for
> a valid tty to be safe, and it looking even more complex.

Maybe a better idea for the `sudo` scenario would be to make use of
`SUDO_UID` (assuming that no adversary can gain control over the user's
environment variables)?

Ciao,
Dscho

--8323328-1895126993-1650987816=:355--
