Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBBCE2095D
	for <e@80x24.org>; Mon, 20 Mar 2017 11:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbdCTLAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 07:00:53 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:34439 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbdCTK5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 06:57:09 -0400
Received: by mail-ot0-f180.google.com with SMTP id o24so129210516otb.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+tNdYhk0NZaqwEeZf0tCckQewMLkzmk2kGkC66qmz6c=;
        b=afA5kvb2m1ZafbEkWFIY3y71yvwtg79AXxxGme1bcEpZcc8qsm9QKa7+LNiNehanLW
         1xm1QuSrP+kIDqJPyp/Aj7MxcAH8YI1gc+mTtMBFCu/epJqyjXeletMCs7JYmDAU4/is
         JHPovFFVtm3ArxdGmB8OKKpSok2uomXcSU8A+E6FPWpue6M4j0Y4DArbe3I0OzduDiDX
         XBfrOP77e5ybccE9L6+eqV6A+WAROz9y9tQqaUwVKDeRdG/kgLwUFy7Ce6lq9e+/mVg9
         Fq7HnKdMYFT3ZM2aOKuaHctmCArCKKb0K4aXkdy5sCAcMko9BB7FxulVrsR0NDy4hCDu
         EPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+tNdYhk0NZaqwEeZf0tCckQewMLkzmk2kGkC66qmz6c=;
        b=pCEf6w6slOmjFwAG6gWmzU9OdY8C8zhzlgsxSqy+oozs81mcpuF+EGI6wsVrq8cW4G
         Nj0s6+E0vqoHmMMsvgUULFik+lUFNZJy/n/Jixn2I3PwiGiTipdNevLdtMXzP6wgrXPr
         eYOYPGruW08+BBEeCHwG1FTqWPM1nirX63vYEKGyB0S/J02vk79Le3up1Erl9uvupgMu
         vpJojnupNJMpXT3Zf1uxPcsCcVnyg8Q6yoKBRCuyF4iuczlkPBvLQjs9ONJm3R5Fr+/I
         RctQOgGC7044/+9sCECuN2ZUWnCuKTt/E/uV49TJQafh53Hn1RSQWfZh5vUQHPTNAIRh
         9Jsg==
X-Gm-Message-State: AFeK/H3Z/hC5TPq4b/6Dd+ITWufYLYakhrnX53NWc0Eml5JqoAnYWl68njC3Lf5Maw6D5n8kMa0joRYIGUEP8w==
X-Received: by 10.157.20.151 with SMTP id d23mr14427756ote.37.1490007399630;
 Mon, 20 Mar 2017 03:56:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 03:56:09 -0700 (PDT)
In-Reply-To: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr> <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
 <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 17:56:09 +0700
Message-ID: <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
Subject: Re: Add configuration options for some commonly used command-line options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 8:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Mar 19, 2017 at 2:18 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Sun, Mar 19, 2017 at 11:15:33AM +0100, Matthieu Moy wrote:
>>> I think the main problem is indeed "stop the users from shooting
>>> themselves in the foot". Many command-line options change the behavior
>>> completely so allowing users to enable them by default means allowing
>>> the users to change Git in such a way that scripts calling it are
>>> broken.
>>>
>>> This also doesn't help when troublshouting an issue as these options ar=
e
>>> typically something set once and for all and which you forget about.
>>> This typically leads to discussion in Q&A forums like:
>>>
>>> A: Can you run "git foo"?
>>> B: Here's the result: ...
>>> A: I don't understand, I can't reproduce here.
>>>
>>> just because B has a CLI option enabled by default.
>>>
>>> This is the same reasoning that leads Git to forbid aliasing an existin=
g
>>> command to something else.
>>>
>>> OTOH, we already have almost "enable such or such option by default"
>>> with aliases. People who always run "git am" with "-3" can write
>>>
>>> [alias]
>>>         a3 =3D am -3
>>>
>>> and just run "git a3".
>
> I can't find the E-Mail chain now but this has been discussed on-list
> a while ago. I.e. having some getopt support to say for the push
> command, that the --rebase option can also come from the config, i.e.
> in this case the pull.rebase option.
>
> IIRC the consensus was that such a facility would allow commands or
> individual options to say "this command/option is configurable", thus
> of course all plumbing utilities would be unconfigurable, but
> porcelain scripts would be configurable by default, with some
> exceptions.

This is exactly it! It's much better than adding individual config
variables (less work for sure, but messier). Maybe we should promote
the microproject "Add configuration options for commonly used cmdline
options" to project. If it's too short (I'm guessing the core code
could be done in a month), the gsoc student can always convert more
config to the new way.
--=20
Duy
