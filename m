Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D9E2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbdHGOc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:32:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33341 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdHGOcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:32:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so567671pgb.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=sBCfpc+0gEI6nCUwy7Fm+BYRav1IVPYJpWmLI9iPSrU=;
        b=RE1ku+YYfn4Kcd5EPfVl6JXtHMTQDjD6DUjRy577dc6gqbTilW+FXbdggBLKmBAKbw
         /X49C3yAknj3eP7lzjU6ftLI66vAL0CE1EYQrKLL1j+UKJdqJ6JvrYJSMNjHV0xcwu9I
         C5KqGmMmZ0ayMgFmPq20pyVLQn4htdkqfyZLWVfqFKfYJFjRCRarGxkOp9GUE/G7bln5
         NA0Cue2CvFz+ejvS0JsDhkmiDI9ASbo2fFYFRFdBSOY/y6zeB5IWRBADqGheM+r/GfvF
         64IjkI5yDdiV+1/20Zdmbr3XOT0qCAj9rtOk7ZoMI/iEzIoxJUkl4R8IoyKomwvGZfQM
         Up7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=sBCfpc+0gEI6nCUwy7Fm+BYRav1IVPYJpWmLI9iPSrU=;
        b=Yko0JaPUjGotX32x9V9ADwJ6Xd2Nkba1DNdLv6mtwZUXWhQjNoUoWPwRB7F9XfOC9l
         JNKEJXnIEAW2HqKbb0mv8BQ1nmzmO9u2B4P+lASX2rfe/+cSZ+Yphlm/d+2f3ybQXjV7
         Q67ZDGpjs79qY6vX0uCj+pP+3cC1bp4uxH14LG5i+gInfOGCZ0KdmB3aJl1q1/I809oy
         7sMLnDy+UqwVWIVsVwtQNYewzJ25De0oZkSFlPNNUHoY1hppWW2WhEhjFQqIyUX+W5i8
         o9YU2PWRPSMwz2PJoaNEE3AGWSkwmA87mxaYnCrcu4G6mfp4ZmNHRVlKYx8SKtddMbji
         eUiQ==
X-Gm-Message-State: AHYfb5hHGe7OUo9FynLhGcxUXAYp8kkMIArB+x7Qlltfr0vDkRQqQov6
        SsOWW0tFyndbDhKhTsQ=
X-Received: by 10.98.137.202 with SMTP id n71mr754463pfk.243.1502116375312;
        Mon, 07 Aug 2017 07:32:55 -0700 (PDT)
Received: from unique-pc ([117.249.143.188])
        by smtp.googlemail.com with ESMTPSA id l132sm15972670pfc.150.2017.08.07.07.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Aug 2017 07:32:54 -0700 (PDT)
Message-ID: <1502116408.3172.3.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has
 been merged
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
         <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
         <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
         <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
         <1501677122.1957.8.camel@gmail.com>
         <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 07 Aug 2017 20:03:28 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-08-02 at 09:01 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > On Tue, 2017-08-01 at 10:46 -0700, Stefan Beller wrote:
> > > So maybe we want to cut a lot of workflow related commendatory from
> > > the SubmitingPatches and then encourage to read such man page?
> > > 
> > 
> > That's right. Maybe Documentation/SubmittingPatches needs a revamp to
> > be one-time contributor friendly? Maybe introducing a "gist" for people
> > who do not have the time to read the whole document, might be of help?
> 
> First of all, I do not think lack of one-time contributor is
> something we should consider to be a problem.  Supporting new
> contributors so that they will be involved more in the development
> process is a lot more important issue.
> 
First of all, I would like to clear a little mis-interpretation here.
Though I used the phrase 'one-time contributor', I didn't want a gist
that targets only *those* people. I was thinking, in general, about
people who would like to contribute but find the documentation
overwhelming (an example might be the thread pointed out by Stefan). In
which case, they would want to check if their patch meets the *basic
criterias* and send it to the community hoping it would be accepted
with at least 75% probability.

I'll send a patch that tries to make 'Documentation/SubmittingPatches'
less overwhelming without losing much of it's content, some time soon.

> I think the exchange Stefan cited was an example that we want to
> have more of.  The contributor is indicating that, even though the
> patch could be a drive-by patch by one-timer from whom we will never
> hear again, it is not--the contributor is willing to learn the way
> things are done here, and showing that it is worth _our_ time to
> explain the things so that the future patches will take less effort
> to accept on our side.
> 
I thought a *good* 'gist' would obviate that kind of effort. Let's see
if I could come up with something.

> Because we do not have a group of dedicated volunteers, it is done
> by more experienced people around here but that can be done only
> when they have time.  I view it as a more severe problem than any
> documentation.  An abbreviated version of the documentation to
> invite more new people means that we must be prepared to give more
> high-touch onboarding help to them.
> 
I think an abbrievated documentation whilst inviting new people
*should* obviate the onboarding help, saving everyone's time (win-win).

-- 
Kaartic

