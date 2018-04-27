Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB5C1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759310AbeD0Vpu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:45:50 -0400
Received: from mout.web.de ([217.72.192.78]:49931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759305AbeD0Vpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:45:49 -0400
Received: from [192.168.209.26] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpJ4-1eZ0xh24e6-00oDOC; Fri, 27
 Apr 2018 23:45:47 +0200
Subject: Re: BUG report: unicode normalization on APFS (Mac OS High Sierra)
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BEe+BK6Ew0ZLnkgCn=1J6kyJa5VTaibuJOEVeDdgLd_Ow@mail.gmail.com>
 <94c6fa4d-afe0-5a08-f844-85d3c091d3b2@web.de>
 <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
From:   =?UTF-8?Q?Totsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7f9feab0-3638-56cd-18bb-4de0122aabad@web.de>
Date:   Fri, 27 Apr 2018 23:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xQ4hdVNRgLbdSjN/CPdzcJNzDAEHjP45TrRREdGE8IZwt+OeBnc
 jCf54M28TiuF8AbrD/uG2cH9jD8oQIdl4jIxiET8g7gyG/xRqDj0NDkEoC0pAMCmYYdY1ZE
 iIvhN3aI++Qjw0N6Lw4AyQdDHInIKxcVSFxlKyF2Xy/fozNQgaREkw8ERMQcug+INnwjR2U
 Y6wHqvhA0/WV93p+dVALA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T2eAy7Twy5c=:v5GAeAp0zb2ihTTPhLMsE8
 5SWEiYXZ8qwcfYUsoDKupWr0N8JWTppSmoTAP/8EvOR0bG9SxUbnQZx27+lni64M/Tlzavr9n
 F2hpOdchUBAlf1QKV2Piiyw8/dbtYrNt6kZlsZUw2U1ZMuLnjkRHdMxQjDBU3TXNaz+PhnbiW
 CTDRTwakZOF9s5wl6MCJN77plfbUpt/OojObpgwfEhyg1tftV4UXmB6YwQgLC8YSjesezwJJQ
 wQgR2+3NwLW9vbgDheJOM8Yf0P8nZGS8NeBsLWTFmOyanKmdkseRQa+jp/3YYYjopoVheY97+
 ReO5KlyvzQhKa4CaZqUM5ioajV/PM9QhfNQjrEyJEH74zIQ5VIvxLfx+3JBbZ7JeZPp+W2DTR
 3Ptz9YKK9wuVlJFW6F7D0QZz9CUcQt1z3SgJFwh3MHc/oucWidCAVTZfIHhAbHSnL0z+ddKPp
 MYagKO9pFIFBz759BAbTFKRWSf25LZPEFClYhyDRFzn6m50WRBHLupHRHSSbrXnoSoMWFVoI4
 59hrYi3ssmO6DNAe3jUn0pboDoCzIBPpjmo1/NO3IHG+VyMMNhK3oolVKxSeudmln8gW/hlLy
 aX9Kr70RjQe+4o4EdzEg7TmDbxn0wXcMxnIMSVqdjIIIDcq4DlJ7eMeSoOFbtBK5jinVOzX71
 c94WeTUEQBDM50N2PrLHEwcm2+dgDORokIUvUllWs+w33J4PsS4KQdQ3hkJwei4rLaB8U+u/f
 awnw/BfziyWQ0fpbcgbXUeo0wRuTbCJQF1WLmnB13uEYUhycU7o67BS4Y/pcf/GZ+V6B8m7sa
 Lqr7Ywe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2018-04-26 19:23, Elijah Newren wrote:
> On Thu, Apr 26, 2018 at 10:13 AM, Torsten Bögershausen <tboegi@web.de> wrote:
>> Hm,
>> thanks for the report.
>> I don't have a high sierra box, but I can probably get one.
>> t0050 -should- pass automagically, so I feel that I can do something.
>> Unless someone is faster of course.
> 
> Sweet, thanks for taking a look.
> 
>> Is it possible that  you run
>> debug=t verbose=t ./t0050-filesystem.sh
>> and send the output to me ?
> 
> Sure.  First, though, note that I can make it pass (or at least "not
> ok...TODO known breakage") with the following patch (may be
> whitespace-damaged by gmail):
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 483c8d6d7..770b91f8c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>          auml=$(printf "\303\244")
>          aumlcdiar=$(printf "\141\314\210")
>          >"$auml" &&
> -       case "$(echo *)" in
> -       "$aumlcdiar")
> -               true ;;
> -       *)
> -               false ;;
> -       esac
> +       stat "$aumlcdiar" >/dev/null 2>/dev/null

Nicely analyzed and improved.

The "stat" statement is technically correct.
I think that a more git-style fix would be
[] ---
+       test -r "$aumlcdiar"

instead of the stat.

I looked into the 2 known breakages.
In short: they test use cases which are not sooo important for a user in 
practice, but do a good test if the code is broken.
IOW: I can't see a need for immediate action.

As you already did all the analyzes:
Do you want to send a patch ?
