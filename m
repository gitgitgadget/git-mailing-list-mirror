Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FEA1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 16:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971348AbdDTQ42 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:56:28 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:33212 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971347AbdDTQ4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:56:25 -0400
Received: by mail-yb0-f181.google.com with SMTP id 81so32794942ybp.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39WnauvNBAgw/oBe13gbKo98VIrz10SvlA+WEMBs2v8=;
        b=qp7LTWjVqYplMoL7vBToG0cRldnS24wTpm/971RYPC+hev4skk6ihkoWB6qkwYbDnz
         shm5gcr9VGsUHX3sj2dI+1IxAeUT9H01W7GrBnwMAm83IzKY8i4IjfR1d9308/7Ksj8P
         /BDC5K9YjCpucUF1eZJy/iKjt/MtUdgFNAQT0WLrWTvKdwzifEFuQpivMamlbqzE9SQd
         7wwkcEap6REJKe8ZQ4/vf6l5mH3ooSsEdNdycJWq/t8bTFjf1YZDq2YViD9ZBeaVPrd+
         u6qUEc1077rQTjbnBFfHjYW6Z8DbidYjjpSThUEcX+1j07Rt86OA9o5oSqH6g3fYuGkr
         c3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39WnauvNBAgw/oBe13gbKo98VIrz10SvlA+WEMBs2v8=;
        b=nwlDT58fK2FrNkA4QVflZv2xqvFEuecHoMCkhtr19q+J95Pdo1c1U1llc6pghTHwd6
         H4ZTCbscrhFaJ3Ea9zV/1LYeX4uppz7UAOSePAB7L4ODECnAeUDcjF0zzdEIo1GBiGOD
         NoUOup6BGu0tQU7JOU3rz3Cghi3Zx3MxBIg7FahcDGgxQET7p8LbSN30WVR0GVqUezJb
         4rI/Lc/asTa972LyquzNdpxE9hKgowC9CoWz+x9iXWn3vgKcFN88JKs/HOosrmlA9bXv
         SSf+lytUOLzvmu1e/wOtU/Cy0WAjrYU1510DRROmYJqbywBdCicxpxld8HVABJ5n5gY3
         bdVA==
X-Gm-Message-State: AN3rC/4f71HVxIvms7tNOB+qgjc7rbNgIcSqA5fdjYv9wAEDCHUlMW9U
        0HKDUrF79Qc1g5+W
X-Received: by 10.98.201.72 with SMTP id k69mr8590249pfg.74.1492707384705;
        Thu, 20 Apr 2017 09:56:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:90d3:adf:57a8:ebdc])
        by smtp.gmail.com with ESMTPSA id p28sm11561981pfd.53.2017.04.20.09.56.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 09:56:23 -0700 (PDT)
Date:   Thu, 20 Apr 2017 09:56:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
Message-ID: <20170420165622.GC142567@google.com>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
 <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <alpine.DEB.2.20.1704201523390.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704201523390.3480@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Johannes Schindelin wrote:
> Hi Lars & Junio,
> 
> On Thu, 20 Apr 2017, Lars Schneider wrote:
> 
> > > * bw/forking-and-threading (2017-04-19) 11 commits
> > > - run-command: block signals between fork and execve
> > > - run-command: add note about forking and threading
> > > - run-command: handle dup2 and close errors in child
> > > - run-command: eliminate calls to error handling functions in child
> > > - run-command: don't die in child when duping /dev/null
> > > - run-command: prepare child environment before forking
> > > - string-list: add string_list_remove function
> > > - run-command: use the async-signal-safe execv instead of execvp
> > > - run-command: prepare command before forking
> > > - t0061: run_command executes scripts without a #! line
> > > - t5550: use write_script to generate post-update hook
> > > 
> > > The "run-command" APIimplementation has been made more robust
> > > against dead-locking in a threaded environment.
> > > 
> > > Will merge to 'next'.
> > 
> > There might be a problem on Windows with this (that's just a hunch, i can't test this right now):
> > https://travis-ci.org/git/git/jobs/223830474
> 
> Thanks for keeping track of Travis' failure reports. From what I see, the
> latest iteration (which does not seem to have made it to `pu` yet) has the
> !MINGW prerequisite which should fix the issue. Hopefully my suggested
> addition to the commit message will make it into the commit history, too.

Thanks for catching this.  And as you pointed out the latest reroll
should fix the issue.

> 
> Ciao,
> Dscho

-- 
Brandon Williams
