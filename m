Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535E51FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdDITfA (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:35:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34572 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdDITe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:34:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id x75so6382338wma.1
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l4PmmbPx8u7i93DszWgDLwWDOGgs9TZ8yquFIt7mkJQ=;
        b=FLi8FLAzf2h5p9Y6aq4NbtMBR24QjYRZ2RDRxuGq8YRKPDZ5Ze0XqYkL2N1bbT6qh8
         H6nvRdiB+1ZJFWedzzgozlTb534g/ldp3rDnjfojU6JbG6ixE/US6OQwruWVnso9vNnE
         tHcdusPi7dVizmU6CNJ7Tl87L1bckq8hREgOsN5yxQk548lWkUkQHjKaIFxA7UimyWIi
         8Na2gap9JV+800Kob62xoD8h9oES/T6hb4mHPsHUHVT4gn77hzsOLfn0PEvXhF3xwpte
         hkB7tsiEGP0Si2xmxg7L+iijtbaoJut02Joz4vUDcXWtbRebnL1IVVCwdII46cONEXC9
         ubuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l4PmmbPx8u7i93DszWgDLwWDOGgs9TZ8yquFIt7mkJQ=;
        b=NXDp3OYwA/yBREn78bmAQkcm/AJY72qjIOnYrukQf0OE8z0CXlxcXKGv4fEWZ2DQ2n
         hFw8wN/wgOPszBHYzE8nnbEprOeVrIWuxZaPIQMgurfgZqJW/myxwgIWAbV5YBKJSDej
         LIPajb8OGQEzLN8/uFCYUqjTBgtIdBQ/6jnkEhsGFhc/EHtO+AGjxbGvjnX3nm5DoLIS
         fNzNwFRnsCn3l11aov0MJyPt15GUH4VESQX3SJtZVPEXMdFR3YHKNBE9Zt7G1TuC1aHR
         970ec2dpFais6tDHtQCUKOyVf6Va63MWC0YU1ipmHWr/mc80uU0MBT/zPoNmoIUDfMoN
         CtRw==
X-Gm-Message-State: AN3rC/7fAubK2U8hhlsOCEUkmieNhZk+5cIuZRsAw351w7e5a/R9TlEA
        O8+muCdY3ikO4w==
X-Received: by 10.28.93.65 with SMTP id r62mr6923877wmb.77.1491766497762;
        Sun, 09 Apr 2017 12:34:57 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id v29sm14514098wrv.66.2017.04.09.12.34.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:34:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 1/8] pkt-line: add packet_read_line_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-2-benpeart@microsoft.com>
Date:   Sun, 9 Apr 2017 21:34:56 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <81D3FB34-F4B6-4561-9374-77EE7B9E5BA5@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-2-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> Add packet_read_line_gently() to enable reading a line without dying =
on
> EOF.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> pkt-line.c | 12 ++++++++++++
> pkt-line.h | 10 ++++++++++
> 2 files changed, 22 insertions(+)
>=20
> diff --git a/pkt-line.c b/pkt-line.c
> index d4b6bfe076..58842544b4 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -323,6 +323,18 @@ char *packet_read_line(int fd, int *len_p)
> 	return packet_read_line_generic(fd, NULL, NULL, len_p);
> }
>=20
> +int packet_read_line_gently(int fd, int *dst_len, char** dst_line)
> +{
> +	int len =3D packet_read(fd, NULL, NULL,
> +		packet_buffer, sizeof(packet_buffer),
> +		PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);

Really minor nit: you could align the parameters according to fd
similar to the "packet_read_line_generic" code (tab width 8).

> +	if (dst_len)
> +		*dst_len =3D len;
> +	if (dst_line)
> +		*dst_line =3D (len > 0) ? packet_buffer : NULL;

Minor nit: The explicit check "len > 0" is necessary here as len can
be "-1". The original "packet_read_line_generic" just checks for=20
"len". I think it would be nice if the code would be consistent and both
would check "len > 0".

> +	return len;
> +}
> +
> char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
> {
> 	return packet_read_line_generic(-1, src, src_len, dst_len);
> diff --git a/pkt-line.h b/pkt-line.h
> index 18eac64830..12b18991f6 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -74,6 +74,16 @@ int packet_read(int fd, char **src_buffer, size_t =
*src_len, char
> char *packet_read_line(int fd, int *size);
>=20
> /*
> + * Convenience wrapper for packet_read that sets the =
PACKET_READ_GENTLE_ON_EOF
> + * and CHOMP_NEWLINE options. The return value specifies the number =
of bytes
> + * read into the buffer or -1 on truncated input. if the *dst_line =
parameter

s/if/If/


> + * is not NULL it will return NULL for a flush packet and otherwise =
points to

This sentences is a bit confusing to me. Maybe:

If the *dst_line parameter is not NULL, then it will point to a static =
buffer
(that may be overwritten by subsequent calls) or it will return NULL for =
a flush=20
packet.

... feel free to completely ignore this as I am no native speaker.

> + * a static buffer (that may be overwritten by subsequent calls). If =
the size
> + * parameter is not NULL, the length of the packet is written to it.
> + */
> +int packet_read_line_gently(int fd, int *size, char** dst_line);
> +
> +/*
>  * Same as packet_read_line, but read from a buf rather than a =
descriptor;
>  * see packet_read for details on how src_* is used.
>  */

If you send another round then you could address the minor nits.
If not, then this patch as it is looks good to me.

Thanks,
Lars=
