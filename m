Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E13D20954
	for <e@80x24.org>; Tue, 28 Nov 2017 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdK1OoD (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 09:44:03 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:43379 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdK1OoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 09:44:03 -0500
Received: by mail-pl0-f43.google.com with SMTP id x4so22049plv.10
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=lYWW/MOWgGvEE+DkcNDjn3FPOTVNBGIO9Ds7XXMGAnc=;
        b=nmo52fx3xR2qNM8a9ew0r+wwnOTuNZ0ahmnj1dGZhdXMdNUO9z6qe7NHkmNePxSqz+
         /A4PjCHyXhWn/ByEV+hnaIVtCaANYnL/BM12vBzQjqUWvkBqXd3Xt0sY7SAaR0Gl2yUs
         Uiu+39/O3Hiil84hWHXiY3omp3mOaknDkU2hb3ntdq3brzrKtSD9m2c4mcW80pRJIMoC
         zXEjbys7by+bOjqKKvjYCqXJwcE8A6DMPzRyY/wDXbv8D8WNGqMs2f3k6/IAy9IEGYcC
         y/3TTXXfg6eAgsHC/hEpyUYgBWCBMQTxs8RAqYZ+W+MKDcCqg+1I/EJi4/H6xzHzlBWB
         E4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=lYWW/MOWgGvEE+DkcNDjn3FPOTVNBGIO9Ds7XXMGAnc=;
        b=AzADiF+vRomO24LPg/9cOJde1ncq57DjHqzkTmkEL+T5Q7p+wwwsv2+sZigUFwLsDv
         HMrq92t8yjEjAonNtX5zTorNTZOYiIyVbX+APLGWQb7jH/3uAf4QplkoPAHWVj6xQwze
         K3d9ySLMbRDa5UIBOa8l+LXuxGAcxhp91x4wYKqehvkcwrJH5Cy5wo3id2U2hXN0XdHL
         F9SZme0LGZacWJEZaDKzwEMhn78uF2qiwRRujERqrwBPbbtu/lA3e6RLhSdrcYTsqIxy
         +H6ENbWQuturamdzocq5r4a3ufeuc0LSKrabzpl04nf3bvQp8ds6DoBWbc7n9TpwupjH
         Z98A==
X-Gm-Message-State: AJaThX72DbW+qiovtHt6ZPByCn6IrTo8Cul5N+1OWTUHe4QpWsPiRMmC
        f6ogRKm799kMj0TVG9+gDaZ1+Gl6
X-Google-Smtp-Source: AGs4zMZ4GY75e9wAKDGe7kClSrn9gBtIGamqDnxYpsj1f9Y/NC1v0IWaBpXUlvMPZtlfMqRTvCUcOQ==
X-Received: by 10.84.231.196 with SMTP id g4mr35308810pln.62.1511880242311;
        Tue, 28 Nov 2017 06:44:02 -0800 (PST)
Received: from unique-pc ([2405:204:7344:993e:9a3:d467:14f5:495b])
        by smtp.gmail.com with ESMTPSA id t4sm49374686pfd.110.2017.11.28.06.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Nov 2017 06:44:01 -0800 (PST)
Message-ID: <1511880237.10193.5.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] Doc/check-ref-format: clarify information about
 @{-N} syntax
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
In-Reply-To: <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
         <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
         <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
         <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 28 Nov 2017 20:13:57 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-11-28 at 11:40 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > When the N-th previous thing checked out sytax is used with
> > '--branch' option of check-ref-format the results might not
> > always be a valid branch name
> 
> I wonder if you want to rephrase this, because 40-hex object name is
> syntactically a valid branch name.  It's (1) cumbersome to type and
> (2) may not be what the user expects.
> 

You're right. Actually a previous draft of that log message did say
something like,

	Though a commit-hash might be a valid branch name, it isn't
	something that's expected by the users of "check-ref-format".

I removed as I thought it would be unnecessary. It seems I took the
wrong decision. Will fix it. :-)

> I have a mild suspicion that "git checkout -B @{-1}" would want to
> error out instead of creating a valid new branch whose name is
> 40-hex that happen to be the name of the commit object you were
> detached at previously.
> 

I thought this the other way round. Rather than letting the callers
error out when @{-N} didn't expand to a branch name, I thought we
should not be expanding @{-N} syntax for "check-ref-format --branch" at
all to make a "stronger guarantee" that the result is "always" a valid
branch name. Then I thought it might be too restrictive and didn't
mention it. So, I dunno.


> I am not sure if "check-ref-format --branch" should the same; it is
> more about the syntax and the 40-hex _is_ valid there, so...

I'm not sure what you were trying to say here, sorry.


-- 
Kaartic
