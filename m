Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632801F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeGTW1w (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:27:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54035 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeGTW1v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:27:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so10697286wmh.3
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S318dVUGGnmDonxDW1PAVxqcUvxsiZUtQjB90ZRzKCY=;
        b=FUnUrfKOrb7PfP9sdpbIPCmMzIg2IWF8ik4F5nt1wQS2nEyT7/X3owEnl4vZTh6QiG
         MuDY4Sa3Xfwn1G4wJOVBLgN+C0ZCyALWMVJk6ibBwrW9yppIVSIXj6efcZ4taPMNOmm2
         h2eMXLdE3U75prg2rayMb+/+zSUOmuv2hRaglGbQYaWGUvR18aaiFppOfbmwYKolzbBI
         JfW7tf66KELVMw5b6WLgCKs0NSBQ11DblUVWlticFp2hiGQThp20Ak+yfKlX0BiozpYJ
         NAZMr9Co2aN5JhuYyDDxuzc403TAOUUkQidA3BoMYKau5l7mOMaPYjwUI1k03qthiRkl
         dDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S318dVUGGnmDonxDW1PAVxqcUvxsiZUtQjB90ZRzKCY=;
        b=t0Y6eCWUJX6Qs4KXRXvwUhcSGF2e9LN0Xz1tRJAq4yjH8ccjBNHqB9gbZCGTkkaG/0
         a8Ngrf6hZCWyA5oAVAwxR7qhoLuzLKu2p6cQljeGWNjTTZm3skurTs4XcpLSC8VtUEP9
         havT+fFEFWBS6me8pvLNhp3nmHQ3XHccxOgZpuEfWcu0oD0Zudw5jXbquoybUXuKMVgy
         E2jchNbitcdHQEibEfYH43o4g8CEjxN8Xf0ZHpvIvN+ZsbrrspVKeqWRdUSCIusXsmNS
         4a3wew9lML8CtA6aSVJDtVm9+5IdDvb1iOqce8myBIJ+zuMmI5wJspp9bf4pvN7s5AaE
         utQQ==
X-Gm-Message-State: AOUpUlG0pmpL6xiNzWnX1Js/SH875eHplh3nN3MTVtgKtn5xEb4S59SA
        zv/uWS4I8bn8yPtcxd6k0h8=
X-Google-Smtp-Source: AAOMgpfhneDU+rhEGQDPy8AXtT3qScfoyNzCYGJTokDEqoNLA/IqwLN1jcW1W+t/f7RVNeAjQ5IMsg==
X-Received: by 2002:a1c:ac42:: with SMTP id v63-v6mr2553072wme.92.1532122664159;
        Fri, 20 Jul 2018 14:37:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w21-v6sm3057707wmw.29.2018.07.20.14.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:37:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Basin Ilya <basinilya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: error: invalid key with file url insteadOf
References: <7ac8e749-0636-cac4-35c7-1226f340e72f@gmail.com>
Date:   Fri, 20 Jul 2018 14:37:43 -0700
In-Reply-To: <7ac8e749-0636-cac4-35c7-1226f340e72f@gmail.com> (Basin Ilya's
        message of "Sat, 21 Jul 2018 00:27:58 +0300")
Message-ID: <xmqqk1ppa8rc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Basin Ilya <basinilya@gmail.com> writes:

> Hi.
>
> I'm trying to make the Cygwin Git understand Mingw-style repo urls:
>
>     git config --global \
>       file:///cygdrive/c.insteadOf \
>       file:///C:
>
> But this fails with:
>
>     error: invalid key: file:///cygdrive/c.insteadOf

Understandable.

> Manually editing ~/.gitconfig works fine:
>
>     [url "file:///cygdrive/c"]
>             insteadOf = file:///C:

How about spelling what you want to happen on the command line
version the same way as your "manual" version?  I.e.

	git config --global \
		url.file:///cygdrive/c.insteadOf \
		file:///C:

notice the lack of "url." in your version.
