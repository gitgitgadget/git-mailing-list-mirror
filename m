Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F53020562
	for <e@80x24.org>; Sat, 28 Oct 2017 14:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdJ1O7F (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 10:59:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:52211 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdJ1O7D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 10:59:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id j15so8532996wre.8
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vcvK0LcKtQ4jskvxnA6Urp73/HAL+5foDvhiur6uon8=;
        b=do202e84hwSmpxzF1Em6c57pC8Xll2jTWOiOHBLxtTLwMIZ7sLXND/oU8N4cCIoUDh
         Gpa69287naTcHqUMK/jPz6a+b+/pkCn9dQqFUWNO2U/B5xaODJOKqMuFpCX6GpYfLWu1
         Qf9+cl8Vg4Eu8l9rJR6JCYAJZVQtvaDXI3WxA6Qz/xxj20NQs79WClzJlkoY9QkMXGm5
         ZMMFPW/+O6ABIlfHn8H/EArYLwsUp0nreqRTgMII911MD+cSsRyy3A93pQPn5rDeh5c6
         kBcC3V/OskKoLy2JIvVfJbLDUO9/YJNiI9GtikzO9Ot4FChJx9DULQ17Rg/LBupAwW74
         95zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vcvK0LcKtQ4jskvxnA6Urp73/HAL+5foDvhiur6uon8=;
        b=reKweNoJA8vLKbD+ZTzch33JQ3D9zXNR+k4NCLJr47SS4TKrpwu60Ha+Q2nWaJw78A
         w7bX5vu2QxsWwKsIjrtxSmGMN5Rex/Dff/Ly71bjFwakcPOVMZnwnQ/YCxyRUW8tdCBD
         E09Dlgbl0Xtl/OM36jbLTN5V92lwkjIz0m2yoRMAAMBwiQr0EyzrDfL/Go19YVHhowxD
         /7psGQB26s9jpk+hSY6Pnfyyfh84Y3a16Nrt7HEJRHz5jBPLBFGN6NEHztEkLkj8vEuU
         RqDe5JF1Otv6TUJNzXLEzgSfjlxw02Hvsejyb+sFbUeNL5PfyjkGk5GO9sGpoErONKlo
         lBag==
X-Gm-Message-State: AMCzsaU2GW1XKKX8O7sIhwvo/PdhxxLie5YVb0wwyJyUoCwLheZlfmlv
        WW9ITX3Pu1+ubCGSXhQyalI=
X-Google-Smtp-Source: ABhQp+Q5iex0niAmrcDCXFDV2koAeXjuhYsORq72gR+A8t3UKlGl3CQRcNxlO6j04IlwzRDsiGxl/g==
X-Received: by 10.223.128.4 with SMTP id 4mr3505040wrk.9.1509202742472;
        Sat, 28 Oct 2017 07:59:02 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6664.dip0.t-ipconnect.de. [93.219.102.100])
        by smtp.gmail.com with ESMTPSA id p23sm18759608wrb.76.2017.10.28.07.59.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Oct 2017 07:59:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/6] t0021/rot13-filter: add packet_initialize()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 28 Oct 2017 16:59:00 +0200
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09393EDB-19A3-4244-A88F-68EDA8470898@gmail.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <20171019123030.17338-5-chriscool@tuxfamily.org> <xmqqvaj8dlyz.fsf@gitster.mtv.corp.google.com> <xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Oct 2017, at 04:57, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> It is fine to leave the original code broken at this step while we
>> purely move the lines around, and hopefully this will be corrected
>> in a later step in the series (I am responding as I read on, so I do
>> not yet know at which patch that happens in this series).
>=20
> Actually, I think you'd probably be better off if you fixed these
> broken comparisions that does (@list1 eq @list2) very early in the
> series, perhaps as [PATCH 0.8/6]. =20
>=20
> I am sure Perl experts among us on the list can come up with a
> cleaner and better implementation of compare_lists sub I am adding
> here, but in the meantime, here is what I would start with if I were
> working on this topic.
>=20

Thanks for spotting this! I had some trouble applying the patch in
this email. I got an error about "corrupt patch at line 54"

BTW: I am using this little snippet to apply patches from the mailing:

    PATCH=3D$(curl -L --silent =
https://public-inbox.org/git/xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com/=
raw);=20
    ((printf '%s' "$PATCH" | git am -3) || (git am --abort; printf '%s' =
"$PATCH" | git apply)) &&=20
    echo && echo "Patch successfully applied"

Does this look sensible to you?

I applied the patch "manually" and the result looks good to me.
The patch looks good to me, too, but I am by no means a Perl
expert.

Thanks,
Lars




> Thanks.
>=20
> t/t0021/rot13-filter.pl | 35 ++++++++++++++++++++++++++++-------
> 1 file changed, 28 insertions(+), 7 deletions(-)
>=20
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index ad685d92f8..9bf5a756af 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -107,21 +107,42 @@ sub packet_flush {
> 	STDOUT->flush();
> }
>=20
> +sub compare_lists {
> +	my ($expect, @result) =3D @_;
> +	my $ix;
> +	if (scalar @$expect !=3D scalar @result) {
> +		return undef;
> +	}
> +	for ($ix =3D 0; $ix < $#result; $ix++) {
> +		if ($expect->[$ix] ne $result[$ix]) {
> +			return undef;
> +		}
> +	}
> +	return 1;
> +}
> +
> print $debug "START\n";
> $debug->flush();
>=20
> -( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad =
initialize";
> -( packet_txt_read() eq ( 0, "version=3D2" ) )         || die "bad =
version";
> -( packet_bin_read() eq ( 1, "" ) )                  || die "bad =
version end";
> +compare_lists([0, "git-filter-client"], packet_txt_read()) ||
> +	die "bad initialize";
> +compare_lists([0, "version=3D2"], packet_txt_read()) ||
> +	die "bad version";
> +compare_lists([1, ""], packet_bin_read()) ||
> +	die "bad version end";
>=20
> packet_txt_write("git-filter-server");
> packet_txt_write("version=3D2");
> packet_flush();
>=20
> -( packet_txt_read() eq ( 0, "capability=3Dclean" ) )  || die "bad =
capability";
> -( packet_txt_read() eq ( 0, "capability=3Dsmudge" ) ) || die "bad =
capability";
> -( packet_txt_read() eq ( 0, "capability=3Ddelay" ) )  || die "bad =
capability";
> -( packet_bin_read() eq ( 1, "" ) )                  || die "bad =
capability end";
> +compare_lists([0, "capability=3Dclean"], packet_txt_read()) ||
> +	die "bad capability";
> +compare_lists([0, "capability=3Dsmudge"], packet_txt_read()) ||
> +	die "bad capability";
> +compare_lists([0, "capability=3Ddelay"], packet_txt_read()) ||
> +	die "bad capability";
> +compare_lists([1, ""], packet_bin_read()) ||
> +	die "bad capability end";
>=20
> foreach (@capabilities) {
> 	packet_txt_write( "capability=3D" . $_ );

