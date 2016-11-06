Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612E42021E
	for <e@80x24.org>; Mon,  7 Nov 2016 02:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbcKGCfm (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 21:35:42 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36842 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbcKGCfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 21:35:40 -0500
Received: by mail-wm0-f50.google.com with SMTP id p190so155796807wmp.1
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 18:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GcSHwqz47Yz67NIwmE+LjYS0P4wG21AfA7vC86MqF18=;
        b=bS+jkN8NQ2jyq5edxDbuF1NZ+g3D+/ylBBfYQZZkCFp9vZtpDYfQdYxA43TgkvpWdl
         RVZma+bDV6dMdncbbJmf9jsY2/2GQAl04343qgaCjYHK+tn8epnlT7bL+ZIzsAC9ne/N
         DcRyvW4h8p2MBdu0NqEbd7tZnFX/msh/bR2TdJzt3aPKAIP5NMZt87rSZV5GBe9Vxj9K
         R90/sGkHL5fjC0w0QUBlZu0krb5Z/MZ/F4hCbnvhajnOvLgrQCLjxqo+m0lDQtMTpMkS
         KUHaovTW7L1UX1xMIsxcEo3dcDCw1NSlDSPj/xQKv0LpgVBVPV+yPwmkG9d4hRTzK7nH
         H4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GcSHwqz47Yz67NIwmE+LjYS0P4wG21AfA7vC86MqF18=;
        b=JTBua9xSMFw5/HG0oe1zPzXkQ5z3cmGkxlHynbl24xGU5G8Tv1S6X0FLkZBcgdywW8
         198W5blMSPJ4H4xm3uUt1usHMV3wl9GH9OuIbtCmhN7sMdM306NPXnVHlB0SWDZUQRcN
         zOeA7Ez9IJX+qX2DyWnJIS54tns0TOiO6g765fZcyv/ZHlw0Wdp++1daxGNPnHjT4h5f
         c92nexEuZguf9G03k++CyhvUAWwZVWMNTTVJL4iSsHfreUi0jY9QSjw6XABDBtARdyDY
         X9UrvDQB4Y2JJmWGLK3LKz/9UgB6TVJuyDdQnKrv6aytsQkxLnfA6d/lqINEilx4ZKnq
         7BZA==
X-Gm-Message-State: ABUngvemqXQbJUeefcarrdzvl9oTaQwiTgD52asKPT7hjpnLhf/nlJwMmO2IGCjdAZQ/gA==
X-Received: by 10.194.106.197 with SMTP id gw5mr3335690wjb.88.1478461413507;
        Sun, 06 Nov 2016 11:43:33 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id f3sm9233535wmf.10.2016.11.06.11.43.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 11:43:33 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH (optional)] t0021: use arithmetic expansion to trim whitespace from wc -c output
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <b87ddffd-3de1-4481-b484-9f03a73b6ad1@kdbg.org>
Date:   Sun, 6 Nov 2016 20:43:31 +0100
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <283FAD19-35C3-4167-8946-A0F2A9CEDC57@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com> <20161016232038.84951-14-larsxschneider@gmail.com> <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org> <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com> <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org> <3b58b90d-5435-1503-d052-413a947a5ab5@kdbg.org> <C61D1F80-7B7A-4111-9418-75D178AF4353@gmail.com> <b87ddffd-3de1-4481-b484-9f03a73b6ad1@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Nov 2016, at 20:31, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 06.11.2016 um 16:45 schrieb Lars Schneider:
>>=20
>>> On 03 Nov 2016, at 21:22, Johannes Sixt <j6t@kdbg.org> wrote:
>>> This is a pure optimization that reduces the number of forks, which
>>> helps a bit on Windows.
>>>=20
>>> There would be a solution with perl that does not require trimming
>>> of whitespace, but perl startup times are unbearable on Windows.
>>> wc -c is better.
>=20
> I was wrong here. I had looked at the perl invocations due to
> git-sendemail, and they are awfully slow. A do-almost-nothing perl
> invocation is in the same ballpark as wc. Therefore I changed my mind
> and suggest the patch below instead.
>=20
>> Since the file size function became very simple with your patch,
>> shouldn't we get rid of it? If you agree, then we could squash the=20
>> patch below into your patch.
>=20
> In the new patch, the function is not that trivial (it uses perl), and
> the call sites can remain as they are (simple shell variables and
> substitutions).
>=20
> ---- 8< ----
> [PATCH] t0021: compute file size with a single process instead of a =
pipeline
>=20
> Avoid unwanted coding patterns (prodigal use of pipelines), and in
> particular a useless use of cat.
>=20
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> t/t0021-conversion.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index db71acacb3..cb72fa49de 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -22,7 +22,7 @@ generate_random_characters () {
> }
>=20
> file_size () {
> -	cat "$1" | wc -c | sed "s/^[ ]*//"
> +	perl -e 'print -s $ARGV[0]' "$1"
> }
>=20
> filter_git () {
> --=20
> 2.11.0.rc0.55.gd967357
>=20

I like this better, too. Looks good to me and works on macOS.

Thanks,
Lars

