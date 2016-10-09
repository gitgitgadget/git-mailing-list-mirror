Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B307520986
	for <e@80x24.org>; Sun,  9 Oct 2016 11:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbcJILVJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 07:21:09 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33274 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbcJILVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 07:21:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id m5so2499118qtb.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=44WatMpC5mopZcDeexCmVF0FgPc9pU5OoxjcSdqcGjY=;
        b=RPYPIeMl5Tht7MKjD2p2H9V3nonErMZSARSoBU564HOoo0nCJoC3BYRJkHJXt5WE92
         6pQcFWEqRnumUQa0IqxgFcTgu4Vc0itfKj4Vv9rB/TD9x+fVNBK78ZNcHLIweSFPbyZa
         lu27Lh/wJEWut4uGWiUcrzw3thHcQkCi0slWp1QA9UZ8uKmlyjDbGttuseuOcw4kKogr
         bk/HgWSJqvyPcLOKQDuzHK1thKRPmNagbmNqpTgK+jb2a2LcJTdyGzaLemqiWZ9ID2ZQ
         P23wsY1AKWjHA8AXIy86BHK98Sdf0ioYZ3NUBKEQ5Wg28/Q9r6u8GcWyzVkertNghDcZ
         9xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=44WatMpC5mopZcDeexCmVF0FgPc9pU5OoxjcSdqcGjY=;
        b=OvbQc33KolVZfWn98Vusx5zOddYwF6yBrEU644/spi1gY4Lmp9O+ubD8o8BmIrEhS6
         0TBGfdYGRYVrz81pYkfkfhu2uPJb4Rk9RsY9+h7EJViODDSkDgVc96HnzfvX4s18Vyzp
         potAQ+hg7NkLvcBP3KDC+4dCsyPKHFMyx6aRFSaKMwP6wLHviRzsaoJYk11HwFgkO4Cq
         IZzdzXxzXaRKtwxpaLmSHpN8OBRqAHj28Fu+ihl71tCD1UvVvLmHoBzvEVsV8DiigB1c
         EFstontTFE50Ia7vn8cb7+3D8DHvtRrz6+1y/KW84gNdczVyPuSe94CAsuC+XemknOCe
         mKvQ==
X-Gm-Message-State: AA6/9Rkn4DSvx4JkN1Af4byL9VJL6b0WkdUEaubDDbB9qLr6M2H4TdAUFzCwKo36YpkZjV6RqnVehJXAx0TGWQ==
X-Received: by 10.237.34.212 with SMTP id q20mr27948971qtc.14.1476012067962;
 Sun, 09 Oct 2016 04:21:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Sun, 9 Oct 2016 04:20:47 -0700 (PDT)
In-Reply-To: <xmqqy421i7dg.fsf@gitster.mtv.corp.google.com>
References: <20161006091135.29590-1-avarab@gmail.com> <20161006091135.29590-4-avarab@gmail.com>
 <xmqqy421i7dg.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 9 Oct 2016 13:20:47 +0200
Message-ID: <CACBZZX5mnCmzT3N35YKpr2t1LT-hh-H7eS-+XTjudguedJL5Zw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gitweb: Link to "git describe"'d commits in log messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2016 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the log formatting function to know about "git describe" output
>> such as "v2.8.0-4-g867ad08", in addition to just plain "867ad08".
>>
>> There are still many valid refnames that we don't link to
>> e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
>> v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
>> similarly it's trivially possible to create some refnames like
>> "=C3=A6/var-gf6727b0" or which won't be picked up by this regex.
>
> Not a serious counter-proposal or suggestion, and certainly not an
> objection to the patch I am responding to, but I wonder if it is so
> bad if we made the 867ad08 into link when showing v2.8.0-4-g867ad08.
>
> IOW, in addition to \b followed by [0-9a-f]+ followed by \b, if we
> allowed an optional 'g' in front of the hex, e.g.
>
> -       $line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
> +       $line =3D~ s{\bg?([0-9a-fA-F]{7,40})\b}{
>
> wouldn't that be much simpler, covers more cases and sufficient?

It would be more simpler, maybe that's the right approach. I have a
preference for making the entire reference a link. I think it makes
more sense for the UI.

>> There's surely room for improvement here, but I just wanted to address
>> the very common case of sticking "git describe" output into commit
>> messages without trying to link to all possible refnames, that's going
>> to be a rather futile exercise given that this is free text, and it
>> would be prohibitively expensive to look up whether the references in
>> question exist in our repository.
>>
>> There was on-list discussion about how we could do better than this
>> patch. Junio suggested to update parse_commits() to call a new
>> "gitweb--helper" command which would pass each of the revision
>> candidates through "rev-parse --verify --quiet". That would cut down
>> on our false positives (e.g. we'll link to "deadbeef"), and also allow
>> us to be more aggressive in selecting candidate revisions.
>>
>> That may be too expensive to work in practice, or it may
>> not. Investigating that would be a good follow-up to this patch.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 92b5e91..7cf68f0 100755
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
>> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with =
-
>> +            [A-Za-z0-9.-]+
>> +            (?!\.) # refs can't end with ".", see check_refname_format(=
)
>> +            -g[0-9a-fA-F]{7,40}
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
