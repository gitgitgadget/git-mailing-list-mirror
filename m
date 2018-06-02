Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E8D1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 05:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeFBFD7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 01:03:59 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38714 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeFBFD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 01:03:58 -0400
Received: by mail-oi0-f49.google.com with SMTP id d5-v6so21202509oib.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=54UJWGC5TICDc/x57igoQQB4v0jdbNsU3y17Lhhl1Hw=;
        b=EM+c/Sx3WAoccrRrRuW7JdyFWQiesOon26QCFlwEzKysBpb3aGRIJLghaKDKkchcsv
         eDECFMlyJ3tbYxYJPFK79AghLixmyOok6/i1kn+4rpJLGoXDHlK2QehZ23t3MCsVGyIL
         Brjj1kLbiUUASdvheXSGUGKEpKLG5qrKKzF9GsGv+CRzV4vcQ+0zj2i2uvCoo75jHIzN
         N7DK6bK0VCKS/vzhdzdgn3mvYSn2IjiDWlwOQWxEPatPe1HFK9rz+5c8L0pcF5nL3QiC
         LaMxsnXnBhgxsGgGwIg3BzILqSDxYulDrXv5UTd2A/F171tpZrmaeAlXLlMkY/THW6Ny
         +8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=54UJWGC5TICDc/x57igoQQB4v0jdbNsU3y17Lhhl1Hw=;
        b=n5JVg3CTtY2g+fI3/tM07P6007Ja0/n9viAXeRZNx6J6FA2q/Qlru8sCWDtDHQZX+q
         50EvJgqq9rD4SXTPRjstaK/66G2Znc2ATTcmi/OlpLykblqNCqKsAYe8t4phqJ0PBCkc
         ZALtVdLxionQN0ZBWbG5Se6A4h93J2YAaXLWGZCewpKuROOYZfktCOwr917Ojz1ePHXW
         Ue/r1VtdpkDuzNmsybzp9w6gBkU9JTgCO3Bw5Sz5x+fuDkGOo3cLncLNUKPyuY+1JwaY
         lOFsClFk8fENtFn8ly7i9dqfa7uCaAtNRECGV6ckbe3IO4vHjcAH7EFp5Gkox1JVRkzb
         +PWg==
X-Gm-Message-State: APt69E126OepdmURPbPqPx8PMW+Ky/7XV0r4wvuf83m4U2K9jn7O7upY
        2kqtsatzmaYSxUfhDxe6NGUNvv5wAH787zxwzBU=
X-Google-Smtp-Source: ADUXVKKwuJ75w/Myk8WMYnuXwoLcb+Z5YBycEVpQZSrxOkuJqeupGfbS9UVFvsZWkfJiyVmL7RIPtUyphaWM+7TQJoI=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr8212009oix.281.1527915838068;
 Fri, 01 Jun 2018 22:03:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 22:03:27 -0700 (PDT)
In-Reply-To: <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com> <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 07:03:27 +0200
Message-ID: <CACsJy8Ai5befewi9OxKzUxTOOOON9wgWpqcNy3AuK1YBk7MbxQ@mail.gmail.com>
Subject: Re: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 8:34 PM, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> On Fri, Jun 1, 2018 at 9:11 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>> unpack-trees code works on multiple indexes specified in
>> unpack_trees_options. Although they normally all refer to the_index at
>> the call site, that is the caller's business. unpack-trees.c should
>> not make any assumption about that and should use the correct index
>> field in unpack_trees_options.
>>
>> This patch is actually confusing because sometimes the function
>> parameter is also named "the_index" while some other times "the_index"
>> is the global variable because the function just does not have a
>> parameter of the same name! The only subtle difference is that the
>> function parameter is a pointer while the global one is not.
>>
>> This is more of a bug report than an actual fix because I'm not sure
>> if "o->src_index" is always the correct answer instead of "the_index"
>> here. But this is very similar to 7db118303a (unpack_trees: fix
>> breakage when o->src_index !=3D o->dst_index - 2018-04-23) and could
>> potentially break things again...
>
> Actually, I don't think the patch will break anything in the current
> code.  Currently, all callers of unpack_trees() (even merge recursive
> which uses different src_index and dst_index now) set src_index =3D
> &the_index.  So, these changes should continue to work as before (with
> a minor possible exception of merge-recursive calling into other
> functions from unpack-trees.c after unpack_trees() has finished..).
> That's not to say that your patch is bug free, just that I think any
> bugs shouldn't be triggerable from the current codebase.

Ah.. I thought merge-recursive would do fancier things and used some
temporary index. Good to know.

> Also, if any of the changes you made are wrong, what was there before
> was also clearly wrong.  So I think we're at least no worse off.
>
> But, I agree, it's not easy to verify what the correct thing should be
> in all cases.  I'll try to take a closer look in the next couple days.

Thanks. I will also stare at this code some more in the next couple
days trying to remember what these functions do.
--=20
Duy
