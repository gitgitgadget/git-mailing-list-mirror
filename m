Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F71202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbdKGMcN (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 07:32:13 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:52866 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbdKGMcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 07:32:10 -0500
Received: by mail-pg0-f47.google.com with SMTP id a192so10907397pge.9
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=MHlkP+VF7fgsKsB2hxSwHFtlC+DXUYuNSC/3M1MyC2E=;
        b=hRD+LI4HgJeSpZ25d4Cra3MU8FVxYzP676YoM9dw5DfF3hIc6XCW4fPjG/AnGgpBWM
         zFpBNyuCCmkkOhuoUfV9yKt5gulV40ed9x7j58PvtN1ho5l85TOFXBTTqkwq+EWV8fyS
         yXIKIt5Ct0v4XnTID8J3med5j16hew8x0MfkCHSXYiK69wdhIPHqMsr+qHPEq4RmpUXz
         aI2uRR4xN9r4Kjs6d8eK91LWA/jyOW+0q7cM3g9FMCWSxtXnOjOPRyTdNQWo2/ZNx+s2
         +yqlPb8DMSn/Zc/i4WXI9WKhzDcENFWX4cT6/gZbDxnAIs6m+U4DD1AQYjcSNLC22iqd
         sg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=MHlkP+VF7fgsKsB2hxSwHFtlC+DXUYuNSC/3M1MyC2E=;
        b=baqXzVhV1yphMFZbDY1Pkpui+J0UvgwI1aEi6LKnxk10iKx26iQZQqh0X0XEOKe+Qx
         SH7/zehIbZzGNXnXOVi2i4I2XGGapiHiRuPuUM2egTj+bSR+OYhuUzldsDrstyhSW4vt
         7fPd7jyFh7UFb++vZikVUB9GBqa82mDxIKwqlBdfPFNBaV6oSwi+O3eGSI9dUv4GW5TA
         CQZCMRk87MrdS8BX6ufDN/3jF1LbZSu5skW2hQSIXqBwIV2VuJOxADrBnyP/WnHNy6R+
         QIrDFcQzjYveDmre2UuRRMx3yiSh5gSS9tR53TKj0eOoqSuvC1XN1uoeLRHoeObRdg31
         2s/A==
X-Gm-Message-State: AMCzsaVwFty6OnpWMKwQvw1h+n+LRuNlGb5SK+IkYPyi4WP+iHxCxfou
        cGdlIGPtMheg12XbNMzTfSI=
X-Google-Smtp-Source: ABhQp+T3sHS2aqQkBqgnkYbI7gk0T3HS1tZJUWhHw/XsWjdJ+HfZEQ9Vx+PFi4Nxun0HVkP4d72gvw==
X-Received: by 10.159.249.75 with SMTP id h11mr18265817pls.192.1510057929418;
        Tue, 07 Nov 2017 04:32:09 -0800 (PST)
Received: from unique-pc ([117.202.238.243])
        by smtp.gmail.com with ESMTPSA id l191sm3468734pfc.180.2017.11.07.04.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Nov 2017 04:32:07 -0800 (PST)
Message-ID: <1510057755.8228.4.camel@gmail.com>
Subject: Re: "Cannot fetch git.git" ( iworktrees at fault? or origin/HEAD) ?
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
In-Reply-To: <CAGZ79kY+R_Kd7BbmnRb0C1H94HvZ3TGRvWKFOX8XEStjBQMB-A@mail.gmail.com>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
         <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
         <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
         <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
         <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
         <1508682297.6715.15.camel@gmail.com>
         <20171023003647.4pvzmhk7v5t6zqm5@sigill.intra.peff.net>
         <CAGZ79kYAn0Hi0qaG8P5zvVOFTsfXYrtvrR7oiT0KwwWeKLqZgw@mail.gmail.com>
         <0f1f8317-9d82-5e61-5332-f877ca886056@gmail.com>
         <CAGZ79kY+R_Kd7BbmnRb0C1H94HvZ3TGRvWKFOX8XEStjBQMB-A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 07 Nov 2017 17:59:15 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-11-03 at 12:11 -0700, Stefan Beller wrote:
> On Fri, Nov 3, 2017 at 2:32 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> > BTW, this is what I call _way way_ faster. Unfortunately due to the limited
> > configuration of my system, the test suite has following timing
> > 
> >     real    3m14.482s
> >     user    2m10.556s
> >     sys     1m12.328s
> 
> This sounds to me as if it is running with just one thread
> (because sys+user = real); I usually run with
> 
>     cd t
>     prove --jobs 25 t[0-8][0-9]*.sh
> 
> The multithreading can be seen in the timing as well
>     real 1m9.913s
>     user 1m50.796s
>     sys 0m54.092s
> as user > real already.
> 
> If you run tests via 'make test' or 'cd t && make', you can also give
> a --jobs <n>
> to make it faster. I have no good answer for how many, but I have the impression
> overloading the system is no big deal. (I only have a few cores in this machine,
> 4 or 6, but still run with --jobs 25; 'git grep sleep' returns a
> couple of lines,
> and such threads sleeping definitely don't need a CPU)
> 

I usually use the following command to build and run the test suite
from the root of the working directory,

    make NO_GETTEXT=1 DEVELOPER=1 DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="--timer --jobs 16" test

    I beleived that the DEFAULT_TST_TARGE and GIT_PROVE_OPTS options would
    be seen by the Makefile in t/ but didn't verify it. Your statement made
    me suspicious and I wanted to know whether my assumption was correct or
    not. So, I did this,


    1. I first tried running the above command while seeing how much time
    on the 'next' branch when it was pointing at,

    9a519c715 (Merge branch 'jk/rebase-i-exec-gitdir-fix' into next, 2017-11-02)

    First, I observed that at least part of my assumption held on observing
    that the output was similar to that of 'prove'. This shows that
    t/Makefile recognizes DEFAULT_TEST_TARGET.

    Next, to verify if it recognizes GIT_PROVE_OPTS I ran the above command
    with 'time' and it gave back the following statistics,

    real    	    4m55.707s
    user    	    2m29.924s
    sys    	    1m48.072s

    which is in line with the statistics for the spinning disk in the
    previous mail. (The time doesn't include the build time).

    (real)-(user+sys) = 38s (approx.)


    2. Now I switched to the t/ directory, I tried running the following,

    make DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="--timer --jobs 16"

    'time' gave the statistics for the above command as follows,

    real    	    5m19.523s
    user    	    2m26.764s
    sys    	    1m45.240s

    (real)-(user+sys) =     68s (approx.)
Not a big improvement from the previous case to assure that
GIT_PROVE_OPTS wasn't recognized there.


3. Staying in the t/ directory, I tried running the following just to
be pretty sure that the "--jobs" was indeed sent to 'prove',

    prove --jobs 16 t[0-9][0-9]*.sh

'time' gave the statistics for the above command as follows,

    real    	    4m49.241s
    user    	    2m29.220s
    sys    	    1m47.828s

    (real)-(user+sys) = 34s (approx.)

    This seems to be identical with the first case.

    So, it does seem to be a limitation of my system (Intel i3 with 2
    cores, FWIW).


    4. To see if things improve with a higher number of jobs I tried,

    prove --jobs 25 t[0-9][0-9]*.sh

    'time' gave the statistics for the above command as follows,

    real    	    5m21.229s
    user    	    2m25.704s
    sys    	    1m46.744s

        (real)-(user+sys) = 70s (approx.)

        This ensured the limitation once more!

        Anyways, thanks for the explanation and information which was
        enlightening. :-)

-- 
Kaartic
