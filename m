Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F2E1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdFESmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:42:33 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36084 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdFESmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:42:32 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so86883602pfg.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=phup3dwyhLEPhbXEKPvaiz44SRb3ABvSXrKmxrxMTKk=;
        b=Fh4pE2MdWxMpDjSI9u3DDy27x18wAqvJFeFsM6ZA+Pn5viROBgT3t+X2N6ElbdLvrX
         rOOn5GHFBqFxPfZ8jepuqXYBxgpet0yoGWck+yOMzSL8o6d8ZOe9YXd+Wo4LPLW/Lcpd
         YeI3P5yvC1aSihOWQh+CXVRGSWuFYJk5AtK1l34dl6+mtKsLzl1o3GUDgJCF8+UlANul
         Lwis4Pp+rpXS4qjMw5UWpmIHgRV66sktldHcVihb5qbSTlfEQED/zEWaLsDITnwd40zF
         PjAIQBmlqY98S5Mhsa2F2koz0MTCuFRZZmOt/kmKn3LWguU874Zl2B8UQ7CB6B139xxM
         /FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=phup3dwyhLEPhbXEKPvaiz44SRb3ABvSXrKmxrxMTKk=;
        b=hxziD7+tET4PkrwXoWL10lqwUE6Js9W3EqhFT/PZ1OFCwvX9YyIIyVaixh+vevt7MJ
         Iyl4aNcctyVIyrafuaCPGo4/HkVexhIkuovfouMWvzvI8+O0ZYgz79sAFBdTtvMgEhrH
         GZOgJZhLs9D1WjLlEJVQKk17Sh3cqZtX5zUWR14aXfkfOjDMOvYF5COcDYbiKya6qOjK
         Fic6P71ENdgpUEpNPf8MRDn7aIcLey395UTvDgTS+9jhBrnplK00Jz/+XnUcX9ymhEUm
         GC+JB2p9ZXOd5nzfepZNFPL1Nc4zN8IAAUSwF084FnOudz00iF6xtwQRgSlDRUI/0Ybv
         dkMw==
X-Gm-Message-State: AODbwcCyenZRSWj2fOJl8WfhQ5L3HzZ3nkb9f7kM9Alagw0nJwsNC3Qc
        VdK+ZeFNbUnKCPTEMU6h1GOTEZzYKnqY
X-Received: by 10.98.205.65 with SMTP id o62mr21694219pfg.105.1496688152036;
 Mon, 05 Jun 2017 11:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 11:42:31 -0700 (PDT)
In-Reply-To: <20170605105341.35096-1-adam@dinwoodie.org>
References: <20170605105341.35096-1-adam@dinwoodie.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 11:42:31 -0700
Message-ID: <CAGZ79kYZ2yTHxxRUjFZpFWsOWwmh6RBXRd0_a1K9kMTo4exD6A@mail.gmail.com>
Subject: Re: [PATCH] docs: suggest "Helped-by" rather than "Thanks-to"
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Genz?= <liebundartig@freenet.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 3:53 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> The SubmittingPatches doc suggests adding "tags" in the style of
> "Signed-off-by" to commit messages, and suggests some in common usage.
> However, based on usage on the Git mailing list (and in particular,
> Junio C Hamano's email to Ren=C3=A9 Genz on 23 April), the suggested
> "Thanks-to" is not common usage, and should instead be "Helped-by".
>

One data point is sure nice (and it matches my perception),
but can we do data at project scale?

The quickest hack I could come up with is

  $ git log |grep Thanks-to |wc -l
  57
  $ git log |grep Helped-by |wc -l
  676

which reinforces the underlying data.

--
So I was wondering if there is a command that shows all trailers?
Similar to a "shortlog -sne" I would want to have a list of all trailers.
This is because there might be an even more popular trailer than
"Helped-by", but we would not know when using the hack above.

While I do not think so, it would sure be interesting to have a list
of all these trailers available.

Thanks,
Stefan
