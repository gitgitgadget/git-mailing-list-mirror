Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1731AC6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 12:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiIMMLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIMMLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 08:11:30 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9435FAC0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 05:11:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3321c2a8d4cso137503447b3.5
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=A/ghghrxb1DFIGqBc2Q2VYjYAVTakTqBhlYAJv9+JgA=;
        b=SQYvf4jwveaRuz904s7nKGgACnwkCwnkOKavjJSvwdnyav3FOdP/Tpm2/tIQeyDYbz
         gTekiSZTdXUYBfN6isJmJqS0wBdlP5D0Ge0rQoq8KABz3lAlaciNaIHmu3S47+JST4vp
         q4Oxu3MAuzY87uhOXXiHmFiUtcwKMJoMCNUbVn9W0lYJXuwB1OobwNJUaSrxOK40IK/U
         DD4iewYImyAN4Owy69XrvOOpj5ywJJdky8wm5/3XF09XKSV0OwjRRpeWy3WwUEWcg+Df
         8KAYaOKgS/sep0lhS7SRIdsT2hH132lw9pX3/zjpFF74CZ+ERExO9AWXwUnDgR2pHy0v
         ItjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=A/ghghrxb1DFIGqBc2Q2VYjYAVTakTqBhlYAJv9+JgA=;
        b=NrmrwoPMuRjuKspUSjdtZ+NTqbf/7lmQmJB7hJgDK3ZLPgHV5ueDo0DCqmnL7y+gBN
         mF4qx9w9MXl4k9JqYdDm0ntr0IqCVgm8EJeX0p8HebNAAZTPTE+8JrcTiuV7rYoNdQvl
         mGNvVvjy1x48B61HeFbLhJfk/y+Y0Sqn4axJb+ZNy8YqO5m080SKQ0fKbHW77bZeDdGz
         oJ3oNhACMiOAE4Cse7HqXvJc5JdGMH4J7wbX1DFhnI4mMNaoG01UZaHLRbcARhslduas
         ni8HZck/WPQ6Gq60dUCkFQnEiDBAqLY7C3b3hwhK5mb0D8jkPDyCaLQy9bOBnC0DOjCQ
         Wd6w==
X-Gm-Message-State: ACgBeo2+0ZKQna+tR9CErS8sA12aCiHgDP7w2KiJAOLNrWFkozDPYJyr
        j8z8s1PBH2EjJWq/9OaLsy/BwnOulsFW2PLs6KoxkFrFUXrdoxkkjJc=
X-Google-Smtp-Source: AA6agR4DN1iuOb/6/lQX4dD9S5BSBGMuUxXIPDMEPI2u/zYdcFhLeOh+yCr56YonXWk7eyAQqG5vorCXEYZU+WWtZbM=
X-Received: by 2002:a81:7851:0:b0:349:5fac:b1ed with SMTP id
 t78-20020a817851000000b003495facb1edmr5719785ywc.311.1663071088996; Tue, 13
 Sep 2022 05:11:28 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 13 Sep 2022 14:11:17 +0200
Message-ID: <CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com>
Subject: Handling the Git trademark
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The Git PLC (Project Leadership Committee) is responsible for handling
the "Git" trademark and the Git logo with help from the Software
Freedom Conservancy. And we would like at this point to report about
how we have been handling it, and to open the conversation about this
subject.

We have a web page about our trademark policy on
https://git-scm.com/about/trademark. There, we list our guidelines for
others who would like to use our "Git" trademark. Unfortunately a
number of people don't respect our guidelines and use the trademark
without asking us first (sometimes in ways that we might not like).

If we don't enforce our trademark, there is a risk of us losing any
right to it. So far we have tried to enforce it, especially in cases
where people want to register a name based on it.

The issue we have with enforcing the Git trademark is that we don't
have much resources to enforce it. And in general we want to avoid
spending time and money enforcing our mark in all possible instances.
Legal discussions, going to court, etc can be very time and money
consuming, and we would prefer doing more productive things with our
resources instead.

So, as much as possible, we don't want to take legal action. For
example, we would much prefer to respond to a disagreeable use of our
mark by first contacting the party and asking politely for them to
change their use. Usually this is sufficient to deter infringing uses
of our mark.

We would be Ok if necessary to publicly say that for example one
company is using our trademark in a way we don't like. We think that
the threat of us doing that (if the company doesn't agree to change
the way they use it when we ask politely) is in most cases enough to
deter people from using it.

This way of handling issues has worked well so far. The reason we
think it works well, is that people think about the "Git" name as very
cool, and that's why they want to use it in their product or company
names. If the Git project would say that it doesn't like the way this
company is using the Git trademark, it would likely create some bad
buzz about that company and would go completely against their goal of
being perceived as cool.

Now we cannot be sure that this will always be enough to enforce it in
the future. We might have to go to court in some cases. Also we still
spend some time on this, so another possibility would be to stop
enforcing the trademark and the logo altogether.

We also would like to thank the Conservancy and the layers they have
hired for all the information, help, advice and guidance they have
provided on this.

Now we are open to your thoughts about this.

Thanks,
Christian for the Git PLC
