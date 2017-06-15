Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD0A1FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 10:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdFOKfL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 06:35:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:53714 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdFOKfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 06:35:10 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK3bN-1dMpgs1Luf-001NXP; Thu, 15
 Jun 2017 12:34:51 +0200
Date:   Thu, 15 Jun 2017 12:34:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: preserve untracked cache, was Re: What's cooking in git.git (Jun
 2017, #01; Thu, 1)
In-Reply-To: <xmqqvaodx6g4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706151232020.4200@virtualbox>
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706012052480.3610@virtualbox> <CAJZjrdVS5e5udjLtZoZcTEUg8WGFPuaG+MB_enPJ9poti3LktQ@mail.gmail.com> <xmqqfufj47oz.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706021211300.171564@virtualbox>
 <xmqqvaodx6g4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PAdyt/4JvtSreYRZVYbgMWHweiXUl8JMjfhSjoZGH6dOs/Kelzq
 II+P4UE2mp8VIDpW0828LCzb8DPpFCdt6V7HfsJE2Kapd1dL+G1NAU5iUCI62I2cmQ3nJm+
 q6d+zQ97ceJyfUKsLzr9xnq2A/DUCSq3L4jggwEqM5T+SXbdOV8t/lg+BRMEvydjU2aXvAt
 64p0DpSM5/9Gwu8qQAO1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bhUExET/V4E=:TuVYVZtfh4dx9NR6cbtyss
 lprzfCinwkhVi5bIYfjbgEu5uYPTj223ZEdZX+JgL9PTgHqNywon40FH7AGgQaQ5NTTai0lA0
 hfFMGEd48gVbAuwtO0uV092G7J1yUcvWV6EuWOHQJ+KP7e3egNg2TL36wTgIJrxIQ++9rx0cX
 uQYIS41t1aR5YNyq3me6evR7GMvrr275zpp3XXyyPHiOrsIObpZV+Ver79/h2PEDd1XKd2Tj9
 S5c4ntbrTByZMyizRLKJFeOKnDdoOkMsD8YnPeYnG8LJE92dJz9RmaeDyZrn/UPeV5jBika6U
 XmVN7n/4ARmENggwyBsUpayiNq89yDQLbaSsBax+UL8ngKsyZZsTMRFiHA+yahjX6xhXFnZLk
 EnemVCew+RBVGMWKw8pqPhiD50AuFxZCcy31rxewemn5didKVFxyng03t6Mru4al2ykYVXWh0
 8N97ATHWEhNcX+yAP+JEiYw6SFbcZkqqtquU/zWc/wmEuko+dEFMUji3y+n5xEDMuSBT3uKia
 ylF97m+fbm3vrziNMQux9vm45XUnJBRAhwXk2pl2UvUgV574aeq4JcLF6CiEZOiwg/DgS0arB
 MCZX1qvXxRscX1o6GjHmOCiPyeGMAAuVdRfhxe3GJkXJrF5VQXdgcdBAO0aiLLeU8KbAQdYD8
 0+AtVQThr8IKvzGabw938icZ0xLtL92aIT0JTPjGXFMbGfTSY3zQ5GWFaCrKS3aAYDqUe/4EQ
 D7HUxabUvBoHG6rOW0+9TFdNmMOlwyT89IUlMInsP8N4gmDrgxUVAzFXmMuJXFhIqblqxFNII
 dapVkLD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 3 Jun 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 2 Jun 2017, Junio C Hamano wrote:
> >
> >> Samuel Lijin <sxlijin@gmail.com> writes:
> >> 
> >> >> What is holding this topic up? Anything Ben or I can do to move this
> >> >> closer to `next` or even `master`?
> >> >
> >> > It's in `next` right now (3196d093d6).
> >> 
> >> Thanks for pinging and checking ;-)  
> >> 
> >> I think the topic was merged to 'next' on the 23rd of last month and
> >> graduated to 'master' in the past few days, together with other
> >> topics.
> >
> > Okay. I never saw any "Will merge to" message, so I got worried.
> 
> Well, I cannot quite help if you are not reading them ;-)

Well, I cannot quite help when I am expected to read long "What's cooking"
mails with out-of-context information as opposed to replies to the threads
discussing the actual patch series.

:-P

I understand that it would be hard on you if I expected you to untangle
your What's cooking discussions into the mail threads with the
corresponding patches, of course.

That just proves my point about mailing lists being an inadequate means to
perform code review...

> Issue #06 of May marked it to be merged to 'next':
> https://public-inbox.org/git/<xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
> 
> Issue #07 of May marked it for 'master':
> https://public-inbox.org/git/<xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com>
> 
> Issue #08 of May kept it (i.e. no issues discovered in the
> meantime):
> https://public-inbox.org/git/<xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
> 
> Issue #01 of June reports it in 'master':
> https://public-inbox.org/git/<xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>

Thank you,
Dscho
