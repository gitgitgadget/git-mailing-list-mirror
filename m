Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F44E2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 19:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936284AbdCVTdQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:33:16 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:34006 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936271AbdCVTdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:33:09 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so6644969itc.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rbwYrhAntFL2E9mlFQjaADX5gKYs+siWkH25+ZCzX+w=;
        b=m39WoCKAHl4Y4qJUXa7i9CeBI+/yjVxBKPth8m3Ah7Tolbh/iohuAgXfTX6DPwCEuL
         cfA5faDZqcfSmkMIfXyf4MzIn+oneEDdUKy4VuYS72zJmmQbAwzX7tRtOjEeNzspf0Sw
         vw/xrUJQU04sYc7e2PhaKEDHJK0Zrvpwp1SGOdXR+RgkRLDXsAysybDgtx4Jcc0Aqp5A
         fcAEfPAm19Mn87xUp+HFtcL/nKgjC3QtgsdZpXokcpRTjfF1S6H3BO5ZI7XXeZdNZfu7
         3wH/Xs7LTeUEmHsWBXsf5F+Vcq5s77UbnEc7yvfydM6ZwIUihz5Ynr31DKSDZmaFvKRb
         k4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rbwYrhAntFL2E9mlFQjaADX5gKYs+siWkH25+ZCzX+w=;
        b=I3Z+qZvBWWZ9b2ovDu3kQxtiBAxIX2X20LpVJAzQtOZ7mz+Jmyz5WEHFg/cqkx4Soz
         NhDNokbt7Cquf3IY5FG/Q7HX+fkP/LXduKf/9q+3EgYjSyzH/73z3QYo5MYPBQAsmp6k
         yqIS+Vxvf2iOu1T8G/Z9SQGQnTErG6X4WhoxlhQkAJUQasjxn+aYxx41THEpCh2tXfZ4
         TEqcMtQ9cxDZPV9xTik1hiq+yi8g27wGNpT9ouAmSBfuWor+uNeZHs97fOLSG3pDWkPM
         0JrHlAIZiRu/bEXxpLB6pW5IQeNz5mcuj86Ol2FMRPdm6RCjjCv4w0CF3gfzESZ161Pp
         QxEg==
X-Gm-Message-State: AFeK/H1oIa4jjD81o+Y3xvbuBMgalEWwSsslSLB9Fr7530Zxp+BktmBeC6CluPP0FDGdSAqzSRCw+UWxak76vg==
X-Received: by 10.36.76.11 with SMTP id a11mr10238079itb.60.1490211187431;
 Wed, 22 Mar 2017 12:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 22 Mar 2017 12:32:46 -0700 (PDT)
In-Reply-To: <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-11-avarab@gmail.com>
 <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 22 Mar 2017 20:32:46 +0100
Message-ID: <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> And after Jeff's change, one that took multiple patterns:
>>
>>     git tag --list 'v*rc*' --list '*2.8*'
>
> I do not think this is a correct depiction of the evolution, and is
> a confusing description.  It should say
>
>     git tag --list 'v*rc*' '*2.8*'
>
> instead.

Changing this from "--list <pattern> --list <pattern>" to "--list
<pattern> <pattern>" wouldn't make any sense, because it's in the
middle of a sentence explaining not how the tooling worked, but before
this change, how it was documented to work. I.e. read up a few lines
to  "One would expect an option that was documented like that..." for
the context.

> When the logic was still in scripted Porcelain, <pattern> _was_ an
> optional argument to the "-l" option (see b867c7c2 ("git-tag: -l to
> list tags (usability).", 2006-02-17) you quoted earlier).  But way
> before Jeff's change, when the command was reimplemented in C and
> started using parse_options(), <pattern> stopped being an argument
> to the "-l" option.  What Jeff's change did was that the original
> code that only took
>
>     git tag -l 'v*rc*'
>
> to also take
>
>     git tag -l 'v*rc*' '*2.8*'
>
> i.e. multiple patterns.  Yes, thanks to parse_options, you could
> have -l twice on the command line, but "multiple patterns" does not
> have anything to do with having to (or allowing to) use '-l'
> multiple times.

Yes, all of this is correct, but not relevant to what I'm describing
in the commit message, because I'm making a documentation change and
describing how you *would* expect git to work if you read the
*documentation*, not if you read the code.

If you read the documentation after Jeff's 588d0e834b, since -l was
still documented as taking a <pattern> you'd expect "tag -l 'v*rc*' -l
'*2.8*'" to be how it worked, and for "tag -l 'v*rc*' '*2.8*'" to be
an error.

>> But since it's actually a toggle all of these work as well, and
>> produce identical output to the last example above:
>>
>>     git tag --list 'v*rc*' '*2.8*'
>>     git tag --list 'v*rc*' '*2.8*' --list --list --list
>>     git tag --list 'v*rc*' '*2.8*' --list -l --list -l --list
>
> So citing Jeff's change is irrelevant to explain these.  I doubt you
> even need to show these variations.

Jeff's change isn't being cited to explain these, everything before
the "But since it's actually" is describing how the documentation was
phrased to give you the impression that it worked, including after
Jeff's change where we started accepting multiple patterns. But at
this point I'm starting to describe how the code actually parsed the
--list option.

Regardless of that, I'll try to rephrase this somehow to make it
clearer, but I'd like to keep the general gist of "before this change,
if you read the docs, here's how you'd expect the -l option to work,
but it actually worked like so-and-so, and now that's what we document
instead".

>> Now the documentation is more in tune with how the "branch" command
>> describes its --list option since commit cddd127b9a ("branch:
>> introduce --list option", 2011-08-28).
>>
>> Change the test suite to assert that these invocations work for the
>> cases that weren't already being tested for.
>
> These two paragraphs are relevant.
>
>> --l <pattern>::
>> ---list <pattern>::
>> -     List tags with names that match the given pattern (or all if no
>> -     pattern is given).  Running "git tag" without arguments also
>> -     lists all tags. The pattern is a shell wildcard (i.e., matched
>> -     using fnmatch(3)).  Multiple patterns may be given; if any of
>> -     them matches, the tag is shown.
>> +-l::
>> +--list::
>> +     Activate the list mode. `git tag <pattern>` would try to create a
>
> Dont say <pattern> on this line.  It is `git tag <name>`.

Makes sense, but this is something I copied as-is from git-branch.txt,
which then has the same issue, so v3 will have yet another related
patch...

>> +     tag, use `git tag --list <pattern>` to list matching branches, (or
>
> Perhaps <pattern>... instead to signal that you can give multiple
> patterns?

Makes sense.

>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 958c77ab86..1de7185be0 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -118,6 +118,18 @@ test_expect_success 'listing all tags if one exists=
 should succeed' '
>>       git tag
>>  '
>>
>> +cat >expect <<EOF
>> +mytag
>> +EOF
>> +test_expect_success 'Multiple -l or --list options are equivalent to on=
e -l option' '
>> +     git tag -l -l >actual &&
>> +     test_cmp expect actual &&
>> +     git tag --list --list >actual &&
>> +     test_cmp expect actual &&
>> +     git tag --list -l --list >actual &&
>> +     test_cmp expect actual
>> +'
>
> The "-l/-d/-v" options follow the last-one-wins rule, no?  Perhaps
> also show how this one works in this test (while retitling it)?
>
>         git tag -d -v -l

This will fail as tested for in "tag: add more incompatibles mode
tests". We weren't testing "-d" with "-l", or this combination, I'll
add both to the tests.

>> @@ -336,6 +348,15 @@ test_expect_success 'tag -l can accept multiple pat=
terns' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'tag -l can accept multiple patterns interleaved wi=
th -l or --list options' '
>
> Please drop "interleaved", as we are not encouraging GNUism.  We
> just tolerate it but do not guarantee to keep them working.

This brings up the same point you made in
<xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>, I replied to in
<CACBZZX5LN8nhs85K18XVg4Y9_qb9zKGBoFnnQHSsRZVOP=3DOkDw@mail.gmail.com>,
and that you didn't get back to me about.

Rather than split the discussion or me copy/pasting large parts of
that E-Mail could you please reply to me over in that thread?

>> +     git tag -l "v1*" "v0*" >actual &&
>> +     test_cmp expect actual &&
>> +     git tag -l "v1*" --list "v0*" >actual &&
>> +     test_cmp expect actual &&
>> +     git tag -l "v1*" "v0*" -l --list >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>>  test_expect_success 'listing tags in column' '
>>       COLUMNS=3D40 git tag -l --column=3Drow >actual &&
>>       cat >expected <<\EOF &&
