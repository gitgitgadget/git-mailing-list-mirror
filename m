Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422891F404
	for <e@80x24.org>; Sun,  4 Mar 2018 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeCDT63 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 14:58:29 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33505 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeCDT62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 14:58:28 -0500
Received: by mail-qk0-f175.google.com with SMTP id f25so18272122qkm.0
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 11:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=O50o1E+OPz5MfBh/WfkxVt8ASrsUPjB4IrrI6B5tKwA=;
        b=RPlnG3h5DoiFK8vtmvGokcRpCL4pMg2IJ4b8rMnzeeHS1WTE5szfKWvpSD1fqJ24jR
         Tc0rvjLclGQJgy6kIb+H5pkLTFf9TXx7GO5JLbHDrNt3KwOs3k2Nz/GpUd9NjeyJ6lo5
         /LBEzOrnRh+PKNl4VvrPEGbJ6qxWLU3TBUWfCPlrgZWIgj7g08h9rDox/FApLimXJGdf
         tVfLksKDZwsIS8UbClfQm/0wjO5/TE/353Eu58Tavn47DmssfV88dkDjrHZhm43TQ+bj
         O63CER8j1WzNsvFumZ1BmtrIgeI31ioGKMaw4rjeg/jc4zYBOq8Cpl1/X//aicLH65Hj
         VwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=O50o1E+OPz5MfBh/WfkxVt8ASrsUPjB4IrrI6B5tKwA=;
        b=FDmPBMhIKl5lFdxw+fxxvA7EC7xYDmNG+vWucg/nhvuKqYbabj2VAogEMRYhRoNT53
         YSp3PsaoJFpyGzHL+eP8MY5MDSs6MF3SVKdlb9xsMTb0nuzTvk+Ztv895YULG6UrkRS6
         II2qDmecJaHV3r1hi/lNfzrgkwTvQnVjUAOL659Zjy0yMc5XNYujokL3AzEENXnJq3Uy
         LDj1wf5yBdE6wAbPNoNkJOTaFDEYm9UN90u8kAxE+DL8PbfNeBrxE/lvnnT+NLPqJ95Q
         3gsNbJBMk/fXDdKEOsP8h9BuOCGdZtnBNqsh8Kb0NgudsigCiCaHTtTB7ophbWDR2rXJ
         5Yow==
X-Gm-Message-State: AElRT7E/Cd6wlS5I1zySerOfNbPru7ysQ3Ojj9qyH+k7e1vFl5glK3Sm
        G9TOqeooXZBvtumEZklqcTMMSR+jW6OTXxmCPKcjlA==
X-Google-Smtp-Source: AG47ELvE1jS86v0PRELbSXizUEwholp0AmdnakHq9198x5lU9PE0UfdTPOJ+wzmoLBQ7T22Mxu8ijgg943Bz91xZhng=
X-Received: by 10.55.133.131 with SMTP id h125mr19299384qkd.79.1520193507362;
 Sun, 04 Mar 2018 11:58:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sun, 4 Mar 2018 11:58:26 -0800 (PST)
In-Reply-To: <5955B68D-B6E3-43C0-8C70-47E37F1204E1@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
 <20180224162801.98860-8-lars.schneider@autodesk.com> <CAPig+cR81J3fTOtrgAumAs=RC5hqYFfSmeb-ru-Yf_ahFuBiew@mail.gmail.com>
 <5955B68D-B6E3-43C0-8C70-47E37F1204E1@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Mar 2018 14:58:26 -0500
X-Google-Sender-Auth: DCAOpz-4xtKwe6gHYZuP4MBTliY
Message-ID: <CAPig+cR1zEn0ktDtQnUt2272gZ04S-Ssg7Vzja6QZejTLN_fbQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] convert: add round trip check based on 'core.checkRoundtripEncoding'
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 2:08 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>> On 25 Feb 2018, at 20:50, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Feb 24, 2018 at 11:28 AM,  <lars.schneider@autodesk.com> wrote:
>>> +               if (!re_src || src_len != re_src_len ||
>>> +                   memcmp(src, re_src, src_len)) {
>>> +                       const char* msg = _("encoding '%s' from %s to %s and "
>>> +                                           "back is not the same");
>>> +                       die(msg, path, enc->name, default_encoding);
>>
>> Last two arguments need to be swapped.
>
> Hm. Are you sure? I think it is correct as it is. We are in encode_to_git()
> here and that means we encode *to* "default encoding", no?

Okay. I guess I was just looking at the most recent
reencode_string_len() -- and maybe overlooked the "and back" -- and
was thinking that this error message applied directly to it, but I see
your point about the error saying something about encode_to_git()
overall, in which case I agree with you.

>>> +       test_config core.checkRoundtripEncoding "garbage" &&
>>> +       ! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
>>> +               grep "Checking roundtrip encoding for SHIFT-JIS" &&
>>> +       test_unconfig core.checkRoundtripEncoding &&
>>
>> The "unconfig" won't take place if the test fails. Instead of
>> test_config/test_unconfig, you could use '-c' to set the config
>> transiently for the git-add operation:
>>
>>    ! GIT_TRACE=1 git -c core.checkRoundtripEncoding=garbage add ...
>
> Agreed. Although test_config (in t/test-lib-functions.sh) automatically
> unsets itself after the test is over.

Yep, so you could get by with that alone. The test_unconfig() simply
isn't needed.
