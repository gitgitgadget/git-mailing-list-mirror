Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14AC1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbcK2UQd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 15:16:33 -0500
Received: from mout.web.de ([212.227.15.3]:49821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933758AbcK2UQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 15:16:30 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdalO-1ccarg1RLe-00ik63; Tue, 29
 Nov 2016 21:16:02 +0100
Date:   Tue, 29 Nov 2016 20:16:00 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, eevee.reply@veekun.com
Subject: Re: [PATCH v1 1/1] convert:  git cherry-pick -Xrenormalize did not
 work
Message-ID: <20161129201600.GA14333@tb-raspi>
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
 <20161129163023.23403-1-tboegi@web.de>
 <xmqq7f7mgmb9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7f7mgmb9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:vacNAMXOMb8HhVsBk2jv3wgyyRrhxnTdV/klrX2A72BvfIzFSCd
 Zi3Ud93yWt/df2cLtfUrIpRNvleLh+Rs5Qu4tDPGBlnp0gWoz8tzCA4s9XpzO6PLftxj8WQ
 tgRsK/PmsY2gt7hMtW2X5p1L9lJJuDIMLStLPn3xPI/+vaR4kiDGAWjxbyFwzzygQd8NcyU
 IPqPqylm8Tgagu83uqm9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4zgO1MZZXwU=:A02epDCIgpcNaaLjOcuO/7
 j/6pYhu/OBME56ACiT9HrpDqc/E+FiMyIuh5ZW+d57wSB3J7lpZ90D8FGYcaQ7p8l1nes7+J7
 thUZSqzh55Y1JUR5P4vEVTWgLQRXqrCQTTYDPnSgC7s4rDPQ+1FikK4SriNairf8julHZK3yF
 v85nq4Uq+2lUp/ijlgjHeUpxRJN5+2NFX7Tz7W5SKOlr1QOySb1HYw+sq6Mfnqp5VS/abs9Yd
 V2pS3AEIWpmL0hl0PfiB0/q+4NkOonBXoHcgAOzgNK+xlu+HdOcAcoegXP7YLzrPsD9ohHYEN
 1McSIS6PynP3SW0DmzOxZjAz8Pm+KR2vINaMgGX981Ii46cqGrKwF6536KueK7ngo9qsWnBPg
 W+liDq1T8wQdMkUvaisgnyKb4un+r3TQLXsaqAs3YxvjLOpseq5fXgcCcprjBkWSOdryNi78l
 GQPcP9kVKSo+mWeJCX1jbeYISsxYwIPALZq7Inl3GTaS4i19uPyxagE9tcALggCf2oRnjan55
 a2iT9A3+/v8BgvUYeqkmDK1asnibY36uJ12crQEaDh9ZM8wtqnBeThjJM9LGeZa3fHoL6WsHC
 dCyJAlhQC6t5n5WUvqgcI4NZTivdrE6Tp9ftKwaU2dJZD6BKVZf2rdG9VXGvuWC+EQiFRgiqP
 Z+u5CSVL4eXt56o4yhaJOm7lbZoKQk9KrfmKKR7ORv4WwV/IWjHY8MOMMBo9UKaQ8LtwmR2aZ
 3+w3AhFzsNmRLZH7SBKWc+ynFgpueyju0EO4updu3zNWVvbnxViLYiDUwMU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 10:42:18AM -0800, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
> > From: Torsten Bögershausen <tboegi@web.de>
> >
> > Working with a repo that used to be all CRLF. At some point it
> > was changed to all LF, with `text=auto` in .gitattributes.
> > Trying to cherry-pick a commit from before the switchover fails:
> >
> > $ git cherry-pick -Xrenormalize <commit>
> >     fatal: CRLF would be replaced by LF in [path]
> 
> OK.  That's a very clear description of the symptom that can be
> observed from the surface.
> 
> > Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
> > SAFE_CRLF_RENORMALIZE must be turned into CRLF_SAFE_FALSE.
> 
> Aside from needing s/CRLF_SAFE/SAFE_CRLF/, this however lacks
> "Otherwise, because of X and Y, Z ends up doing W" to explain
> the "must be" part.  Care to explain it a bit more?

Thanks for the review - how about this:




convert: git cherry-pick -Xrenormalize did not work

Working with a repo that used to be all CRLF. At some point it
was changed to all LF, with `text=auto` in .gitattributes.
Trying to cherry-pick a commit from before the switchover fails:

$ git cherry-pick -Xrenormalize <commit>
    fatal: CRLF would be replaced by LF in [path]

Commit 65237284 "unify the "auto" handling of CRLF" introduced
a regression:

Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
SAFE_CRLF_RENORMALIZE was feed into check_safe_crlf().
This is wrong because here everything else than SAFE_CRLF_WARN is
treated as SAFE_CRLF_FAIL.

Solution: Turn SAFE_CRLF_RENORMALIZE into SAFE_CRLF_FALSE before
calling check_safe_crlf().

Reported-by: Eevee (Lexy Munroe) <eevee@veekun.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
