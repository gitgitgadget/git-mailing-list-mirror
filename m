Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06E01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 13:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeH2RJe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 13:09:34 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33401 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2RJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 13:09:34 -0400
Received: by mail-ed1-f54.google.com with SMTP id h9-v6so3898748edr.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=N5oK0pwOBYB/hlaLidr/Dy3due4l+ww5R8Kadw1QJcY=;
        b=ejiNR5StPCqQyshT6HF5w3KqzdVM5z2WKn4stMst+nBhKMjRmvHmBOdVCppnHxzg5T
         PkC8Ztzu9IAzITwp5dXpjuPxMAr5u3BH3UYhamm8GY8BpWxCepvCyHCKP+KoyO0X4ukJ
         a24Z1WYJQVj2G2HKqDsEUpT26kw5zLHQPl1+n6pzJPFA5Zm1mWXVFDYoxW2NZYPN3Hb8
         S1ojpZzN4MrakQ0SrD5wZljV2NxjFcXHbR1hebehexUFbhmy8VY6A48hGxqqHYfkIqam
         K0vF8fY22IHBjH6pXXB870x90165svgK6G91vuCwQvZRfQZgBnwepNGhyml5RrPCcgZ3
         WdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=N5oK0pwOBYB/hlaLidr/Dy3due4l+ww5R8Kadw1QJcY=;
        b=if5XOxxqdVENnZokYBi3YCh1TbjSOQ2D9td8tCGdGcW9OmW3qTs2Ih0PQJM0X5QPIx
         WctBm6+hLd2X4ab0sVhvkNv62gipZFsGyDa5Cmrh2Yh3fav27A9rNRfQ/8Xk4vPVcI0q
         sNiX6zw9ZN18sVqiwsaNMpUGPU+ecM1ej7K+i+UmN7Ft0A/Q1ndUC73phNDPkD60WhYW
         KcVhdL9q6fl2+2kaBX6sckiKTLm6BpfUYDEVGClrHEbaHOFk8UgDsMpyshKljArCRdjR
         gmnDGAlYH+7IjMI843mMXA/3jt2Sx/Aix2btZ0PSCMULtp1BU9zsOnfmQMsBa0BHfZcG
         3yog==
X-Gm-Message-State: APzg51Cp4bYnlcQCHclC8fiKUg/dwcUnd3UaewYokFeedXF2EL36Tj3p
        SNHD5lD2xcCiWredxiR0rrAkeaRRGBo=
X-Google-Smtp-Source: ANB0VdaGsVtYIb5YHGXfenkGdgQb8ETXq14NmYVJdFzxHDlPuk/+4BqFfw+192vVBkLox1G7h7DHug==
X-Received: by 2002:a50:acc6:: with SMTP id x64-v6mr7685410edc.152.1535548359465;
        Wed, 29 Aug 2018 06:12:39 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id k33-v6sm1761799edb.31.2018.08.29.06.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 06:12:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
References: <20180828151419.GA17467@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180828151419.GA17467@sigill.intra.peff.net>
Date:   Wed, 29 Aug 2018 15:12:37 +0200
Message-ID: <8736uxe2pm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 28 2018, Jeff King wrote:

> The Outreachy application period is set to begin on September 10th for
> interns participating in the December-March program. Do we want to
> participate?
>
> Details on the program are here:
>
>   https://www.outreachy.org/communities/cfp/
>
> If we want to, then we need:
>
>   1. Volunteers to mentor. This is similar in scope to being a GSoC
>      mentor.
>
>   2. To get our landing page and list of projects in order (and also
>      micro-projects for applicants). This can probably build on the
>      previous round at:
>
>        https://git.github.io/Outreachy-15/
>
>      and on the project/microprojects lists for GSoC (which will need
>      some updating and culling).
>
>   3. To figure out funding (unlike GSoC, the intern stipend comes from
>      the projects). I can look into getting outside funds (which is what
>      we did last year). Worst case, we do have enough project money to
>      cover an intern. Last year[1] opinions were that this was a
>      reasonable use of project money, but of course new opinions are
>      welcome.
>
> If the answer is "yes, we should participate", it will hopefully be
> accompanied with "yes, I will mentor", and "yes, and I will start
> getting the land#ing page ready." :)

I just have a "yes" to the first one of those. Which tells you how much
skin I have in the game (and how much you should(n't) listen to me) :)

Just a question: It seems to me that #1 and #2 is not tied up to the
Outreachy process. I agree that finding a qualified intern to work on
Git would be a good use of project funds.

What's not clear to me is if/how tied up this needs to be to a specific
external program such as Outreachy. I.e. do we as a project need to go
through that organization, or can that be just one of the ways in which
we send out a call for interns?

With GSoC we don't have a choice in the matter, since Google's paying
the bills and runs the show, but it sounds like in this case we at least
partially do.

Or maybe Outreachy is doing some heavy lifting with screening or has
partial subsidies which would still make it prohibitive to e.g. send out
a general call of our own for candidates on the mailing list & in other
venues.
