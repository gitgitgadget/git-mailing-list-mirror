Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E001FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 00:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbcLQAqE (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 19:46:04 -0500
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35693 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756547AbcLQAqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 19:46:03 -0500
Received: by mail-yb0-f175.google.com with SMTP id d128so43544307ybh.2
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D2r0hxz+fUOUga1fNgd5UoGZLdBBd4zvuEwk5K3kmXQ=;
        b=Ky4cbJPY+YQHNWYNcbKfhfwDh6y0gk28e/rJBy/rOlnmJoPKDYxiCvSYrtMWbmcLTE
         5mjn0xqr4Z3lbT+qgd67CWiFOa6P7ezwBlute+3pcwtg5PU+92FnUCikJicirTe9JjLy
         PddaP8wB7lQBUcc4NDbvfQw808earGDPNdzDCYu7CelBF3spOASkvxflzAlO1hRBJIf+
         npXI+59Ro8r6/36HUPlQm1s2B5fWtVdZQsh84JstMkmWPf7Hn2UQKt1UARl83qcRKPR8
         SwrjQJ9BAxcBNRMa13+sDyIxxHYN6O+1zMr8J+ng4loPw16u3tiIC/JwtirNqERvQ83s
         GP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D2r0hxz+fUOUga1fNgd5UoGZLdBBd4zvuEwk5K3kmXQ=;
        b=TXRLi0hQ0U+gUK7+4T00eoc4bgjpbN53hFk5JMaWCyEY3anT20qr3KgfVU84MTOJMk
         j+D3szRCnPa4+zkwMtT8sBNAlIzoqPGvSJPcPAJV/MD5FAcdOHisc2X1j2GdliUcWMTU
         N39yMRmYd0VCvJ6E/VnMn2vXPG8ZOldNXgpW5lL7Dpg61gbjFjBS48Guqci9UMU5M7ip
         DKlQs7ZhvE119spbh1IWpqMvEx20mok/beSLpWCvz6BYo1UsjGQ/5vA7pIvXF4yB4oRM
         44EtuK2IYIyzPOLP14qQVHN9ebdr+yHZdHDoXbA9SLiNbvXLZZBbLWYcEtMn2LL58NX8
         Pgnw==
X-Gm-Message-State: AIkVDXJyg9aV33xmiGpJ5Z9ABYPV3nibMzu3UMYBsLDCsKVTo6OBYdg/xtU6RDzR0e6k3vtBbhzFDICnI1Tl6Q==
X-Received: by 10.37.19.135 with SMTP id 129mr3635087ybt.119.1481935562271;
 Fri, 16 Dec 2016 16:46:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Fri, 16 Dec 2016 16:45:41 -0800 (PST)
In-Reply-To: <CA+P7+xqBwdoHNVFrgwFXn48YtggatrFiBwbAt6+KZ+iG4oznqw@mail.gmail.com>
References: <CAM+g_NsDLKxWLZCDOgrh2O3W23PRP8Zxf-Zzf_twSw5VX3=G=A@mail.gmail.com>
 <CA+P7+xqBwdoHNVFrgwFXn48YtggatrFiBwbAt6+KZ+iG4oznqw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 16 Dec 2016 16:45:41 -0800
Message-ID: <CA+P7+xqECPzGd0MoXXDM6m7LMiYXs4=U+pUey7BRLfv+XQYJ_A@mail.gmail.com>
Subject: Re: indent-heuristic, compaction-heuristic combination
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 4:44 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Dec 16, 2016 at 4:28 PM, Norbert Kiesel <nkiesel@gmail.com> wrote:
>> Hi,
>>
>> I started using compaction-heuristic with 2.9, and then also (or so I
>> thought) enabled indent-heuristic with 2.11.
>> Only after reading a comment in "Git rev news" I realized that these 2
>> options are mutually exclusive.  I then
>> checked the Git source code and saw that Git first checks the new
>> indent-heuristic and then the old compaction-heuristic.
>> Therefore, anyone who is as stupid as me and enabled both will always
>> (and silently) end up with the older of the
>> two.
>>
>> Apart from better documentation (I know that both are marked
>> experimental, but nevertheless): could we not swap the
>> order in which they are tested so that the newer heuristic wins?
>>
>> </nk>
>
> I looked at the code and I don't think this is the case. In
> diff_setup() on line 3381, we check indent heuristic first. However,
> when we check the compaction heuristic second, we use an "else if" so
> we do not set both. I believe it already performs indent heuristic
> correctly if you enable both options in configuration.
>
> Thanks,
> Jake

On further looking, I realized again that maybe you are right. I will
send a patch to change the other spot where we might prefer the older
heuristic.

Thanks,
Jake
