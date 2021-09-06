Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC2C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5846C60F14
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbhIFBpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:45:42 -0400
Received: from mail.archlinux.org ([95.216.189.61]:33270 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbhIFBpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 21:45:40 -0400
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1630892675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e41Qfy9/arYb891G45GwG2pdV0V7rCKIjzSJnG9lE/M=;
        b=uia7+jyuSR+8Bkqy/c+AvHeaVslgVf7MV24pVGD2CQunQg9NGJAmUtqeqdrnwheWdMZHRp
        ywFVrEtJ8LBzgQ92ug4ggYLOeKXsW4/EFq64/c2bDHijBD7YaStC1QSjYZwIUaq2qF2GTG
        11QryDLhvjnLROZ2+3xVQNl0+UoMlzctgke/oLRfKyq7Xrv8XlHL3mc8q7KoqwBbE6dQih
        33JaxCqC0JGH6YcZzZjVeOb/X00JqIpnoi+/yJfGLFJnEuZ0O2dozsWhdTJ78Er2iU0fqR
        czTsZWhR2+4FKdKkZGLCCArHtFBIO+cqsUNr6Mmb5Gr8rrwupCq/JDICstX3Q5ckP4wi5j
        80NuNCkcXrCfktR8tdZKsovellto/GtB/ZDRhz5fczAiSkPMTzg/M95ZkdIRw2Gm+n4gw6
        Wsdo3q5oJbypB1y+m0qc5E4WWVely2SYzI/JOImF7zW9s9rPv7jjwdC1A4D/ze8SShaVMM
        vSlBNzIjOldcWWXPsqukbSUy7L8D+EyuRXzkv0AGtswUaP0YuCEbJLQZan/NKhRSPaLOYp
        enz0VnAxfYXzG51p/lVrY9X6I3/kkd2fL4+7hNG7KYXmKYBahg0ZgMRG77NyZ3kbtsvKS3
        s5H9hQwBncmxhqvMy3HojUtpzaR88NOst+3vAaxpISpXVGkZkfoCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1630892675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e41Qfy9/arYb891G45GwG2pdV0V7rCKIjzSJnG9lE/M=;
        b=nZOJrxsvHY/HOuzdVSwhM4XQ7i8SXPROGvz8ZK5x/upkXqgV8qz0PZ98TCFP8cTkvPG95A
        hUo/FTJyqKWf6nBQ==
Cc:     git@vger.kernel.org
References: <e86f64ff-0395-26f7-5d5b-7df2e6e63ff4@archlinux.org>
 <87k0jupnxi.fsf@evledraar.gmail.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
Subject: Re: Regression in git send-email parsing sendemail.* config values
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org>
Date:   Sun, 5 Sep 2021 21:44:31 -0400
MIME-Version: 1.0
In-Reply-To: <87k0jupnxi.fsf@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vbEETrR4y2TwVSbewQ3ynpO9xyZagFJRb"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vbEETrR4y2TwVSbewQ3ynpO9xyZagFJRb
Content-Type: multipart/mixed; boundary="blHpQEOPx1e2QKwiW8O1O91FwRuctdzH1";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org>
Subject: Re: Regression in git send-email parsing sendemail.* config values
References: <e86f64ff-0395-26f7-5d5b-7df2e6e63ff4@archlinux.org>
 <87k0jupnxi.fsf@evledraar.gmail.com>
In-Reply-To: <87k0jupnxi.fsf@evledraar.gmail.com>

--blHpQEOPx1e2QKwiW8O1O91FwRuctdzH1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 9/5/21 8:04 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Sep 05 2021, Eli Schwartz wrote:
>=20
>> I recently noticed that git send-email was attempting to send emails
>> using the wrong email address. I have a global email configuration in
>> XDG_CONFIG_HOME, and a specific one set in the {repo}/.git/config of
>> some repos... this was trying to use the global configuration.
>>
>> `git config -l | grep ^sendemail.smtpserver=3D` reports two emails
>=20
> Don't you mean s/emails/servers/, ditto "wrong email address" should be=

> "the wrong server", right?


Considering the time of technically-it-is-day-now I wrote this email, I
suppose I should have proofread it before sending it the next day.

I'll claim some sort of self-defense in that the email username
(smtpuser) was different, in addition to the smtpserver. Yeah, that was i=
t!

(also I am used to thinking of email servers as a subcomponent of email
addresses even though this is technically not true, shhh)


>> `git config --get sendemail.smtpserver` reports only the second,
>> repo-specific one
>>
>>
>> I bisected the issue to commit c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9f=
b
>>
>>     send-email: move trivial config handling to Perl
>>
>>
>> Using this commit, git-send-email disagrees with git config --get on
>> which email to use.
>>
>> Using commit f4dc9432fd287bde9100488943baf3c6a04d90d1 immediately
>> preceding this commit, git send-email agrees with git config --get.
>=20
> That's a pretty bad bug, sorry about that. I believe that the following=

> patch should fix it (needs tests obviously). I.e. when we had N config
> keys we'd previously pick the normal "last key wins", which my
> c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9fb changed to "first wins":
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e65d969d0bb..6c7ab3d2e91 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -376,7 +376,7 @@ sub read_config {
>  			@$target =3D @values;
>  		}
>  		else {
> -			my $v =3D $known_keys->{$key}->[0];
> +			my $v =3D $known_keys->{$key}->[-1];
>  			next unless defined $v;
>  			next if $configured->{$setting}++;
>  			$$target =3D $v;
>=20



Thanks, this worked for me and fixed my problem! Feel free to add my
tested-by.


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User


--blHpQEOPx1e2QKwiW8O1O91FwRuctdzH1--

--vbEETrR4y2TwVSbewQ3ynpO9xyZagFJRb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmE1coAACgkQzrFn77Vy
K9Znxw//VbTJXGJCuIFAYn+xfuF1bGwtzPCTrmUZeKb0xkKJdMCPeUDnw01EWmNP
hXcZ0xWP/Ty+xDAK4Aiiq6tRvrkLFoXaRcyPv4WA+GW+Hu4CIf1yiWJnIRxmZ9RE
b7za1OhRZa87/Q7lH1hYKVaVuk5pQjumdu+JOHgk7fl/Itvk4f92RXli+CsYGwpj
UIjTlDTXOlQdYJGo/TPWWXHXW1pfeQW/4DNhQa8Vj1UvnH+gPDvZpxcJoe4q8bVp
ccUjK3XdCW2OmS56cVuIy3Y7ymuBC419HJtZD/lcJDC/VmPj5zlzdmrLBk+SmxMR
zACpoYuiFyqG3uIYIRr+679ioUm0D6moL02AekBT60G7czBgm01ednRi4+im0R9V
8k/U0lN93ML0s1Bkxt6nQ77duFFHVZTsN+sOLcyVBdlVlxXugMLIWXHLRN9cVcml
98xUuBLmt0h1VCo0sxCB5qRHVuqbwNxSD+CEsckA24LVFdaQNaO8wUBlmW2x6Hto
ZNN2kxXkywVCCTXFp61gibljzlBqN+JTy5hSRI02icIINx47tNbocA+uaG4UpvjJ
4uDWNo/YhgMViv0YqkhXk6LpTFSCmJHVO+2HxaTD02rR5AiJjWNp5H1ENOHnvqro
TTKe9/o8DbnTM91SSDvSDZ95aoeuRJ3PMp+7uI9VCygwRDN9AEo=
=Arf5
-----END PGP SIGNATURE-----

--vbEETrR4y2TwVSbewQ3ynpO9xyZagFJRb--
