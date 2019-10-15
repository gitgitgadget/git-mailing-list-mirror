Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE371F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 04:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfJOEfJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 00:35:09 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36614 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfJOEfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 00:35:09 -0400
Received: by mail-oi1-f171.google.com with SMTP id k20so15649237oih.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 21:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmussen.co.za; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRQp5AnJFeh/3Xmr6LU1U5Rt6LsZEZz3FIMPIxRzHWI=;
        b=Hbf4egPijpcVVRq/61RZr57P/HJA5L0jhSjh1vI8WlYtndx2yF4eB6gJem7Kx52NVs
         reZq/uyXo8a79wFRNn5W89bhF3Diox1ruQ8meyC5R/C4+6DTl9e9rAa4HgcdVVR/OymJ
         B1MSKSZejWx3xeunraXX0AAszzSIhu9gCHtbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRQp5AnJFeh/3Xmr6LU1U5Rt6LsZEZz3FIMPIxRzHWI=;
        b=DZJpMdulkmFIRfsH4GfQrlcyyPlMTlmqeqdTVVXzNC7a55++39kMfSVTtjMTmR2Zdt
         CHW6amwxs1R5ZXOei4AEt+itQ+IQd+lQK1Y6VYv9g9W3tEkBfgu0JPO/f/icj/jHd2Zi
         Uy05xVgz96qKQvEvRSoRF1dJyIXdq1vYZlR90r7RcqhXDpwn4JSPDlG/ynTRj6uBmKC0
         yR2CzY+TN6QuS6mzrFjDufrz+svRpdXHGipfab1Qw3RixIkOpsDYAXDhy7MDHBaiqTAL
         FTKiAliAg+WqX5DQxT2EAF2JJ5c225CyPKcJxgJ8jbZi9uGud1FtNmF4pQNV426eMPup
         EvSw==
X-Gm-Message-State: APjAAAUyMv70eXBQmtKll+PTUf9HHyrqgl4WO1xShiCqCK4AGUtk7VdR
        qAREViVNurXNGFkQXx8pgRZ/6LLR65Cijy4d5TuonDlCYvI=
X-Google-Smtp-Source: APXvYqxxhoVbCEgj6kjGg04GH8hTpdolFVQUKhzRzJWDZz+V6pcqRG2EZFlYIYJ4m1iQmV+/1HknyanDlWxIk2KZjPc=
X-Received: by 2002:aca:5714:: with SMTP id l20mr26292406oib.175.1571114106890;
 Mon, 14 Oct 2019 21:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.397.git.1571110286.gitgitgadget@gmail.com>
 <2823d4d360b2f53c1d63ba742808eaee80ede1e4.1571110286.git.gitgitgadget@gmail.com>
 <20191015042006.GC32308@sigill.intra.peff.net>
In-Reply-To: <20191015042006.GC32308@sigill.intra.peff.net>
From:   Norman Rasmussen <norman@rasmussen.co.za>
Date:   Mon, 14 Oct 2019 21:34:55 -0700
Message-ID: <CAGF1phZk9_9Se++beXxDxQZ+Y6ucrFnBWJTVJfATMYyk4=Yn=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] diff-highlight: fix a whitespace nit
To:     Jeff King <peff@peff.net>
Cc:     Norman Rasmussen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 14, 2019 at 9:20 PM Jeff King <peff@peff.net> wrote:
> There are a few lines just above that have 8+ spaces. Arguably those
> could be tabs, too, depending on your view of tabs. We usually do "8
> spaces is a tab" in the Git project, but the oft-repeated "tabs to
> indent, spaces to align" mantra would apply here (and I suspect you're
> using a different tabwidth since you noticed this one case). So I'd just
> as soon leave them be, and take your patch as-is.

Yep, the lines above are using the spaces to align the sections of the
multi-line if statement. This happens again for the return statements
in highlight_pair and is_pair_interesting. So this is the only line
that doesn't stick to the rule (and probably because of editor
auto-indenting). I have another change for the same change (which I'll
send once I've written tests) and I only noticed this line when I
changed my editor's default tabwidth after a while of coding.

-- 
- Norman Rasmussen
 - Email: norman@rasmussen.co.za
 - Home page: http://norman.rasmussen.co.za/
