Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3921F935
	for <e@80x24.org>; Wed, 21 Sep 2016 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757043AbcIUUKU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 16:10:20 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33234 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbcIUUKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 16:10:20 -0400
Received: by mail-qk0-f171.google.com with SMTP id w204so56532487qka.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FbULuLBEq/h0cqaF19sTLujgWbw2FUrjD3ebQRVahU4=;
        b=Dcs0C2EPNYrL3u33Ti+iWgYb52Qjgb8BlhOWLZCwkmckSXiiJJnS+Lzn/4tFSaZ/oz
         8DHuTw9ve+2qqPnuqlPqEYCoU1n9HXCAhH9oUiWKVku5JiMRy4qTPCP66gtI0oJLy13Q
         mUeO+7QC5+k7gzNcpaOd6kiH+z+k76owUwgnMeG/kWeta5pcUPFIKfa02lpUNfOp3hGs
         XA6wOC33FMZRe6Qv8CX5kl4AL/8tS+xljhEiySR7vfHchPGiqNjL8KHkH3BtGVw0ZlDh
         JhGYwcNzJvylST3qCgKMwf1WVNZ+OW9Jc74AHIZ5QdioLDcOvccq5mk2XHKs+6NMpXZ3
         s8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FbULuLBEq/h0cqaF19sTLujgWbw2FUrjD3ebQRVahU4=;
        b=OzuY/pLCyNgEQ97SMvkN8T3dbgeBKhfnPL5ly1OFoS7VOjbBao5Fu7QWGj+CGg3pvP
         ISuKCasJ9Vf1PTMF6fh+rngUzVqdg4mODtp2Cvs1+XIOFafF9Oi3B+dBs9gVgnnr7Riq
         65FaoGAmPVZReSo+y2NJgs5jlk12kgcQVJQiswRRAkFZJyJNxixv/Mr431oZxVHVxLnd
         q56gZrw4hKRFUxpufdLcdaN0UEvDCW3414Ql2vF4+Wg/gy4u+ssSsbsdkbDHSzJTVQvS
         GWrZn8jqMnjNc44kpWj7YxCRl20UakTwnNgrKGHV9g9zloGHm5Yy40mr0WKUsxcinfa0
         i/Cw==
X-Gm-Message-State: AE9vXwMUTgNykQtbtGY6b2TLwiT7qQC0yGBXK/5dHOf+PWKgg6Ars/ltOGLqqp8X1RwWlOE1fkECwPCGyml8YQ==
X-Received: by 10.55.77.18 with SMTP id a18mr47096557qkb.157.1474488619136;
 Wed, 21 Sep 2016 13:10:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Wed, 21 Sep 2016 13:09:58 -0700 (PDT)
In-Reply-To: <88635d93-5288-c933-273a-003e5df824af@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com> <20160921114428.28664-2-avarab@gmail.com>
 <64389bcb-c6e4-1d19-54a1-650868b9acb5@gmail.com> <CACBZZX5mYuDUMHfurKEbCqodZkhYygQz+-G6VmKW+AMnCycm9g@mail.gmail.com>
 <88635d93-5288-c933-273a-003e5df824af@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 21 Sep 2016 22:09:58 +0200
Message-ID: <CACBZZX5VkviTtaQnAVdAbZQ2m4-tYiA+AVC_6sZa90O7Z-bgYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Link to 7-character SHA1SUMS in commit messages
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 8:28 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 21.09.2016 o 20:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason pisze:
>> It would make some code like git_print_log() a bit more complex /
>> fragile, since it would have to work on multi-line strings, but
>> anything that needed to do a regex match / replacement would be much
>> faster.
>
> Would it?  Did you perform any synthetic micro-benchmark?

No, just experience. With the caveat that this may not matter at all
in this context, C-like code in Perl is slow, if you can offload
things to one big regex operation it's usually faster.

>>
>> But OTOH I think perhaps we're worrying about nothing when it comes to
>> the performance. I haven't been able to make gitweb display more than
>> a 100 or so commits at a time (haven't found where exactly in the code
>> these limits are), any munging we do on the log messages would have to
>> be pretty damn slow to matter.
>
> sub git_log_generic {
>
>         # [...]
>
>         my @commitlist =3D
>                 parse_commits($commit_hash, 101, (100 * $page),
>                               defined $file_name ? ($file_name, "--full-h=
istory") : ());
>
> Here you have it (it probably should be a constant; this number can be
> found in a few other places).

Thanks!
