Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868341F404
	for <e@80x24.org>; Thu, 21 Dec 2017 01:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756536AbdLUBz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 20:55:26 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:41370 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755928AbdLUBzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 20:55:25 -0500
Received: by mail-pf0-f182.google.com with SMTP id j28so13342257pfk.8
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 17:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6IlMv6UfY0gzJXuXRTs47o1WOFPN/5CAaOdQKDzDBZ8=;
        b=lNGM2VIGHGbWh5CqdUqqHGGWJ7bC0MOzndo1WUBFtXkbkW9TOiwNsuYqLocdC7F+bO
         HFBXbsj3Ib7SFSx8a+YVHG42kCn+z6PIuFP97KtI+4Hn6uYdBTXaoKGmF1jaAQ5SVNU3
         ke+dfh45Nhll/ZfolJYnXIr6Iy0PFijLzQyZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6IlMv6UfY0gzJXuXRTs47o1WOFPN/5CAaOdQKDzDBZ8=;
        b=LlN8ShH7tpkoC5a0x9sNcwHtD+h70yul0+rgCO8BCt12M7jwdeqbOnPri1WbT65KJm
         3xYFTJMXgPa5XZhjQ9GUPFiD0JhNpRbr5SURxWp4x3ofGY99yU9wUxFFqBhN+C/uUbHN
         zYSeV2Kt6g58ZhJfud+J9jEx0NbsL+RZmdIzuAUt+GCDrMYDTSEe9+H8zHgt5Uuj9O/J
         ZFyii1GFxbH8SPjuiWTlM6z2n4+AaqRA4Exo8nOiLsiStA0RNeQPEmOGovXIwi0VcarO
         8WUH6lQeUw5zIHcG8g/kUmeMaySbbeE8AgJFmcULgUWPlsylvT+CbfDqzKy4FtmgB5dG
         uqvg==
X-Gm-Message-State: AKGB3mICyIpSxgDN68fxi/C0PWJCjHFpdr7DgOEe7zcSiLfYkHczfDFv
        ZEdlBCarpoYBRTfsW8CedcO47Q==
X-Google-Smtp-Source: ACJfBousLeXr4PAM+NLg2rx3RqyF4joG2XP8FQ5zGcApuzaySreOOrwixc3zzY/5Hah738nhc90tvw==
X-Received: by 10.98.163.73 with SMTP id s70mr8712942pfe.64.1513821324470;
        Wed, 20 Dec 2017 17:55:24 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id s14sm40398566pfe.36.2017.12.20.17.55.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 17:55:23 -0800 (PST)
Date:   Wed, 20 Dec 2017 17:55:09 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/6] fsmonitor: Add a trailing newline to
 test-dump-fsmonitor
In-Reply-To: <xmqqlghyv4wz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.10.1712201744270.15915@alexmv-linux>
References: <20171219002858.22214-1-alexmv@dropbox.com> <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com> <dab89f071d22a21b85dff5d31e9e9a8ceb6458e3.1513642743.git.alexmv@dropbox.com> <xmqqlghyv4wz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, 19 Dec 2017, Junio C Hamano wrote:
> That (and existing) uses of printf() all feel a bit overkill ;-)
> Perhaps putchar() would suffice.
> 
> I am not sure if the above wants to become something like
> 
> 	for (i = 0; i < istate->cache_nr; i++) {
>         	putchar(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID ? '+' : '-');
> 		quote_c_style(istate->cache[i]->name, NULL, stdout, 0);
> 		putchar('\n');
> 	}
> 
> instead of "a single long incomplete line" in the first place.  Your
> "fix" merely turns it into "a single long complete line", which does
> not quite feel big enough an improvement, at least to me.

The more user-digestable form like you describe already exists by way
of `git ls-files -f`.  I am not sure it is worth replicating it.

The only current uses of this tool are in tests, which only examine
the first ("no fsmonitor" / "fsmonitor last update ...") line.  I find
it useful as a brief summary view of the fsmonitor bits, but I suppose
I'd also be happy with just presence/absence and a count of set/unset
bits.

Barring objections from Dscho or Ben, I'll reroll with a version that
shows something like:

    fsmonitor last update 1513821151547101894 (5 seconds ago)
    5 files valid / 10 files invalid

 - Alex
