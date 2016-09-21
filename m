Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6684B1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758614AbcIUR6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:58:40 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36264 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758585AbcIUR6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:58:39 -0400
Received: by mail-qk0-f175.google.com with SMTP id z190so53356396qkc.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sjbVrhvTdQYHhxHJkCd2v5AgiZ2u/cm+bABwV0zftCI=;
        b=fzIakrLXJAxjiYO/GrDCklBi9cud+StPWAAHTQifNcOAyZCrRdNcrd4MUz/Y7vwhFq
         zIP8x2Y8Q8zA6H1dkYNeL4M6/Y8p2bWmemPOPzukBSzlsGaWOXugyt9T60+TLdlioW8A
         xboJRhkOQz34Nbz1YTMnbGv7JYxDrEaAKJw5IVmD/pctPLEdcb1RO7P6UseQfN7c6A36
         c7yvkSAoUPLTZSOLn7mb9FOehW5ETyyTNu2If5r3ThP1ymVx6i93BImXP/Bvq5ahuC7D
         9NaaxiY5eqxaKANw5Fj6vLFiu8AxyXP1SOyq5NZf1EUQKhyAkBI0O9PEydUHV/nHn4Ww
         9+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sjbVrhvTdQYHhxHJkCd2v5AgiZ2u/cm+bABwV0zftCI=;
        b=fiQ1C0HF+6oHS5TchEbkuVvQ33nmO0tMr3m3G3E6hz85PJ4icHYEoarhx3FMHp8owf
         wwELlshy0CWbGmPvsOHeMsQ5PmmM8x1ZF1Em8jAd+oy8CIRGTI5AkPIgdHFR0e2LZiYB
         HN7jQZHGi+96f9KkB8MPVdX6qfSRSSPFIgjD/AijiSAdr8MUeGlBotcgZCB2TvKRGaDo
         bskDU9A4d2yxG2QhliCpcCrnUOGtb2xfVQ11NzodMNq/3aMyypHF3bcgbTTrPf1tDDC7
         kRCx8ekir1jay487LfkhKYvVGh7fKBXVI52UXudj+S/q9bEsuMg2VFGc+/x80+OJXyY7
         xLbQ==
X-Gm-Message-State: AE9vXwObEh3YLFrgRDjz+OD0/g0yhMqK9OqtJPzLf0eIeLFyW9mwk5TmA8NQQiB1XqJkETMmqlqz02jRl6k0JQ==
X-Received: by 10.55.182.4 with SMTP id g4mr41792843qkf.120.1474480718584;
 Wed, 21 Sep 2016 10:58:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Wed, 21 Sep 2016 10:58:18 -0700 (PDT)
In-Reply-To: <fadd75f3-3737-1eaf-30f3-46a2ef132b27@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com> <20160921114428.28664-3-avarab@gmail.com>
 <fadd75f3-3737-1eaf-30f3-46a2ef132b27@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 21 Sep 2016 19:58:18 +0200
Message-ID: <CACBZZX5QF7FztmU-mqOEx40kC-PpQ9SqcL8+3HtuntcRZ1tWzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log messages
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 7:09 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 21.09.2016 o 13:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason napisa=
=C5=82:
>
>> Change the log formatting function to know about "git describe" output
>> like v2.8.0-4-g867ad08 in addition to just plain 867ad08.
>
> All right, that is a good plan.
>
>>
>> This also fixes a micro-regression in my change of the minimum SHA1
>> length from 8 to 7, which is that dated tags like
>> hadoop-20160921-113441-20-g094fb7d would start thinking the "20160921"
>> part was a commit.
>
> Actually 20160921 is 8 characters, so assuming that '-' is treated
> as word boundary by Perl, it is not a regression; this false positive
> was there.  The new feature would help, instead of linking false match
> it links whole git-describe output.
>
> So this paragraph needs to be changed wrt. the above.

Yeah I just miscounted there, will change that.

> Note that there are quite a bit of shortened SHA-1 that are composed
> entirely from digits, without a-f characters.

*nod*

>>
>> There are still many valid refnames that we don't link to
>> e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
>> v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
>> similarly it's trivially possible to create some refnames like
>> "=C3=A6/var-gf6727b0" or whatever which won't be picked up by this regex=
.
>
> Hopefully hierarchical tags are rare.  We need to reduce false
> positives.
>
>>
>> There's surely room for improvement here, but I just wanted to address
>> the very common case of sticking "git describe" output into commit
>> messages without trying to link to all possible refnames, that's going
>> to be a rather futile exercise given that this is free text, and it
>> would be prohibitively expensive to look up whether the references in
>> question exist in our repository.
>
> Note that we do not ask Git at the time of displaying commit message
> if the link is valid for performance reasons; we link it, and the link
> may be invalid if it was a false positive.
>
> Note that recommended way to refer to other commit in commit mesages
> is (see Documentation/SubmittingPatches):
>
>   If you want to reference a previous commit in the history of a stable
>   branch, use the format "abbreviated sha1 (subject, date)",
>   with the subject enclosed in a pair of double-quotes, like this:
>
>      Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
>      noticed that ...
>
> Hmmm... this makes previous commit even more important.
>
>> ---
>>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 101dbc0..3a52bc7 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2036,10 +2036,24 @@ sub format_log_line_html {
>>       my $line =3D shift;
>>
>>       $line =3D esc_html($line, -nbsp=3D>1);
>> -     $line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
>> +     $line =3D~ s{
>> +        \b
>> +        (
>> +            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
>> +            # or hadoop-20160921-113441-20-g094fb7d
>
> All right, for more complex regular expressions using in-line comments
> (extended regexp in Perl) is a good idea.
>
>> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with =
-
>> +            [A-Za-z0-9.-]+
>> +            (?!\.) # refs can't end with ".", see check_refname_format(=
)
>
> If we can assume that tag name is at least two characters (instead of
> at least one character), we could get rid of those extended regexp
> lookaround assertions:
>
>   (?<!pattern) - zero-width negative lookbehind assertion
>   (?!pattern)  - zero-width negative lookahead  assertion
>
> That is:
>
>   +            [A-Za-z0-9.]   # see strbuf_check_tag_ref(). Tags can't st=
art with -
>   +            [A-Za-z0-9.-]*
>   +            [A-Za-z0-9-]   # refs can't end with ".", see check_refnam=
e_format()

Why get rid of them? I'm all for improving the regex, there's bound to
be lots of bugs in it, but since it's perl we can freely use its
extended features.

> Also, the canonical documentation for what is allowed in refnames
> is git-check-ref-format(1)... though it does not look like it includes
> "tags cannot start with '-'".

Yeah, looks like that manpage needs to be patched.

> Anyway, perhaps 'is it valid refname' could be passed to a subroutine,
> or a named regexp (which might be more involved, like disallowing two
> consecutive dots, e.g. "(?!.*\.{2})" at beginning).
>
>> +            -g[0-9a-fA-F]{7,40}
>
> If we are limiting to git-describe output, we can get rid of A-F here.

Indeed.

>> +            |
>> +            # Just a normal looking Git SHA1
>> +            [0-9a-fA-F]{7,40}
>> +        )
>> +        \b
>> +    }{
>>               $cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>>                                       -class =3D> "text"}, $1);
>> -     }eg;
>> +     }egx;
>>
>>       return $line;
>>  }
>>
>
> Good work.
>
> I assume that you are using git-describe output in commit messages
> a lot, isn't it?

Yeah, and I got tired of gitweb not linking to any of the commits I
was referencing.
