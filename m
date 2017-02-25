Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3144F201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 22:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbdBYWfb (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 17:35:31 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36652 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdBYWfa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 17:35:30 -0500
Received: by mail-wm0-f52.google.com with SMTP id v77so37558464wmv.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=59gmUBaYFyzQDkK+EiImMHBY6zU+m4tXejJ+MtDTwWQ=;
        b=lP5cSJYKIzHhQ9Avo+QUSQx6fTcYA7Lq5hsMAo3aqQsi3pQyhuKSmRz7v7os4HpRom
         KWPF4aus6ETzkQj77lEzC6Lo+kyeBzPTDMdCmV0SA3AwHmDD5+AcdhawqNHncLZscH4K
         XZt+UX260x8CdWOJT9wTWQB5ECuH5giL5Rms0JccpVJuRiB13e2CNqIeZIf+SSjGEB0h
         H0J3ojx2CEvLpPNYT1VhQvaCJlE160b17b6TGVN5S/4meIEZkibNn+hdy+c/RzBr0aAn
         hNackuawnQ6+UBaoOw47RsAiZWyCaNs3yssbgTIRpusLndo2L2VNaqaXfygos0jKT9Jo
         /wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=59gmUBaYFyzQDkK+EiImMHBY6zU+m4tXejJ+MtDTwWQ=;
        b=pk1sq3rTY2Z7u83FVTTsQ422QHU35KLSRxbXKyrUU5LCu00m32hvtEX0PUKk1pSQWx
         PoMDd/i9lK2xpZFeDFtwMYV8A9mZC6nspILVxhrdgwAeQnXOeV5OvcvySYtN415Xtj9N
         q61MthFvMcPucclsKAbzO6EcFkhdjIlr1XNkpqsxu106AdMND5p7ucDt69Oi3oFHKRda
         OwlbL5rgituZc6NyjQoDWaWQhpr87i3Q7bPeGvZ4VYoQrlcKXFjTLS8Ob/nV08TS1PzP
         ooPCCrGS6l/4oaabjvKGwcnAk8M4HdKB5cZgO6fDuuxCywCEy/0aFxgW9OlHqxx9Bo7i
         S7vg==
X-Gm-Message-State: AMke39kazWlgzJVpdy0Om2Y6FxFm5XR1EBAypqnUerTZkm8LHZdApkl2+sfwqe6l/PADWA==
X-Received: by 10.28.215.11 with SMTP id o11mr2167675wmg.118.1488062128818;
        Sat, 25 Feb 2017 14:35:28 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB48D9.dip0.t-ipconnect.de. [93.219.72.217])
        by smtp.gmail.com with ESMTPSA id z198sm7945836wmz.24.2017.02.25.14.35.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Feb 2017 14:35:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: SHA1 collisions found
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
Date:   Sat, 25 Feb 2017 23:35:27 +0100
Cc:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D74A82FF-BF00-481F-9B2A-4AF8EF3D062F@gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com> <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Feb 2017, at 00:06, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Feb 24, 2017 at 11:47:46PM +0100, Jakub Nar=C4=99bski wrote:
>=20
>> I have just read on ArsTechnica[1] that while Git repository could be
>> corrupted (though this would require attackers to spend great amount
>> of resources creating their own collision, while as said elsewhere
>> in this thread allegedly easy to detect), putting two =
proof-of-concept
>> different PDFs with same size and SHA-1 actually *breaks* Subversion.
>> Repository can become corrupt, and stop accepting new commits. =20
>>=20
>> =46rom what I understand people tried this, and Git doesn't exhibit
>> such problem.  I wonder what assumptions SVN made that were broken...
>=20
> To be clear, nobody has generated a sha1 collision in Git yet, and you
> cannot blindly use the shattered PDFs to do so. Git's notion of the
> SHA-1 of an object include the header, so somebody would have to do a
> shattered-level collision search for something that starts with the
> correct "blob 1234\0" header.
>=20
> So we don't actually know how Git would behave in the face of a SHA-1
> collision. It would be pretty easy to simulate it with something like:
>=20
> ---
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index 22b125cf8..1be5b5ba3 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -231,6 +231,16 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void =
*data, unsigned long len)
> 		memcpy(ctx->W, data, len);
> }
>=20
> +/* sha1 of blobs containing "foo\n" and "bar\n" */
> +static const unsigned char foo_sha1[] =3D {
> +	0x25, 0x7c, 0xc5, 0x64, 0x2c, 0xb1, 0xa0, 0x54, 0xf0, 0x8c,
> +	0xc8, 0x3f, 0x2d, 0x94, 0x3e, 0x56, 0xfd, 0x3e, 0xbe, 0x99
> +};
> +static const unsigned char bar_sha1[] =3D {
> +	0x57, 0x16, 0xca, 0x59, 0x87, 0xcb, 0xf9, 0x7d, 0x6b, 0xb5,
> +	0x49, 0x20, 0xbe, 0xa6, 0xad, 0xde, 0x24, 0x2d, 0x87, 0xe6
> +};
> +
> void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
> {
> 	static const unsigned char pad[64] =3D { 0x80 };
> @@ -248,4 +258,8 @@ void blk_SHA1_Final(unsigned char hashout[20], =
blk_SHA_CTX *ctx)
> 	/* Output hash */
> 	for (i =3D 0; i < 5; i++)
> 		put_be32(hashout + i * 4, ctx->H[i]);
> +
> +	/* pretend "foo" and "bar" collide */
> +	if (!memcmp(hashout, bar_sha1, 20))
> +		memcpy(hashout, foo_sha1, 20);
> }

That's a good idea! I wonder if it would make sense to setup an=20
additional job in TravisCI that patches every Git version with some hash=20=

collisions and then runs special tests. This way we could ensure Git=20
behaves reasonable in case of a collision. E.g. by printing errors and=20=

not crashing or corrupting the repo. Do you think that would be worth=20
the effort?

- Lars=
