Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACE61FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 00:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758064AbcLQApD (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 19:45:03 -0500
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36771 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755792AbcLQApC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 19:45:02 -0500
Received: by mail-yb0-f179.google.com with SMTP id v78so43642192ybe.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N3Rglp0DYrUSXWwcLDrAKb83b8nPBP2tI95go9/w4AA=;
        b=A8NsPC1RyjPxkF4or88kZPdMUpW4+FWbVHesbPSd00yYkRECf3P14h5GyFyCPtepf0
         mBuCMmYR0t6FmKtMOe4nmS5a4x/qHXtG1a2M5tcOZcpf2mY9mkQg8WhyooxSK5Yd+vwp
         8w4XvCr9PSfuBo9xTlXSY1/Dv4Kyuf+pgFTQqDZtM2eHSw9XuPoI1L6mlKipDIY+SWIv
         DMohctdrXM1EL+2g1vdaA3E/S7jWBz92of0ZJl0SNGEz/H9s3fRvHgxoUY0URaIU99b+
         Jokdk087/uBDdob0l6KSfjP6FO5imrLU+AvRxb95FaXORqWz2wOytiXawcuD9gyzpQ/q
         F6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N3Rglp0DYrUSXWwcLDrAKb83b8nPBP2tI95go9/w4AA=;
        b=DPYgtCj+suI6Lqyre7qiW1xb4Jn0E3CLwCPFjFaEbKEAtZl4CMJpeEVBUcskVWhtiR
         iHL4Ayi09vR6Kpj3zdjERGGfaH1byZH614nyXvkk3UiafJMAWWFVDH1DjidEhmq0oRdO
         FmVjmsTV+ORe6I4+h3EJDqo0GSChqvu3iHjZVqdZNneo0aP82QrMhHSWPfKSwYDKUHzu
         tyAG/7FMQzklyvFb2t7H1QcJX1WkDmi+FAxsZxbfySg4lI6nJGlZ3p4ZvOWlJbnnPyy0
         M05usHZv6MZ1s1KsTAg4ghviQNdNHP7lOx5yUt7VskEhY/GZzpAGySJFad2RcJpoUDtU
         e3mA==
X-Gm-Message-State: AIkVDXK1ugNcN/wqav6AmxPJe4KX+3UVscnxDDXf4akKhIWpbjyhTWqncMDL84ZxDtbxfTR7CsxLIYUJ1vum5Q==
X-Received: by 10.37.161.198 with SMTP id a64mr4536086ybi.72.1481935501842;
 Fri, 16 Dec 2016 16:45:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Fri, 16 Dec 2016 16:44:41 -0800 (PST)
In-Reply-To: <CAM+g_NsDLKxWLZCDOgrh2O3W23PRP8Zxf-Zzf_twSw5VX3=G=A@mail.gmail.com>
References: <CAM+g_NsDLKxWLZCDOgrh2O3W23PRP8Zxf-Zzf_twSw5VX3=G=A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 16 Dec 2016 16:44:41 -0800
Message-ID: <CA+P7+xqBwdoHNVFrgwFXn48YtggatrFiBwbAt6+KZ+iG4oznqw@mail.gmail.com>
Subject: Re: indent-heuristic, compaction-heuristic combination
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 4:28 PM, Norbert Kiesel <nkiesel@gmail.com> wrote:
> Hi,
>
> I started using compaction-heuristic with 2.9, and then also (or so I
> thought) enabled indent-heuristic with 2.11.
> Only after reading a comment in "Git rev news" I realized that these 2
> options are mutually exclusive.  I then
> checked the Git source code and saw that Git first checks the new
> indent-heuristic and then the old compaction-heuristic.
> Therefore, anyone who is as stupid as me and enabled both will always
> (and silently) end up with the older of the
> two.
>
> Apart from better documentation (I know that both are marked
> experimental, but nevertheless): could we not swap the
> order in which they are tested so that the newer heuristic wins?
>
> </nk>

I looked at the code and I don't think this is the case. In
diff_setup() on line 3381, we check indent heuristic first. However,
when we check the compaction heuristic second, we use an "else if" so
we do not set both. I believe it already performs indent heuristic
correctly if you enable both options in configuration.

Thanks,
Jake
