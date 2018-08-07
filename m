Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890EB208EC
	for <e@80x24.org>; Tue,  7 Aug 2018 04:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeHGHKT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 03:10:19 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38535 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731485AbeHGHKT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 03:10:19 -0400
Received: by mail-lj1-f175.google.com with SMTP id p6-v6so12379084ljc.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 21:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3SW/vQ0GfZyP2Wdnt0VsLVO7JD1IJcqYbrv5LFQxdbc=;
        b=hCkZPXVeenpWuwcj0VKM6EjiGPuST82YRSpCs36pOJLXkYERxpqpTBvu6dIFtgLOgL
         FPvMG/XWulVzSjbcVeBXAb0lhe9IoH3yJqCeQni0rjj7VO7G8zUC1YR9iPQdfDrgsVhm
         GJUE2Qn7Qq8YfdmT2TyVwGNlWSxkE7NUoQsNA+VtXw+i2zynI9gkVBm0cvbn5EoMF21p
         l11SsY8x3p57++u23FUDAQ9k6y9otwzb9roXedfDy5DtG82fwv+obRVzPfyT+8jkjqFs
         3st8pHmN6jugtOwcVtvB1MHeyRqz/w1lfyArRbnkDnzRZLOKvCdTAMtgm4ilPx/6pNj9
         kQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3SW/vQ0GfZyP2Wdnt0VsLVO7JD1IJcqYbrv5LFQxdbc=;
        b=BV3byHlGi2kCSS8k8Eb/ywMtEbzT5+IFkVIT84YFDtmzqLmXgCaH4NjtskY/hbAZZq
         7MzQwL2hE2erSo3b50OmY89bcDBlvJzEOfD+9yKszb435agpOA5gmyCSM/Maco0lqzPF
         WprEOQXEoMNG9FbdDYOEXQNQPQymlVGcielukugTl/FbVj/lbsrKkhIaGgQR+0SxC823
         ljZPtAWXmbBYdaK28Z1Bgz7RR00aJUA/D+ncvRtUpsPJTnYlI0Px133m4GXhAvxczp0A
         ATg0lGeASCLYFrOCqspwNnAIV9zyeQ/3EbazLldCqaFsxUhHIl3P4GJTAlcnvqTrQL9W
         9zWw==
X-Gm-Message-State: AOUpUlFd34l3HdofvjV8Z1jyi3/Rp23hYJoNG9S9fK54+LZT1KS0K5HD
        mWjiYzwAmIqJRpvCU1JXYXANcMsIfytRZ9g4MyodQA==
X-Google-Smtp-Source: AAOMgpdhtFgGdX1iLLUoHOcUW1lnjuPB/PcO15kZNx9kec6d1uzAciQErYL9+XollmZleT4uoxcJAdqInTRrWI9N3Zk=
X-Received: by 2002:a2e:2bd7:: with SMTP id r84-v6mr15076974ljr.40.1533617867520;
 Mon, 06 Aug 2018 21:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 21:57:46 -0700 (PDT)
In-Reply-To: <CA+KyZp5i8KzaAnet1eQovkxS2wLHUfnhZT04GCm2eXSFBqO+Fg@mail.gmail.com>
References: <CA+KyZp5i8KzaAnet1eQovkxS2wLHUfnhZT04GCm2eXSFBqO+Fg@mail.gmail.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Mon, 6 Aug 2018 21:57:46 -0700
Message-ID: <CA+KyZp6qDJqPky+rg-6kKDJ3yGSTeOroAddC4k0X=Sczz9VyYw@mail.gmail.com>
Subject: Re: Support JSON with --json flag and provide header files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it clear, these headers files would allow for compile-time type saf=
ety.
When you are parsing serialized data into a data structure, you know
have header files that describe the data type(s).
It would be nice to not have to "guess" about the structure of the
JSON that git produces.

On Mon, Aug 6, 2018 at 9:54 PM, Alexander Mills
<alexander.d.mills@gmail.com> wrote:
> @git
>
> I hear there is a movement underway to have git support JSON for the
> purposes of machine readable stdio.
>
> That is all good and well. I want to add to that request. Imagine a
> software world were serialized data could be typed. So JSON produced
> by C/C++ could be described and the receiving process could have type
> information about how the JSON would be deserialized.
>
> How would that work? For every typed language, Git would provide
> header files for that language that include type information for each
> JSON string that would be produced by git commands.
>
> How could that be accomplished? Someone needs to create a system to
> generate type information (header files) for each language based off a
> single central format. So we create a JSON format that describes the
> JSON data. And from that single format we generate header files for
> each typed language.
>
> I hope you see the value in that. There could be a git command that
> generates the header files for a given language, given the git
> version:
>
> $ git --generate-header-files --language=3Djava > $dir
>
> the above command would generate the right header files for Java given
> the git version. Or the headers could be stored on the www and could
> be downloadable for each git version. Perhaps Git authors wouldn't do
> all this work - perhaps they just author a JSON format that describes
> JSON. And the OSS community can write tools that convert the JSON
> format into header files for each language. But I would like something
> OFFICIAL to take place here.
>
> Hope this makes sense. I am looking forward to a software future where
> parsing stdio is easier by using machine readable JSON. Want human
> readable output? Use the regular command. Want machine readable
> output? use the --json flag.
>
> -alex
>
> --
> Alexander D. Mills
> =C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
> alexander.d.mills@gmail.com
>
> www.linkedin.com/pub/alexander-mills/b/7a5/418/



--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
