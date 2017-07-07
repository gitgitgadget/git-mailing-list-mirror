Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA6D202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 11:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdGGLxJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 07:53:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33260 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGLxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 07:53:08 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so3840034pgb.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=1oNMy9CXCZ3x4It7f3DDwG+Wqg/OsN/TNLLjypRBaUk=;
        b=PtGbTnJ+/gjlUKHmnJch7atZCLWoYWRNCaQVOy3wcqREq2Xy3dn8ArdwDj+yP4Yfav
         zNeTEr9QcqJ91KQBMW0Rojb8f/qh1+tV+fYQyyIQ7pQUFsxXNj9tTNnZ3Pq36qB8jkGm
         h9yehzqnKQDbVoz2EbvW5I+U+xti31g6+u7+Ytk8AWZXW6xD6GoIZg2ai6YW44Sb+Nyy
         87bnyefkDeUz/aHgJaDkmU/iUgxdXhpdR5LzxjVI3liaad7nmDZNbNJI3CekZ/TP1+3A
         x86+snQoxGwpid+fN9kmRjjtH6Uyaxp4AzCdmh33wvzAslZpynoFIMusXp60wupqJZGP
         oWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=1oNMy9CXCZ3x4It7f3DDwG+Wqg/OsN/TNLLjypRBaUk=;
        b=k14sQi04N2+nzkvPsJsRZxjw527qLt2EwyEmNdSPg6swi6/JOU/xQNv/Djl9lgwIWV
         3jGVcnNlsYsY8bvm1uvw0jE5AWX93lJjxKPe562CXySAFmYs/fkxitgzqPaIjGVXUg7i
         /92uMAz5FqjsfLvUMHEV+CefvfLBsDUQf1On7th5t0asch9JUDo1Gej9MwJ0WOf7+woV
         HOMjS9lI20jHaPkBZMt8JIwdaBoLG/ZFdTqIWbASxXyLnVOR2dlR92uhh3yQ0dja7n1F
         ndBcrFoYbZOgOustphWn2ta6fy3n3lME5CoL8nNrXe6l1t7Kf3VhhkSiYosbxVU2vKE4
         gp0A==
X-Gm-Message-State: AIVw112zn4ClTjhtuoelvZqSOv14MUDczgk8tRvK/tr53Fazqaplk6t7
        UueVyxcqI/jR/w==
X-Received: by 10.84.231.194 with SMTP id g2mr2579788pln.5.1499428388204;
        Fri, 07 Jul 2017 04:53:08 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id o73sm6782097pfi.2.2017.07.07.04.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 04:53:07 -0700 (PDT)
Message-ID: <1499428393.1849.3.camel@gmail.com>
Subject: Re: [PATCH] hooks: replace irrelevant hook sample
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 07 Jul 2017 17:23:13 +0530
In-Reply-To: <xmqqr2xuhde1.fsf@gitster.mtv.corp.google.com>
References: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
         <20170705165114.20662-1-kaarticsivaraam91196@gmail.com>
         <xmqqr2xuhde1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-05 at 12:50 -0700, Junio C Hamano wrote:
> Three things that caught my eyes:
> 
>  - Between "git commit --cleanup=strip" and "git commit --
> cleanup=verbatim",
>    lines that make up this initial instruction section are different.
> 
>  - "git grep 'Please enter the '" finds that this string is subject
>    to translation, so the pattern may not match (in which case it
>    will be a no-op without doing any harm, which is OK).
> 
>  - core.commentChar can be set to something other than '#', so the
>    pattern may not match (I do not offhand know if that may cause a
>    wrong line to match, causing harm, or not).
> 
> As merely an example, it probably is OK to say "this won't work if
> you are not using the C locale, and/or you are using custom
> core.commentChar".  So if we disregard the latter two, I would think
> 
>     sed -e '/^# Please enter the commit message /,/^#$/d'
> 
> may be simpler to reason about to achieve the same goal.  
> 
Thanks for enlightening me about this. I thought sed was greedy with
address spaces the same way it's greedy with regex.

    sed -e '/^# Please enter the commit message /,/^#$/d'


This command does seem to work regardless of the cleanup mode used.

That said, in case my interpretation that "'prepare-commit-msg' hook is
not to be shipped due to it's uselessness" is correct, the reply of
this mail as a whole seems to contradict it.

Should I work on this patch and another related one (he one that
modifies the signature part of the hook) or
should I drop it ?

IOW, would this patch likely make the hook useful again?

-- 
Kaartic
