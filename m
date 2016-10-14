Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,TRACKER_ID shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE99D1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbcJNSIa (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 14:08:30 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35015 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbcJNSI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 14:08:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id v138so9154594qka.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZTTcyc4qIumtgorN2wkBMx8wnJtAI0kxFUWUNeCx+8s=;
        b=mRW1aMMTQUohowlIba4DIXcTETMvcE31FpIejTq3MX6EC1OaKrfZoAWOMyFWY8IHPV
         SBWKb+G/NZwGHhxdvAE3hJPk8r+wZWGXCfWTqEb3rlc+4hLBElDxYq59abpDLhCaMBDr
         CWSFUViJ90n8UqXKZJ5CKXDoQxruq1i4oRaZ2VQYj0LZgPAnohfRqWNWy8URDhzouwmP
         H1VNY2NUfO9V7mtYQetoNKPmlWiLrbgUAwcsnCJfweG9VJWbKuC7Ag+mt1Ie9z5HvUiv
         Co3O3cmj0rbt30qJWTJqjv1XuQC+Z9BDXxEVtg54fJUb6kCeeNd2HREiATUTvgzbGD5C
         lh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZTTcyc4qIumtgorN2wkBMx8wnJtAI0kxFUWUNeCx+8s=;
        b=faoh6FChkf25r/3+ve3FSAv2eset3mYDa9qHcSJnbor8GhxVtisR6N/FKTYABQyTKq
         3f50caK7ooFzal7ywnfg7HOtalHOLZOjXGv/Ct0ubEUowrPObWcqyJgP2GiPaY68fJJp
         jxMsXndVRMGGIWjuimsi8PQl9qMHjtJZhLMXliJ5ZLU6E8lCC1EXhnsb89MVxz4cNe45
         1azoiBjY8MxFZ67jz3G5QV/aBDCQpiIAho+B8NalWBeYiAm2jYN/EoWM6V5RBff9NWsT
         DTTY5FEZepayO9woqkrwxti0uxqUm2UnHKqowXu8Yzu5AOmpijnVHEZFnQMIBX2EHadd
         FzqA==
X-Gm-Message-State: AA6/9Rk1yeRHxI/PGaBsyALlogJuMIX9HTqqOBmZRS/PWBaKy45eDpzIi6f8/sbZXJ7ALiZwn9+8oZT1j3Zfgw==
X-Received: by 10.55.5.15 with SMTP id 15mr12334587qkf.49.1476467467192; Fri,
 14 Oct 2016 10:51:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.217.79 with HTTP; Fri, 14 Oct 2016 10:50:46 -0700 (PDT)
In-Reply-To: <CACBZZX5mnCmzT3N35YKpr2t1LT-hh-H7eS-+XTjudguedJL5Zw@mail.gmail.com>
References: <20161006091135.29590-1-avarab@gmail.com> <20161006091135.29590-4-avarab@gmail.com>
 <xmqqy421i7dg.fsf@gitster.mtv.corp.google.com> <CACBZZX5mnCmzT3N35YKpr2t1LT-hh-H7eS-+XTjudguedJL5Zw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 14 Oct 2016 19:50:46 +0200
Message-ID: <CACBZZX4HPci=n193WPm1RCes4PZfFXQtAdJuwxMwvTvF2NBVMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gitweb: Link to "git describe"'d commits in log messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 9, 2016 at 1:20 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Oct 6, 2016 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Change the log formatting function to know about "git describe" output
>>> such as "v2.8.0-4-g867ad08", in addition to just plain "867ad08".
>>>
>>> There are still many valid refnames that we don't link to
>>> e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
>>> v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
>>> similarly it's trivially possible to create some refnames like
>>> "=C3=A6/var-gf6727b0" or which won't be picked up by this regex.
>>
>> Not a serious counter-proposal or suggestion, and certainly not an
>> objection to the patch I am responding to, but I wonder if it is so
>> bad if we made the 867ad08 into link when showing v2.8.0-4-g867ad08.
>>
>> IOW, in addition to \b followed by [0-9a-f]+ followed by \b, if we
>> allowed an optional 'g' in front of the hex, e.g.
>>
>> -       $line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
>> +       $line =3D~ s{\bg?([0-9a-fA-F]{7,40})\b}{
>>
>> wouldn't that be much simpler, covers more cases and sufficient?
>
> It would be more simpler, maybe that's the right approach. I have a
> preference for making the entire reference a link. I think it makes
> more sense for the UI.

I just ran into an example of a better reason for doing it like my
patch is doing, which is that if you have some tag like:

deployment-20160928-171914-16-g42e13d8

 With my patch the whole thing will be a link to the 42e13d8 commit,
but with this suggestion both 20160928 and 42e13d8 would become commit
links, the former one would be broken.

Of course we could have some code that would detect that the whole \S+
is part of one thing that ends in g<commit>, but the complexity in
doing that would be equivalent or more to doing what my patch is
doing.

>>> There's surely room for improvement here, but I just wanted to address
>>> the very common case of sticking "git describe" output into commit
>>> messages without trying to link to all possible refnames, that's going
>>> to be a rather futile exercise given that this is free text, and it
>>> would be prohibitively expensive to look up whether the references in
>>> question exist in our repository.
>>>
>>> There was on-list discussion about how we could do better than this
>>> patch. Junio suggested to update parse_commits() to call a new
>>> "gitweb--helper" command which would pass each of the revision
>>> candidates through "rev-parse --verify --quiet". That would cut down
>>> on our false positives (e.g. we'll link to "deadbeef"), and also allow
>>> us to be more aggressive in selecting candidate revisions.
>>>
>>> That may be too expensive to work in practice, or it may
>>> not. Investigating that would be a good follow-up to this patch.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>>> ---
>>>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 92b5e91..7cf68f0 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2036,10 +2036,24 @@ sub format_log_line_html {
>>>       my $line =3D shift;
>>>
>>>       $line =3D esc_html($line, -nbsp=3D>1);
>>> -     $line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
>>> +     $line =3D~ s{
>>> +        \b
>>> +        (
>>> +            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
>>> +            # or hadoop-20160921-113441-20-g094fb7d
>>> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with=
 -
>>> +            [A-Za-z0-9.-]+
>>> +            (?!\.) # refs can't end with ".", see check_refname_format=
()
>>> +            -g[0-9a-fA-F]{7,40}
>>> +            |
>>> +            # Just a normal looking Git SHA1
>>> +            [0-9a-fA-F]{7,40}
>>> +        )
>>> +        \b
>>> +    }{
>>>               $cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>>>                                       -class =3D> "text"}, $1);
>>> -     }eg;
>>> +     }egx;
>>>
>>>       return $line;
>>>  }
