Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEA11F453
	for <e@80x24.org>; Wed, 30 Jan 2019 23:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfA3XNQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:13:16 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41003 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbfA3XNP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 18:13:15 -0500
Received: by mail-ed1-f53.google.com with SMTP id a20so1067322edc.8
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 15:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u6t5UQBuOsT7MTeXB/uE985t2g6ITOB/brIr3vb6hRY=;
        b=bEBQTbbYAXjFl8D8sh3/6Gsr2585/HlORcIjemeChohPTYgNUel67lUhNzlVnGDriI
         LX6Np+vnjrO9GT7eG7BhY2c0OUvVnPApIOEr1Y5SIBAYPkxbo/zBADb8brGyGRW51NZ/
         pxC3uWIbIXR/VQIM5u/4QEC21RjJRepABe1OCrP2WfEhyqOuFMB/WaGbQ8B3QGY9/QJp
         57bwoLvKN8wxnHEjd7LfCFa9QOfqLz4XD+i1+DZdldG8MWgAkcGmNYsQLEA9jWw489Ge
         hsJLGNHOdmxky3/qH+VWqPojAw81IRFB+zd93y+qAUwWTQANscJplJVPnW0q0isUSfRY
         MkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u6t5UQBuOsT7MTeXB/uE985t2g6ITOB/brIr3vb6hRY=;
        b=Txqx7rLV0HXENAiXd6/gUSImIN07BxAwAT+XRYGxbjAURqlLfPak45Y/fgGv9n6A1L
         gm08HGqWBOpQOXWdVKKqD2pHtts8tlrb8zNByG9ul/4j4eOIvkc2TE4HLSUuzY2E+TgE
         2u/lE66w02Nw5NHsTuOckompP7JNQRDt/QAxmJr559lCuiD5uiYXrcv7dxHW9+H7Wf5u
         4+trwwQ229g9BTDVL43mI/Frb5WIy7JGdjWuzeokOcnG8lr/pFo36ZQbq8sZQbpOq02x
         AF6IUgV2OLUh7jZYhGJZiMEVYj3qDLXDVow7DYIVnU7Q1yA5eG9CAMHJoiH85bzZZY8P
         /7pw==
X-Gm-Message-State: AJcUukelEc91q4PSlw+JG/Z+n3o1Z20nFywCvS+7Wc5b/tJn2HE7Sc3v
        cRGwBD3GXBAijaE8diQAj2MECx0RGUYsprxEIdU=
X-Google-Smtp-Source: ALg8bN6M9OUoV3gjMyWl4sfW1SZNXkoBw9h/yjZ51ZeysdmyeievKcngENPYNJQwgDr0XwKmvazEGuJz3VNyPFNUgaA=
X-Received: by 2002:a50:94f4:: with SMTP id t49mr32103735eda.24.1548889993609;
 Wed, 30 Jan 2019 15:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20190122075027.GA29441@sigill.intra.peff.net> <87va253lun.fsf@evledraar.gmail.com>
 <2015d9ea-0570-b035-dcbb-ee1865381cf1@iee.org>
In-Reply-To: <2015d9ea-0570-b035-dcbb-ee1865381cf1@iee.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 31 Jan 2019 00:13:01 +0100
Message-ID: <CAP8UFD1ka47UvU4CXRc5cMK=mpH0THtQkjG2-wOt2hhqLU4CsA@mail.gmail.com>
Subject: Re: Contributor Summit Topics and Logistics
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 12:05 AM Philip Oakley <philipoakley@iee.org> wrote=
:
>
> On 30/01/2019 20:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > * "Big repos". We had discussions about this in years past. It's a very
> >    spawly and vague topic. Do we mean big history, big blobs, big (in
> >    size/depth/width) checkouts etc?
> >
> >    But regardless, many of us deal with this in one way or another, and
> >    it would be good to have a top-level overview of how the various
> >    solutions to this that are being integrated into git.git are doing /
> >    what people see on the horizon for scalabiltiy.

I am also very interested in that topic ;-)

> I'd also like a bit of discussion about ensuring that the partial clone
> & filtering aspects of 'big repos' (if partial is needed /used then it's
> big ...) still retain the full 'distributed' nature and capability of git=
.

And in this too, especially regarding my work on many promisor/partial
clone remotes (previously ODBs).
