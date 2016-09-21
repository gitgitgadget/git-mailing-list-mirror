Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A936209A9
	for <e@80x24.org>; Wed, 21 Sep 2016 14:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbcIUORd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 10:17:33 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33822 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbcIUORc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 10:17:32 -0400
Received: by mail-qt0-f182.google.com with SMTP id 38so23031918qte.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ThbS2ld5UGz+2Bddl/h9xwlGAySvXAbggeeMIxAPTJM=;
        b=DP3JjlfDxhIE72e6MWqqRKIu1CNpU9vHBi9guMoyeMj8qMI+EUov1yMDr82aYOx7SK
         llrefIsLR58Z8BKZ6vfyaAE2UQPu1JfumwZC1mWLgBveeKxRrwebquU9hOZ1s0kZOLsw
         wu9LMrc9ib3ePHBzChQlIyOWMWNuDwFJvFVF+e4+L6jvkD+/gVo9+2Pf6K7qZYR5GzD+
         8lDDiiai/4kuaihiv/jsnSb9+DTh9q1aTCnqeafxy+UiWr3wcygCQ4r1goeH0FBLMgiv
         AulriDLNkU+BGCsfxWHKOg7HmYzc5/SybzMnTxDm3aJm/edbsvi2cKQltcWRW3J26KLX
         Ycdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ThbS2ld5UGz+2Bddl/h9xwlGAySvXAbggeeMIxAPTJM=;
        b=HgDHv39BfhG6raLNj2MBgbgdYWBSX/eBH7f8mJC8ycBoIg6BxGcnX6VcXC37gd4FDj
         GFOsRlEwAM8/4kEr0EQZqLuCH+Y1+v5qd1/2ZJm/BqUs/oNi+RjggE514gwO6VkEbh88
         Ki1jin418ysNstYxSYe2cBMvhAtcxSnYYvVDwxm9+StNrxDn4JnbfSR3eKo67TTawm6b
         AsowEAA3YM9gcJd6m8gsapBzfEzOYBffZuG3ifr9hZCgNRZOyfenHwQKlf1tAoJU66nw
         i00mQCiFaRjNO2LDpZDETea3th6OR+5hLlT8ozk19z6E0cg2wgPbyIPYjZvLxYoUIyo0
         66Mw==
X-Gm-Message-State: AE9vXwMmxwCUlRK0p7Vn1UhQSOO9OtSlIw0kXOhGJ0yLVKB2KSQqjPnSpadYsVGwMBO8FjnGMBWZ9ZfsZrcvyQ==
X-Received: by 10.200.38.241 with SMTP id 46mr41933988qtp.135.1474467451534;
 Wed, 21 Sep 2016 07:17:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Wed, 21 Sep 2016 07:17:11 -0700 (PDT)
In-Reply-To: <d047a76d-8f13-5c90-3946-6821957d9278@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com> <d047a76d-8f13-5c90-3946-6821957d9278@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 21 Sep 2016 16:17:11 +0200
Message-ID: <CACBZZX4QDTNYDpOF+GsK3tMQamoXQhJoXuPTgB3O+iEW3jBxag@mail.gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g0866786
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kay Sievers <kay.sievers@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 3:33 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 21.09.2016 o 13:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason napisa=
=C5=82:
>
>> Subject: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g086678=
6
>
> It is more "ancient typo from v1.7.7-rc1-1-g0866786", but perhaps more
> important is "ancient typo in a comment"

Yeah, will rephrase.

>>
>> The Content-Type is application/xhtml+xml, not application/xhtm+xml.
>
> Right.  Thanks for the patch.
>
> Signoff?

Blast! I forgot that for these 3x patches. I'll re-submit pending
further comments on the rest of the code changes in the series.

>> ---
>>  gitweb/gitweb.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 33d701d..9473daf 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1616,7 +1616,7 @@ sub esc_path {
>>       return $str;
>>  }
>>
>> -# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
>> +# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)
>
> Nb. I wonder how common is use of XHTML nowadays, with HTML5 as standard.=
..

It's sent to modern browsers, I noticed it because when doing the rest
of the patches in the series the slightest mistake in the HTML syntax
would cause the page not to render in Chrome, because
application/xml+xhtm activates its anal parsing mode.

>>  sub sanitize {
>>       my $str =3D shift;
>>
>>
>
