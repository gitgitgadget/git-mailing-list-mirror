Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E871FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbdC1Svy (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:51:54 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33238 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbdC1Svx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:51:53 -0400
Received: by mail-pg0-f43.google.com with SMTP id n5so73131914pgh.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LoGXmsiZcY8W2MLkm8sjKNzq0+bZEZvZTKMjzwKubBk=;
        b=VwkaVXy8OxsxRDs303Oh4lMjUgQVAbj94GA/C/r9XIMglSITf9ReJwv3feHN95lIhO
         f1lgGuPYtmkvZuF82UqeUrJ4pza2bWREGzjDAZkm1xIXKwC6yB94b6OfWfLJ1tcgRISx
         MCUU9lpQh/18neYqkD7Ayp0WSldwzI+HsGldZmquua//vziAyYioNEGZeF/ZwCy3eA80
         D4+Utncht8o+NdPSvScNPzKmAWFWD63Y8U07tcae8NqFZPQQvAr2s9g4j0YtL/FBlPlc
         ecPysBYwAOwWqZAaOO3xqjfhjT1vXd6Mvi9x2yAtEEKJH80KmbjVuQIx2x32rqV4t3xN
         GC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LoGXmsiZcY8W2MLkm8sjKNzq0+bZEZvZTKMjzwKubBk=;
        b=TOEZhPOjqIiMsMFcLXs3C8lD32Hi2S2h9hG+CFwdgbFOBynuC4ocr2qwVxCutWIShH
         BJ8IiuVpkznS+BijozdegPCIObaDmYJ2vT5amXfjLi8av+nCpF/hXHWwOCyhwTuoJRlg
         w2aDoZvbtfKKrLHW+w+b5Kl0ipLEto7ir4sf47c34q4nrmqsSfU6z508XJ37VkMMXC/q
         xR6tY3UrNEXOeT+/ftKphpyM488n+JsUDPmnGjZmscBIAocTQT710QdV6Uh9n1Kb6d3H
         Yy4by8E7+ADb1rwXDjYOsvTSHAtbtDyyqXD7kghDDdhnK2vyxcffgDZFpxsnJ4XLgQrX
         zefg==
X-Gm-Message-State: AFeK/H3brSQFWOcLD6oIRi/i3XOGSfCZibFS5WExkyb1ghG/7DpHLZb7Mj1N8/SuaXWhYQ==
X-Received: by 10.98.39.134 with SMTP id n128mr33663765pfn.17.1490727112184;
        Tue, 28 Mar 2017 11:51:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c52:4b14:15fb:ecda])
        by smtp.gmail.com with ESMTPSA id y64sm8928200pfy.3.2017.03.28.11.51.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 11:51:51 -0700 (PDT)
Date:   Tue, 28 Mar 2017 11:51:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] should these two topics graduate to 'master' soon?
Message-ID: <20170328185149.GS31294@aiede.mtv.corp.google.com>
References: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano wrote:

> There are two topics that are marked as "Will cook in 'next'" for
> practically forever in the "What's cooking" reports.  The world may
> have become ready for one or both of them, in which case we should
> do the merge not too late in the cycle.
>
> * jc/merge-drop-old-syntax (2015-04-29) 1 commit
>
>   This topic stops "git merge <message> HEAD <commit>" syntax that
>   has been deprecated since October 2007 (and we have issued a
>   warning message since around v2.5.0 when the ancient syntax was
>   used).
>
> * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
>
>   This is the endgame of the topic to avoid blindly falling back to
>   ".git" when the setup sequence said we are _not_ in Git repository.
>   A corner case that happens to work right now may be broken by a call
>   to die("BUG").
>
> I am leaning toward including the former in the upcoming release,
> whose -rc0 is tentatively scheduled to happen on Apr 20th.  I think
> the rest of the system is also ready for the latter (back when we
> merged it to 'next' and started cooking, there were still a few
> codepaths that triggered its die(), which have been fixed).
>
> Opinions?

Google has been running with both of these for a while.  Any problems
we ran into were already reported and fixed.  I would be all for
including them in the next release.

Thanks and hope that helps,
Jonathan
