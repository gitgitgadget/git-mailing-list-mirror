Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3834A1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdLKXmO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:42:14 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44902 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKXmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:42:12 -0500
Received: by mail-wr0-f177.google.com with SMTP id l22so19309164wrc.11
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xSiPJxqs2b4BIs4K+BpWiHef+NjFL/2eik6NA1bVue8=;
        b=CAAgxraiebhV3v7ICNNbp/wuKEmoyOc1DhksRCuCKjGQJ1LTnJLmXTsUO6qntRcUES
         Jj3oaeuGPgXNtIsmYavi2drt21o7FTKtR61yx+4LW6FEQsEQE31AnRzOipziVZtblRHH
         IYqI9pl/MdHDLOWT5eZesxnpyzImkkyPDrXcsgvb8VWN7ylLP6+xRjQdwz04uy/o+Vmw
         G+4aVJpHuUmRq1Yn5ACfr8YI9Vr9iQYLK7YXJkI2M24mOLVz90tcmO0tsq2lgd6QCiEV
         k2H+z0KnASQ7jPfsd7e0UnAZ0502WJJvYclpHgzGU8tMlJz6ou2vo8sY2MyYSzEAcQLb
         7IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xSiPJxqs2b4BIs4K+BpWiHef+NjFL/2eik6NA1bVue8=;
        b=dGamqesH5xThlqvtG0eYPAUPXS8sQUu65EU5zY5IevqjVVKbrIq9NVYHJu07zEk/90
         spZI0k0EtuONvFbmQslMZzQvMSMfuOuK+AGa2esXmPomliTXoOPclxkH2IftdKDCkhuG
         UBjnD201PoGZBkQbXCHzL3BhfaXJHjrAUtA0v9+J5C0O35qyuad7aQ4eMv3usv9T8jX8
         pfDWczIsDggNHaAm5wMdjj1oXSVknw8tZoFA7RHhS+8pYiYYu4CaFsGvDQ65sScvcKcX
         6+ACo0XFroqM3gKruOO76VGWLP1DHiCPgWeksRa97wKjjrtn1O4Hr/kgYK3huJXvA3S/
         d1ow==
X-Gm-Message-State: AKGB3mLCq6QfC4mq4r10DsRElWu0tO768BmKpjQJMk36CRl8t2Urez8a
        J9rjoFND2fGCTvsrpDhiDjGIAA==
X-Google-Smtp-Source: ACJfBos+00lTg0PERElKJqLwlq14V9oJJnDLE/i98DXD9Lz2LlbxDYlTGhhWN+18CyCM7E+0uBWTJw==
X-Received: by 10.223.195.113 with SMTP id e46mr1802405wrg.149.1513035731605;
        Mon, 11 Dec 2017 15:42:11 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB687E.dip0.t-ipconnect.de. [93.219.104.126])
        by smtp.gmail.com with ESMTPSA id y2sm18519144wra.18.2017.12.11.15.42.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:42:11 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
Date:   Tue, 12 Dec 2017 00:42:23 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, peff@peff.net, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11 Dec 2017, at 21:47, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 11.12.2017 um 16:50 schrieb lars.schneider@autodesk.com:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> Git and its tools (e.g. git diff) expect all text files in UTF-8
>> encoding. Git will happily accept content in all other encodings, =
too,
>> but it might not be able to process the text (e.g. viewing diffs or
>> changing line endings).
>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>> content to a canonical UTF-8 representation. On checkout Git will
>> reverse the conversion.
>> Reviewed-by: Patrick L=FChne <patrick@luehne.de>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Hi,
>> here is a WIP patch to add text encoding support for files encoded =
with
>> something other than UTF-8 [RFC].
>> The 'encoding' attribute is already used to view blobs in gitk. That
>> could be a problem as the content is stored in Git with the defined
>> encoding. This patch would interpret the content as UTF-8 encoded and
>=20
> This will be a major drawback for me because my code base stores text =
files that are not UTF-8 encoded. And I do use the existing 'encoding' =
attribute to view the text in git-gui and gitk. Repurposing this =
attribute name is not an option, IMO.

I understand your point of view and I kind of expected that that reply.
Thanks for the feedback!

Question is: Given that "encoding" is not available, how could I name
             the attribute without confusing the user?

I contemplated:
  - "enc" or "encode" because "eol" and "ident" use abbreviations, too
    (enc could be confused with encryption. plus, a user might ask
     what is the difference between "enc" and "encoding" attribute :-)
  - "wte", "wtenc", or "worktree-encoding" to emphasize that this is=20
    the encoding used in the worktree=20
    (I fear that users think that is git-worktree, the command, related)

I think my favorite is "worktree-encoding".
What do you think?

Thanks,
Lars=20


BTW: I am curios, can you share what encoding you use?
My main use case is UTF-16 and I was surprised that I haven't
found a single public repo on github.com with "encoding=3Dutf-16"

