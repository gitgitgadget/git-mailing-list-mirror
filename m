Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77772018A
	for <e@80x24.org>; Fri,  1 Jul 2016 13:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbcGANwi (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:52:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:64165 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbcGANwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:52:37 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mecqq-1az6Wl1l6m-00OF1B; Fri, 01 Jul 2016 15:51:35
 +0200
Date:	Fri, 1 Jul 2016 15:51:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <20160630092333.GB24964@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607011548560.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de> <xmqqfurv3ejz.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606301041380.12947@virtualbox>
 <20160630092333.GB24964@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eZnKPlc0y1RuWnnezQhvYB13SRo+eG1CqU4BVX1r7BgIkB4bRRG
 jzZBv3SSUi6l2K29Aw1MQG3wnU5UD51C+N/9QlEZFpxpII637MNQOIWoegXVkjEzkut761o
 7gCjVX5hPh4mMBm8+Lt3cqfQN8aiVA9hk+ObhjlK7ffZCr31HSFcQKilkcgauIJU31UbY7F
 gaKmu6aPwfgbJ7zU+iDZQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qsLA/Btr0gs=:KMS8ZWQqmc96Bhzk2XzF3W
 4NhLhXjlA5qwTHi3YvBbw0yBrzg6G8JXMhmBmMpZ8kelNKm31NdNKu+d/ys4O0jZ8AJHC7jJg
 VLAH9BMmtry9ldDta9AUbypdV9S7VbjYyV0LrNlgW/ls38p4GZLh/CaIQY278CRmEfBW/VfsT
 xGmKqJB9x4UKuGGK0abnKaZYPBvIcwamFuOFKCLnKjY19GW/CKPaY4uWerrPA3KIBSMDPf8Me
 CwL83mD8GpzstU7KNzIH5FinVOkRaEH5J3+qbeeIW9SYYr0Fj5mMagqb88FOQH2x62r4/oMDI
 etKTFIlS1Nu93Tl7a5Hlj9O1N+rjU4+b8vvC98maGNYXNa7tqjeadmWFtKo8otOSmkk8MG57N
 Ty0xO++oClARII14SmwGhg9nG5c7WNADss/dCUL8na/qf9lUYpGBoHVsl+oZ/iRjHB5rLIKNF
 DKhk67IPyS9hZl/ZNA0y1aQygXaVgHbAVoguGiqSybuEKSnR6uo0hRlJ1jOSd9N59OiLn/Qb/
 5xAn/xyYNyo+VUix2Z2zlQtnOukE8vWPbVs0VRpcUvq0NO7qtqPUwSNIlj6oS3L++nYVgCYys
 2aXt0FwQYNJKtXxV3GS6I1WHZRGJUuZbV9NceOZLUhuHkDzobo+q6DV/yuBzw/Q5ePIlQSIbR
 7Rw+7XJdy5L1nqGYlwS9JSJqf57wFQojl462zPX3O8C2eFJ/W8htzMu5AyvWUplpSvgR5CpjB
 jvNKOz0U1aKM0J8UBESbXUA8J9/Emkvy4I1QWdUWP0K28BvH/1SCNVmcljUk2iVF7GHaD2iyq
 PRQktT5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Thu, 30 Jun 2016, Jeff King wrote:

> On Thu, Jun 30, 2016 at 10:42:37AM +0200, Johannes Schindelin wrote:
> 
> > > > The vast majority of error messages in Git's source code which report a
> > > > bug use the convention to prefix the message with "BUG:".
> > > 
> > > Good thing to do.
> > > 
> > > But if we were to review and apply a 200+ line patch, I wonder if we
> > > want to go one step further to allow us to write
> > > 
> > >     BUG("killed-file %s not found", name);
> > > 
> > > instead.
> > 
> > If the idea is to make it easier to find, I would wager a guess that
> > 'die("BUG:' would be just as good a search term. Even better, I think,
> > because 'BUG' would also match comments.
> 
> I have been tempted to switch to BUG(), because it would make it easy to
> call abort() and get a coredump (and therefore a stack trace).

Please keep in mind that abort() does not produce stackdumps with MinGW.
So at least Windows developers would not be better off.

> On the other hand:
> 
>   - we could always trigger such behavior in die() by looking for "BUG:" in
>     the output string. :)
> 
>   - it's also sometimes useful to get a stack trace from a regular
>     non-bug die(). So maybe something optional like:
> 
>       if (git_env_bool("GIT_ABORT_ON_DIE", 0))
>               abort();
> 
>     would be helpful (since you have to turn it on ahead of time, you
>     could also just run the program under gdb, of course; however, I
>     sometimes find that it's hard to get gdb where you want it because
>     git spawns so many sub-programs. Or maybe I just need to get better
>     at using gdb's child-following options).

Heh. I still find myself using that good old trick where I set a variable,
loop while it is set and print out the pid, waiting for a debugger to
attach and re-set that variable.

> The other thing BUG() would get us is that we could turn it into a macro
> (on systems with vararg macros) and report things like __FILE__ and
> __LINE__.  In practice, though our BUG messages are unique enough that
> there is no problem finding the source.

That would be very nice *also* for error() messages. But I guess we cannot
have it, vararg macros being a feature rather than a standard.

Ciao,
Dscho
