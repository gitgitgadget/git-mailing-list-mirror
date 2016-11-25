Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A051FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbcKYTk7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 14:40:59 -0500
Received: from mail-wj0-f171.google.com ([209.85.210.171]:33957 "EHLO
        mail-wj0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbcKYTk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 14:40:58 -0500
Received: by mail-wj0-f171.google.com with SMTP id mp19so66741991wjc.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Ai1LHUot21oPEBHVaxNwDK1Rq7+XpjKILesCWblzHSU=;
        b=HVLa08TSLiMfxpvCWeuargrCOlNDjD3pyRS8Gvu6rNItpQ3WoU2KWiFj+IogKxv3uc
         zzmNxVK8RssfEySGJandoHE4vr2qdi4tXUf008q5dz0ApbIZWNapdekrWJY/cCqcJZYW
         cTxNInlMagpZBs/E9WAilLppYiCZB+0upu8CoDMeHgpVSIMkzCmPYGrPeio4Kh3u3xIQ
         pK9CHRqeKwaB2JGZ+dVQOVmEutxntsUDMX5SSRD+HVzeEnU/IddCCwAiLJqvGazVPqsG
         bPaBVRLhOyq3Iqou1B7GpcH10u6PwczlPM/U2J1O3oGgWw2Bciztw0izab2VG32hcZW3
         nvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ai1LHUot21oPEBHVaxNwDK1Rq7+XpjKILesCWblzHSU=;
        b=cMmvGZlHB8o8QjBBtxnqS5bzI+egtO9tsklCqdR6H8euCsAAaVrfH/m8qlji6CbHKx
         rgcbX6htNdJV9mruURiXiO6EcR0jlOvKlOqGp9jshdW5w5nXTQKx/LXK1vCEi1O1gDvG
         mmjEndfIkCjEbT9Nz9et0x8dSeuFvM9TqqBFbbtFgT2vCmFRsGrvMho0+z/CucK7Gfv4
         bKrYaH+4S+M6OhBKslwNoVl2XpiGa8fBa9wRzE2p1ADm05W4q5BH+1aoralO7GjY4DJI
         j49Up+ZzvyP8henpkYXbkgxn/bPamtIYJ5s+W097KLEPOuhen0t8pM+HDJk1R1WeqPA6
         OLEQ==
X-Gm-Message-State: AKaTC01HeIv0uz25fOG0IxJsNKuUIKkkr/3SKuT0tRL1Aii/QqUQ7MYARfSui2mZilsllg==
X-Received: by 10.194.85.77 with SMTP id f13mr9036091wjz.187.1480102856537;
        Fri, 25 Nov 2016 11:40:56 -0800 (PST)
Received: from [192.168.1.26] (adan31.neoplus.adsl.tpnet.pl. [83.11.249.31])
        by smtp.googlemail.com with ESMTPSA id l187sm14987585wml.6.2016.11.25.11.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2016 11:40:55 -0800 (PST)
Subject: Re: What's cooking in git.git (Nov 2016, #05; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <1b790c3f-7d5f-7b3f-34f1-d921a201a62c@gmail.com>
Date:   Fri, 25 Nov 2016 20:40:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.11.2016 o 00:21, Junio C Hamano pisze:

> * nd/rebase-forget (2016-10-28) 1 commit
>  - rebase: add --forget to cleanup rebase, leave HEAD untouched
> 
>  "git rebase" learned "--forget" option, which allows a user to
>  remove the metadata left by an earlier "git rebase" that was
>  manually aborted without using "git rebase --abort".
> 
>  Waiting for a reroll.

It's always a good thing to stop requiring messing with .git insides.

> * jc/reset-unmerge (2016-10-24) 1 commit
>  - reset: --unmerge
> 
>  After "git add" is run prematurely during a conflict resolution,
>  "git diff" can no longer be used as a way to sanity check by
>  looking at the combined diff.  "git reset" learned a new
>  "--unmerge" option to recover from this situation.
> 
>  Will discard.
>  This may not be needed, given that update-index has a similar
>  option.

OTOH update-index is considered plumbing, so having "git reset --unmerge"
might be good thing (note that we can re-checkout file merge).
 
 > * jc/merge-drop-old-syntax (2015-04-29) 1 commit
>   (merged to 'next' on 2016-10-11 at 8928c8b9b3)
>  + merge: drop 'git merge <message> HEAD <commit>' syntax
> 
>  Stop supporting "git merge <message> HEAD <commit>" syntax that has
>  been deprecated since October 2007, and issues a deprecation
>  warning message since v2.5.0.
> 
>  Will cook in 'next'.
> 

