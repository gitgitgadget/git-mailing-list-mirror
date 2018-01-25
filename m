Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B46E1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeAYWHg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 17:07:36 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:38667 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeAYWHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 17:07:35 -0500
Received: by mail-yw0-f173.google.com with SMTP id m84so3548468ywd.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xmRKv8b0GAEf5HIULo/iXN2f2FaZY3Mtfswrohl0PKY=;
        b=UcAbZK55yjYFDi6nLjlYXnCrrnGL+60Jx5EgkPPNSxkF9j/aNWDidfmzFx+T7sC0NG
         m6CWKiA+u3948UiDtQrp3rb4sOBLPZlka5bwj9rV7wvMY6y4TccYnN7+QjI4YrPRYX1K
         pfEYUnOO9YBmlOcFOlWWOcOFcofQsEs1ZZmKpMaAi5CaDgLQ1gGNPjIcU+xAUnpx/yid
         PJL+QaL0SVJkmviEiBP9r29ZbOc0yulHAklkS27gTzvbyLi/mWdj6EGe+X3KvEgd1UWn
         PTZ9oRNaqKElcpQ2zh4qh/b6fSTaPrDU5PVVL+09r+Umt94lusslITqz/f8DvO+KjICC
         KhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xmRKv8b0GAEf5HIULo/iXN2f2FaZY3Mtfswrohl0PKY=;
        b=ateLIn60oxWKEnqVG/8+G0qq/WcSnzU9bve+xCCKW0yLYeJECqMDVHe2edbddgyZ9o
         4XBOdt4jv5L3e1xgkfR+vdsP6jdEqPrBIPvVJKWA4Ua9o55LxplQt6UekIwxcDJHQFYb
         j4vKacgBKX9aGvalIOJUd/9cOtagKcysA6JWuYQA04QsG2dxMY4Is2M/Zrzh8S1on74d
         39yj5wb4FOYzA48x3jIEiU6iNrg4dYPqQjbLySl1rDIj5EjM+qBin7hpeBNT9n3f8wql
         HmmQa6job+copOcIRUBQULLCnuncfa2jL4wbDdEm+ElOsETSAqixvXhJYxE8TMU32Y4M
         P1vw==
X-Gm-Message-State: AKwxyteS8SZcidxofptc/7kQLg6WSGLmqEFyBvQKPBVljrunAREsp0Jn
        w6ppEui0htUQDcCk/ADnx+F3487OWOq9BxXcuk25bW2u/ng=
X-Google-Smtp-Source: AH8x227LZRT2Uro4xl5aXF9jDMx7MOGbLlNGUQLW0UXsap2pXn6txq3U1pfpDiotBp/V8tsHnjnAwWrT7drMukchuxo=
X-Received: by 10.129.119.131 with SMTP id s125mr9385922ywc.166.1516918054329;
 Thu, 25 Jan 2018 14:07:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 14:07:33 -0800 (PST)
In-Reply-To: <20180125140231.65604-5-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-5-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 14:07:33 -0800
Message-ID: <CAGZ79kap0bdpcHqLM128mc_f2aEoemRJSFUNpU2xvegtOMcTkg@mail.gmail.com>
Subject: Re: [PATCH 04/14] packed-graph: add format document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Add document specifying the binary format for packed graphs. This
> format allows for:
>
> * New versions.
> * New hash functions and hash lengths.
> * Optional extensions.
>
> Basic header information is followed by a binary table of contents
> into "chunks" that include:
>
> * An ordered list of commit object IDs.
> * A 256-entry fanout into that list of OIDs.
> * A list of metadata for the commits.
> * A list of "large edges" to enable octopus merges.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/graph-format.txt | 88 ++++++++++++++++++++++++++++++++

So this is different from Documentation/technical/packed-graph.txt,
which gives high level design and this gives the details on how
to set bits.

>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/technical/graph-format.txt
>
> diff --git a/Documentation/technical/graph-format.txt b/Documentation/technical/graph-format.txt
> new file mode 100644
> index 0000000000..a15e1036d7
> --- /dev/null
> +++ b/Documentation/technical/graph-format.txt
> @@ -0,0 +1,88 @@
> +Git commit graph format
> +=======================
> +
> +The Git commit graph stores a list of commit OIDs and some associated
> +metadata, including:
> +
> +- The generation number of the commit. Commits with no parents have
> +  generation number 1; commits with parents have generation number
> +  one more than the maximum generation number of its parents. We
> +  reserve zero as special, and can be used to mark a generation
> +  number invalid or as "not computed".
> +
> +- The root tree OID.
> +
> +- The commit date.
> +
> +- The parents of the commit, stored using positional references within
> +  the graph file.
> +
> +== graph-*.graph files have the following format:
> +
> +In order to allow extensions that add extra data to the graph, we organize
> +the body into "chunks" and provide a binary lookup table at the beginning
> +of the body. The header includes certain values, such as number of chunks,
> +hash lengths and types.
> +
> +All 4-byte numbers are in network order.
> +
> +HEADER:
> +
> +       4-byte signature:
> +           The signature is: {'C', 'G', 'P', 'H'}
> +
> +       1-byte version number:
> +           Currently, the only valid version is 1.
> +
> +       1-byte Object Id Version (1 = SHA-1)
> +
> +       1-byte Object Id Length (H)

  This is 20 or 40 for sha1 ? (binary or text representation?)

> +       1-byte number (C) of "chunks"
> +
> +CHUNK LOOKUP:
> +
> +       (C + 1) * 12 bytes listing the table of contents for the chunks:
> +           First 4 bytes describe chunk id. Value 0 is a terminating label.
> +           Other 8 bytes provide offset in current file for chunk to start.

... offset [in bytes/words/4k blocks?] in ...


> +           (Chunks are ordered contiguously in the file, so you can infer
> +               the length using the next chunk position if necessary.)
> +
> +       The remaining data in the body is described one chunk at a time, and
> +       these chunks may be given in any order. Chunks are required unless
> +       otherwise specified.

> +
> +CHUNK DATA:
> +
> +       OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +           The ith entry, F[i], stores the number of OIDs with first
> +           byte at most i. Thus F[255] stores the total
> +           number of commits (N).

So F[0] > 0 for git.git for example.

Or another way: To lookup a 01xxx, I need to look at
entry(F[00] + 1 )...entry(F[01]).

Makes sense.

> +
> +       OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> +           The OIDs for all commits in the graph.

... sorted ascending.


> +       Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
> +           * The first H bytes are for the OID of the root tree.
> +           * The next 8 bytes are for the int-ids of the first two parents of
> +             the ith commit. Stores value 0xffffffff if no parent in that position.
> +             If there are more than two parents, the second value has its most-
> +             significant bit on and the other bits store an offset into the Large
> +             Edge List chunk.

s/an offset into/position in/ ? (otherwise offset in bytes?)

> +           * The next 8 bytes store the generation number of the commit and the
> +             commit time in seconds since EPOCH. The generation number uses the
> +             higher 30 bits of the first 4 bytes, while the commit time uses the
> +             32 bits of the second 4 bytes, along with the lowest 2 bits of the
> +             lowest byte, storing the 33rd and 34th bit of the commit time.

This allows for a maximum generation number of
1.073.741.823 (2^30 -1) = 1 billion,
and a max time stamp of later than 2100.

Do you allow negative time stamps?


> +
> +       [Optional] Large Edge List (ID: {'E', 'D', 'G', 'E'})
> +           This list of 4-byte values store the second through nth parents for
> +           all octoput merges. The second parent value in the commit data is a

octopus

> +           negative number pointing into this list. Then iterate through this
> +           list starting at that position until reaching a value with the most-
> +           significant bit on. The other bits correspond to the int-id of the
> +           last parent.
> +
> +TRAILER:
> +
> +       H-byte HASH-checksum of all of the above.
> --
> 2.16.0
>
