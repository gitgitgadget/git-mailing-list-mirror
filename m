Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B0E20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdLCSsH (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 13:48:07 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:46454 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdLCSsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 13:48:05 -0500
Received: by mail-wr0-f175.google.com with SMTP id x49so14948083wrb.13
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e9z62o+fXzX5jpdmazJEo4P1hOMu1m9lrr/8iVxvE4s=;
        b=Bj5Q+pWy7cU4Np0bl6YmxlqN+oniaNoVoqFTDBS0KRQp+tlpFUTQ+evm0tcV4Oddkr
         vnVfG7VdmZIstDEd1QdviZ4nxE6fObHru8NOy81+wXILcWD7Q8xq/rNFbK/CRLfFH6yG
         P5fzn2kQZgPptNzPZHikXcsaSWb1j7qGtvjlklWXLg7dqgZwlbpa5F2LXOCu9jXTHjTt
         H4u6KjzPXQlMCHktUPMG+ABubx5Wv04HI9YBmN5qVyzNtRwkbaY4d2q9jLYeCxN8mJyN
         Cn5dvlh2N/9ykMmzCWYabSsaMQfNQ2N2WTdSkB56n65m35EIJrLDysstHOR1cNqWmjAS
         zKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e9z62o+fXzX5jpdmazJEo4P1hOMu1m9lrr/8iVxvE4s=;
        b=OcIrf9OXqu8OkaY60RhaS8jldGUjQyaQX4p1WUKom8Ds9jKN2ebM7IHGcLhsSeqexk
         GDFtOpEQbVThZEfxCyDgDZNG6eQtoZ0aP9XSrSQhhwFWiHnIr+DAUO8cK/UUA4eZmN4r
         XmXT7gmg75+1pm+TIp7EpDiTcVqsMlZPw2PUmz4M2QAtXkRdBARpUUOpS+nR9lBF9TyE
         sP/JwKh1r1psvLJBgVJnEsAbh1esXDSl95ToTMcOsSJCEzG9TjaMPbZluD+eJKN8yh5K
         5xv8I71qU/7co4s3Ehj1cbmh3fnMqvDK8ZyNzSBtXQrsunpD5FiKdrvw3mXox6z2qbEo
         Ymcg==
X-Gm-Message-State: AJaThX5Pk694i+x9jKRnkkOzqDGR6GEtjlGkEdiARflWMxZ7gvlKbHhv
        QFY8ONhMjImXBCZyhhbSco4=
X-Google-Smtp-Source: AGs4zMahq32E63uXAEACeCc9w95XTXhYb9vzhfR99EdySliRHhI6z68AwwJosYFXRPEAg/l8J/7QnA==
X-Received: by 10.223.189.5 with SMTP id j5mr10382527wrh.172.1512326884243;
        Sun, 03 Dec 2017 10:48:04 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6E6A.dip0.t-ipconnect.de. [93.219.110.106])
        by smtp.gmail.com with ESMTPSA id l142sm6301207wmb.43.2017.12.03.10.48.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Dec 2017 10:48:03 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Native clean/smudge filter for UTF-16 files
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171124180401.GB29190@sigill>
Date:   Sun, 3 Dec 2017 19:48:01 +0100
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <759F0C3A-8C46-4685-BB27-6D508B26BB49@gmail.com>
References: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com> <20171124180401.GB29190@sigill>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Nov 2017, at 19:04, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Nov 23, 2017 at 04:18:59PM +0100, Lars Schneider wrote:
>=20
>> Alternatively, I could add a native attribute to Git that translates =
UTF-16=20
>> to UTF-8 and back. A conversion function is already available in =
"mingw.h" [3]
>> on Windows. Limiting this feature to Windows wouldn't be a problem =
from my
>> point of view as UTF-16 is only relevant on Windows anyways. The =
attribute=20
>> could look like this:
>>=20
>>    *.txt        text encoding=3Dutf-16
>>=20
>> There was a previous discussion on the topic and Jonathan already =
suggested
>> a "native" clean/smudge filter in 2010 [4]. Also the "encoding" =
attribute
>> is already present but, as far as I can tell, is only used by the git =
gui
>> for viewing [5].
>=20
> I would not want to see a proliferation of built-in filters, but it
> really seems like text-encoding conversion is a broad and practical =
one
> that many people might benefit from. So just like line-ending
> conversion, which _could_ be done by generic filters, it makes sense =
to
> me to support it natively for speed and simplicity.
>=20
>> Do you think a patch that converts UTF-16 files to UTF-8 via an =
attribute
>> "encoding=3Dutf-16" on Windows would have a chance to get accepted?
>=20
> You haven't fully specified the semantics here, so let me sketch out
> what I think it ought to look like:

Thank you :-)


> - declare utf8 the "canonical" in-repo representation, just as we have
>   declared LF for line endings (alternatively this could be
>   configurable, but if we can get away with declaring utf8 the one =
true
>   encoding, that cuts out a lot of corner cases).

100% agree on UTF-8 as canonical representation and I wouldn't make=20
that configurable as it would open a can of worms.


> - if core.convertEncoding is true, then for any file with an
>   encoding=3Dfoo attribute, internally run iconv(foo, utf8) in
>   convert_to_git(), and likewise iconv(utf8, foo) in
>   convert_to_working_tree.
>=20
> - I'm not sure if core.convertEncoding should be enabled by default. =
If
>   it's a noop as long as there's no encoding attribute, then it's
>   probably fine. But I would not want accidental conversion or any
>   slowdown for the common case that the user wants no conversion.

I think we should mimic the behavior of "eol=3Dcrlf/lf" attribute.

AFAIK whenever I set "*.ext text eol=3Dcrlf", then I can be sure the=20
file is checked out with CRLF independent of any of my local config
settings. Isn't that correct? I would expect a similar behavior if
"*.ext text encoding=3Dutf16" is set. Wouldn't that mean that we do
not need a "core.convertEncoding" config?

I do 100% agree that it must be a noop if there is no encoding=20
attribute present.


> - I doubt we'd want a "core.autoEncoding" similar to "core.autocrlf". =
I
>   don't think people consistently have all utf-16 files (the way they
>   might have all CRLF files) rather a few files that must be utf-16.

Agreed!


> - I have actually seen two types of utf-16 in git repos in the wild:
>   files which really must be utf-16 (because some tool demands it) and
>   files which happen to be utf-16, but could just as easily be utf-8
>   (and the user simply does not notice and commits utf-16, but doesn't
>   realize it until much later when their diffs are unreadable).
>=20
>   For the first case, the "encoding" thing above would work fine. For
>   the second case, in theory we could have an option that takes any
>   file with a "text" attribute and no "encoding" attribute, and
>   converts it to utf-8.

TBH I would label that a "non-goal". Because AFAIK we cannot reliability
detect the encoding automatically.


>   I suspect that's opening a can of worms for false positives similar
>   to core.autocrlf. And performance drops as we try to guess the
>   encoding and convert all incoming data.
>=20
>   So I mention it mostly as a direction I think we probably _don't_
>   want to go. Anybody with the "this could have been utf-8 all along"
>   type of file can remedy it by converting and committing the result.

100 % agree.


> Omitting all of the "we shouldn't do this" bullet points, it seems
> pretty simple and sane to me.
>=20
> There is one other approach, which is to really store utf-16 in the
> repository and better teach the diff tools to handle it (which are
> really the main thing in git that cares about looking into the blob
> contents). You can do this already with a textconv filter, but:
>=20
>  1. It's slow (though cacheable).
>=20
>  2. It doesn't work unless each repo configures the filter (so not on
>     sites like GitHub, unless we define a micro-format that diff=3Dutf16=

>     should be textconv'd on display, and get all implementations to
>     respect that).

Actually, rendering diffs on Git hosting sites such as GitHub is one
of my goals. Therefore, storing content as UTF-16 wouldn't be a solution
for me.


>  3. Textconv patches look good, but can't be applied. This =
occasionally
>     makes things awkward, depending on your workflow.

TBH I dont't understand what you mean here. What do you mean with
"textconv patches"?


>  4. You have to actually mark each file with an attribute, which is
>     slightly annoying and more thing to remember to do (I see this =
from
>     the server side, since people often commit utf-16 without any
>     attributes, and then get annoyed when they see the file marked as
>     binary).
>=20
> We've toyed with the idea at GitHub of auto-detecting UTF-16 BOMs and
> doing an "auto-textconv" to utf-8 (for our human-readable diffs only, =
of
> course). That solves (1), (2), and (4), but leaves (3). I actually
> looked into using libicu to do it not just for UTF-16, but to detect =
any
> encoding. It turned out to be really slow, though. :)
>=20
> So anyway, that is an alternate strategy, but I think I like =
"canonical
> in-repo text is utf-8" approach a lot more, since then git operations
> work consistently. There are still a few rough edges (e.g., I'm not =
sure
> if you could apply a utf-8 patch directly to a utf-16 working tree =
file.
> Certainly not using "patch", but I'm not sure how well "git apply" =
would
> handle that case either). But I think it would mostly Just Work as =
long
> as people were willing to set their encoding attributes.

Agreed!

Thanks for your thoughts! I'll try to come up with a v1 of this idea.

- Lars=
