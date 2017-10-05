Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B5B20281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdJEMOC (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:14:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56033 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdJEMOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:14:01 -0400
Received: by mail-it0-f66.google.com with SMTP id p185so1028300itc.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=gEd3a6+b87HE/lKijqAJFnZ7CypWfxbbjBUUCkwuZq8=;
        b=bdKMEkN/mPKQeUtqKt2aGSzuVBvLCLJPyw0wqDhW33s8D6G3FdWRwB7WTiI9KRqnD9
         WX/wz48kRknuTdaqiAEdCuJKKCcXN2HaQyNadHRDC9gdv0FLUwZciZYk95XoSWhs8tyS
         iYSiM6CUtVrGIoZEGh2afhLotWyO2H8S9IKAatiTBX1zKAj0WaNR5ISJvu6+NVO8ADed
         PnI9GRhBf078GTCg8xCuvatB/WNprUgfA/81qwXr886bvuZjaB9lgQFxNS9ojZSML3vC
         aFBBVSWg/KKD0Ph6RljjE/UqgCHZG7v0fu4PS78xDqsk0PqLx/khPWoylT9ZfRKlfNmO
         UD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=gEd3a6+b87HE/lKijqAJFnZ7CypWfxbbjBUUCkwuZq8=;
        b=D6i0R99UClkPDYXuSYmMmA78P9lLW5joQdF+tu2J2AIU0+482liFBxkfOSjqE906Hg
         EneKlU+Kxq/PZ/L/K202SPppctzJ1NZqwGp+HedfQkYzsT9BSz57LNbdBmyK9n4CYXb0
         Yfd5YryQ9Lai9G1NdcuEM7T45z3svb5B4rB2m6CMa/Lj7KqmB98RfoxFUqM7qOUfl0Tw
         4JF9+aJhyJUi4R29NAfNnvEX/PLok4EKZ0Q2Gxz8JXWx+1X/u2m9ctB047w+8ApokF9h
         Wb2lPbRRZbNUV2lqOvyLVZzRbMdGpg7W2GI9W4nqEId0UppTV+g9zvopC/vvNdwT07Fv
         qxxQ==
X-Gm-Message-State: AMCzsaXnoDiOm4sK1DLMQwYyfy9lXl1KKdC8zujHD5ERE+AkwRLDtUjp
        Mk8+fwxHkkCvR2hHeFTtYuA=
X-Google-Smtp-Source: AOwi7QDg/h7ceeB7EiPTUdPy7fdjXVFZY0+dibnDoDW4oahq9nRGm3sJan4RLFEMSM30kQlEWQoPsA==
X-Received: by 10.36.36.210 with SMTP id f201mr22840334ita.10.1507205640705;
        Thu, 05 Oct 2017 05:14:00 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id y125sm8309361iod.4.2017.10.05.05.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 05:13:59 -0700 (PDT)
Message-ID: <1507205634.2364.2.camel@gmail.com>
Subject: Re: [PATCH v2] branch: change the error messages to be more
 meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqmv569z25.fsf@gitster.mtv.corp.google.com>
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
         <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
         <1506964786.3504.3.camel@gmail.com>
         <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
         <1507058081.7360.5.camel@gmail.com>
         <xmqqwp4beemb.fsf@gitster.mtv.corp.google.com>
         <1507121174.2245.3.camel@gmail.com>
         <xmqqmv569z25.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 05 Oct 2017 17:43:54 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-05 at 10:13 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > Moreover, as a consequence of my assumption that the tests don't check
> > for the error messages themselves; I haven't even thought of checking
> > whether the tests or the travis-ci build succeeded as a consequence of
> > my patches that touch "only" the error messages!
> 
> That's a bad thing, right?

Might be, but my assumption seems to held at least until now for the
two or three patches that I have sent that touch "only" the error
messages (I haven't received emails from anyone shouting at me that the
build fails as a consequence of one such patches).

The build status for this patch can be found at [1]. Supporting my
assumption, it passed too.

That said, you don't have to worry a lot about this. I'll come over my
laziness and check if the travis-ci build passes for such patches in
the future :-)

[1]: https://travis-ci.org/sivaraam/git/builds/276222235

---
Kaartic

