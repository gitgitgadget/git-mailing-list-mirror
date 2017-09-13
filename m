Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BE7209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 09:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdIMJHg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 05:07:36 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:45323 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdIMJHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 05:07:35 -0400
Received: by mail-it0-f41.google.com with SMTP id v19so463131ite.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=72hONTUW8Jq2VeYpGrjuauy/3jfgPov2Z6T5wFpFGK4=;
        b=XKzPDB6eBAEptdpES1IhAMaVLU2FD6UwppMsi0dYgW85rG9FubVu7xhLzN4zkcHNdh
         7QVx+xiZHRGnqegpL7nQ2WLmtdcJL6Jn0XDWE46HhZEpfd7Ucg6qgcB1WRCYQjH2HaB5
         RnvynuocmUjKrLzF9w5bbMKpGQBxh8hWNkzRJCLtPygGSJiu7E7pf7oGmn5LDgUWlJnM
         c34/LwDoacwOmyNjEgP8fStMpZazAwFcklluSQvSD92Fhn8Fb0fENQ7sF+dUXQ+Ma6hG
         IN0vSuC8yG3gG5iaKjiVcsSss9VZ38QlHOWM8IMFO87fFLRX+nWVg+9M/1ymV4AhM1On
         cPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=72hONTUW8Jq2VeYpGrjuauy/3jfgPov2Z6T5wFpFGK4=;
        b=cqGRpdNGn7cOD7jv2MEuhZw6ABVRupGzNIUI0JOqdmYOvAoD98SAjdW74dtflg3RJJ
         5bn3juKGgwI9TCG2r6RhR9ybmRYT41JmO5+xfUectU/NzA2nAa9Agfz9Rc/CxfoNM2DS
         bTflnVYpO2TyadTH6R2/694cT6a82up5yJgEvn5G4GjcjAdWqcZwKAyd/br8vzSRkwAO
         a+ACmVS72l66DAgl2yIy4NiLhDtoQmfCQePpAg2/APPGegkbsMwnCIXgL2vKTu21iYW0
         H8bi2CsDmscMnT2nfRIX6JyGNpCwAMx2AIJfh7AMMlvIIejsJPqldBaNDOhCG5S4fumf
         X8Fg==
X-Gm-Message-State: AHPjjUgG2wh9L+F4+t6G2jCbZmvYmNPrW6yzt1uRMTuXd8j7x0lsk2rh
        PGMlQpN2OdzrBOH/rMUDULwxyFid
X-Google-Smtp-Source: AOwi7QCnrTsqlkAhfJ/26B3cukJcSEA0zyq4hSNdxDKVytfIuBWKcG2c/UeORCQlXcmth2QtzA9LDw==
X-Received: by 10.36.0.77 with SMTP id 74mr3536751ita.119.1505293654397;
        Wed, 13 Sep 2017 02:07:34 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id 72sm512420itz.43.2017.09.13.02.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 02:07:33 -0700 (PDT)
Subject: Re: Buffered value should be shown when requesting username for
 remote authentication
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <1505220449.27800.23.camel@gmail.com>
 <20170912153355.mbsybuy3kqtfvmtd@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <f07d9416-bf2b-83ac-176a-14411d6e8aca@gmail.com>
Date:   Wed, 13 Sep 2017 14:37:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170912153355.mbsybuy3kqtfvmtd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 12 September 2017 09:03 PM, Jeff King wrote:
> If I understand right, you typed "sivaraam" once, then the network
> lagged, then you typed "sivaraam" again.
Almost there but I should have been more clearer. What I actually did was I
run `git push` and knowing it would ask for a username I started typing 
it immediately
without looking at the terminal to notice that the request for the 
username hasn't
shown up yet due to the slow network. the terminal was like this before 
the request showed up,

    $ git push
    sivaraam

After the request showed up the terminal was like,

    $ git push
    sivaraamUsername for 'https://github.com' :

I thought the buffered input wasn't recognised as it didn't show up 
after the request.
So, I typed the username once more to get this,

      $ git push -u fork
      sivaraamUsername for 'https://github.com' : sivaraam
      Password for 'https://sivaraamsivaraam@github.com :

I have been accustomed with this now a days that I don't do the same 
mistake now. I thought
it would nice if this could be fixed as I have seen utilities show the 
buffered input after the
request but as I stated before I'm not able to recollect which utility 
it was (hope I had better
memory)

> That isn't really something that Git can fix reliably. Reading those
> characters and echoing them back to the terminal is handled by your
> terminal driver (and potentially other things like ssh).  Git may have
> received "sivaraamsivaraam" all at once, depending on where the lag is.

I expected this but wasn't sure which "potential thing" was handling the 
'https' handling in the background.
I guess it's 'curl' but not sure.

---
Kaartic
