Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EE1202C1
	for <e@80x24.org>; Sat, 11 Mar 2017 11:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbdCKLEr (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 06:04:47 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33698 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbdCKLEq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 06:04:46 -0500
Received: by mail-lf0-f49.google.com with SMTP id a6so49347700lfa.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BOrHmZZUN9pCRHTmUwKqx+Th75kmNjhfgS/UG5w/3O0=;
        b=sGjIdwKX1u3Z99nmrWD9fkXelnUE7vKjfYQ0DvuiuI+JgA53re4lHkNEMI5R1cABLO
         Q30VV9x902z1goeWlprP6QY02Nn7Wpcl2Mix2Vo4Iyq337Yn3XsrSWrlWg4TGJdpx862
         lYItb8ww7AVljGRr6W8JVOzlH77t8TgApNS7qdJuYTS3j9LDxCyA5R5M9uPI78J8afLD
         gHbTs/IfUsKBVDXUmVW2Xm4PAPBDAVqC57v0lECyZSigxbgSqDRanF1ofAXOLhWkR6nP
         UTpvAoY7dMJFq21wHSA0RtYTUIu0spI6eHctThdMYYyfcNe7IG8HACQqxrhG9i4PD5OW
         KUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BOrHmZZUN9pCRHTmUwKqx+Th75kmNjhfgS/UG5w/3O0=;
        b=ltVVjuWDC2Pn2hxkqvOupUzJLZqLjGhG7RwNs/w+ANw03V+tAEKT3hlnJdDf8YOs0p
         xw6Cs8vTj0nkxRO2IKTf/J43J11meU6RHlN2wF1skBhu4WwDsWNNHr/9NQlo5keVBqe8
         yKg1KbzHGNJ89rUslYcnb3QCFSsca4JhhPMimP9eO2e8pnRsRIZ3CBHvQ8GZzBsiazL+
         DolrXJ5w7hnYqSrQ7/EWnnstN4NGT0oZ2+n3wGtsd99/xa3okAWAT3aVH0SSBzdZYq44
         dwKJPRXkPkLWfgDe4STQ+bHHBYYqLs70PYM13Kj/LuE7hr4HDDKg6tlwb+i/oy3RDYC9
         Vyxg==
X-Gm-Message-State: AMke39lEtdUGUqv8jC1SqLceOHpmzXUQa/eWI/sxdXluj6LDo9/L3rHEUKZq3Q+SDIqKT/2KLCA/ByuTghiFHg==
X-Received: by 10.25.225.216 with SMTP id l85mr5704835lfk.129.1489230283251;
 Sat, 11 Mar 2017 03:04:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Sat, 11 Mar 2017 03:04:42 -0800 (PST)
In-Reply-To: <20170311092338.9809-1-souravcristiano502@gmail.com>
References: <20170311092338.9809-1-souravcristiano502@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 11 Mar 2017 12:04:42 +0100
Message-ID: <CAP8UFD2ViVY+S6jie6Mu-EgD5rvaF802UD4GhHGjLwWkVdChdg@mail.gmail.com>
Subject: Re: [Gsoc] adding built-in driver for javascript
To:     sourav mondal <souravcristiano502@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 10:23 AM, sourav mondal
<souravcristiano502@gmail.com> wrote:
> I'm working on "Add more builtin pattern for userdiff" as my microproject=
 for Gsoc17.As I noticed javascript's builtin driver was not present in use=
rdiff of git/git tree. Hopefully this pattern will cover all cases. I'm rea=
lly eager to know about my work and wiiling to add more pattern for well kn=
own lanaguage.

If this is a patch that you are submitting, please:

- add "[PATCH]" to the subject of your email, and if it's not the
first time it is sent, add v2, v3 or so after "PATCH"
- move the information related to your GSoC (and the "thanks &
regards" part) just after your "Signed-off-by" and the "---" line
below it, as it should not appear in the commit message after your
patch is applied (you can check that using `git format-patch` and `git
am`)
- write a better description of your patch above after the GSoC
related information has been moved (`git log userdiff.c` can help you
see how others have done it)

Thanks.

> thanks & regards,
> sourav
>
> Signed-off-by: sourav mondal <souravcristiano502@gmail.com>
> ---
>  userdiff.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
