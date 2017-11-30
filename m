Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792E420C11
	for <e@80x24.org>; Thu, 30 Nov 2017 19:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbdK3T0s (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 14:26:48 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:35244 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdK3T0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 14:26:47 -0500
Received: by mail-it0-f53.google.com with SMTP id f143so9766024itb.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ou7Yn51iuYVS1M3pxBDZfHTI0xURNGYkEbIek6FUv20=;
        b=REAHKZgYDbaHHAgBWOxNDMrvE6ux+A4tqeulNRJvz5mStZwPvEj3o+QYYPfYBBeV6N
         W65vs1WsGX6tyDNXI2g5PG7+wm4QyKWouqOz01g49LvRGU+CaW/sNJwMyDr0cV3GhGJX
         SHTRx2zUnzb4KVICzJlmAMYQdO7tIF0M2L7CpHfItphNXPtVUjjndRWMPsTqCkP3SmnP
         Uht8Eo6wCgidCuWo7/nMM28NdzGJNFDoeLU3lkajfFY9aPaaBYmpZcT8hSJmT3uSFKBK
         bdio/GNEHs/jfKJJKyZdcKwzL1miGA8C+vnf7nIILhSU2qtlmt0sYyjxc0kHJYhMGjrV
         GAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ou7Yn51iuYVS1M3pxBDZfHTI0xURNGYkEbIek6FUv20=;
        b=cs8kGE7niU8rlNsgLyt3QqkScKMumqiAhyNZzmzJ6jPEYbbzDivuSvhRtqZRTIupZ2
         U/rT7nS2HNE8svTrBhc4GlXgsbNjitX9gCqa2zSi5NTQGTyJj0kBppTOufoCPI79q2Fb
         +IePqelZGg6SQY/eUBfinLDTy4oV+vCwsAb5OBi0axbkadMeacww04eetp6EIVFRuRco
         ZVDqvXSpNJjyImcsVVyS5hcfMKRnGdGASUjmH2tqCKxbYVxqHj+QtLa2ZlFczsjVKnXf
         EAXl/WJYRxn8sKlDHPTEVYn2cZqE2eGrh1gEA9NLgbAbbYJeaWjj7REFnKWBVBOSy4Th
         abkQ==
X-Gm-Message-State: AJaThX4f1F1Sn4TxozSKYUvsQLlzXMz/sCq2ZoKnAycw1SgMaSoeehS+
        +oCX4G6doyVBVdrZVbsaXVdBVEgVMhwAK/MQ4OjkDg==
X-Google-Smtp-Source: AGs4zMbo9GXhdQqC4z9SswWM6gTMDa89y/Slc0WVhuEvk1huJoOIB0680kguv2Z/U8wBqAQJJijovs7aA22TR2sfY2U=
X-Received: by 10.36.91.11 with SMTP id g11mr4606668itb.111.1512070006508;
 Thu, 30 Nov 2017 11:26:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.109.73 with HTTP; Thu, 30 Nov 2017 11:26:26 -0800 (PST)
In-Reply-To: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
References: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Thu, 30 Nov 2017 20:26:26 +0100
Message-ID: <CACx-yZ1dJuUj5mD6WE8yqZCPMK8q-yaJ0GKUSppZ7uDkqvJ5UA@mail.gmail.com>
Subject: Re: "git describe" documentation and behavior mismatch
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 7:47 PM, Daniel Knittl-Frank
<knittl89@googlemail.com> wrote:
> [=E2=80=A6]
>
> Running the above commands in the git.git repository yields a different r=
esult:
>
>>     $ git describe --all --abbrev=3D4 v1.0.5^2
>>     v1.0.0-21-g975b3
>
> No "reference path" to see. It is however shown, when the output is a
> branch name:
>
>>     $ git describe --all --abbrev=3D4 origin/next
>>     heads/next
>
> Is this expected behavior? IOW is the documentation outdated or is the
> git describe command misbehaving?

Bisecting history goes as far back as Feb 2008: commit
212945d4a85dfa172ea55ec73b1d830ef2d8582f

> Teach git-describe to verify annotated tag names before output

The warning mentioned in the commit message has since been gone. So I
guess the documentation is outdated? Nobody has complained for the
past 9 years, so we could call this a "feature" :)

An interesting fact (and intentional behavior?) is that describing a
commit with only a lightweight tag will properly display the tags/
prefix. I assume this is because the annotated tags only store the
tagname without any ref namespace, which is then picked up by git
describe and displayed.

I will try to come up with a patch for the man page.

Daniel

--=20
typed with http://neo-layout.org
