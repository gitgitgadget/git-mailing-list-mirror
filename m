Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF38E20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 21:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbdK2VlA (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 16:41:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:53716 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdK2Vk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 16:40:59 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meduu-1eVEq50kuG-00OD7h; Wed, 29
 Nov 2017 22:40:53 +0100
Date:   Wed, 29 Nov 2017 22:40:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
In-Reply-To: <b4331bb3-db5d-e4f5-54db-f04d77385ae7@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711292236010.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-5-liambeguin@gmail.com> <alpine.DEB.2.21.1.1711272344290.6482@virtualbox> <b4331bb3-db5d-e4f5-54db-f04d77385ae7@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UPffKZDvFtopUtyHYivha5seMs8B/2/OPfisn94CaI7ucMvn2cX
 9e8kqCtDjwXojlRO6iPAVjyLDpCXNAK+9/LT6HBZjY4ehT3iRLQIser4LjViuVbwvtgd3Zz
 +IF/t8Q3xpG5NHsCXsXe+EdBsbJQp6/5JiHcz1pipmGuFnvalFzz6FW3O6OKbAtmGfIQXA6
 B4hOmbN5tFKoUkMUCYwFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:75GjvsJ5ByU=:tCDY+BwrWdo7Iy2C+kjEAn
 6w6UBN09hJZ95P9aiyjs8LsnaG2YNZcJGCZhV7IT2QwQ1bvcE8G2ITcSSy2HBcYnnR2sxAATh
 CIPykdX/0r7K4KHvhpyAtLqsanLaUj6IIYlQkpB6qMFK/HSHSuUMmc+peJM/S7uiwTY8v/fR+
 7hdY52hSeKjp71zzj110bTViEqKoas0X0/U/LCfpk8L1QDtNQ6/YaaUdj+TAJrGizHeNaSmp2
 FcV+Hhktswt2AgjeZ1KaxqOtacswI++kFq32iXvcl1U8Z3NpiRJIXcbj+q+jpAAoR9AQsMyYv
 SWwxu6GU/KiG1IdmZS3nvb5BW+TmmUtma/eu2bdVnZ8g74b2nlUkrpFbJMpbt/U56khRzFtag
 /sZA1WolGKVDksOr23KKhw4BNKMFgPfAKHaGdR/W26k+Yci9ZkRtQpvMhXqdkbWKM0YSX4YF8
 uqr3yA3/GDIjJ7uEboGXZww/K8YCmW6R4IJGLsQlXaL7SZjGCVdNP6Ueu33FPm+cLYAm6LlpV
 laUw3aqUh7Hp0lXB4onSmwWp7sIcKiE0+n+wM1xaoXTBZSYuyRfOqbd9T8bkZBvowzZvIFsd0
 0QVUzdiwKbuqErssDsV2PZtaFBaNPIk9tb53JPz9iXt0l89XlvlbCNiKQdGbrNzcID5PtLZy5
 bvBJqRSs6USbXYgyRszpq+8MmHKCoHhU8mI7RIy5BN2sFy7P68l5dvkWIyChxIu8b0gzm0RNm
 bVWWVkQdz/nU3/ynrhOONXHXQJ+jJYUECLd2pZRdPfoGCMpPkhvPN0viwHSp9GvdRn2SRl8yk
 reyScvBbsFeovT9UqlhOm5E5pHfUxmPt0OxN0SCGj9tfFLFn4o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 28 Nov 2017, liam Beguin wrote:

> On 27/11/17 06:04 PM, Johannes Schindelin wrote:
> > 
> > On Sun, 26 Nov 2017, Liam Beguin wrote:
> > 
> >> @@ -2483,7 +2491,9 @@ int sequencer_make_script(int keep_empty, FILE *out,
> >>  		strbuf_reset(&buf);
> >>  		if (!keep_empty && is_original_commit_empty(commit))
> >>  			strbuf_addf(&buf, "%c ", comment_line_char);
> >> -		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
> >> +		strbuf_addf(&buf, "%s %s ",
> >> +			    abbreviate_commands ? "p" : "pick",
> >> +			    oid_to_hex(&commit->object.oid));
> > 
> > I guess the compiler will optimize this code so that the conditional
> > is evaluated only once. Not that this is performance critical ;-)
> 
> Is your guess enough? :-) If not, how could I make sure this is
> optimized?  Should I do that check before the while() loop?

I am a fan of not relying too heavily on compiler optimization and e.g.
extract code from loops when it does not need to be evaluated every single
iteration. In this case:

	const char *pick = abbreviate_commands ? "p" : "pick";
	...
		strbuf_addf(&buf, "%s %s ", pick,
			    oid_to_hex(&commit->object.oid));

But given Junio's comment that the assignment of `first` was too far away
from the line where it is used for his taste, I guess he will argue (once
again) the exact opposite of me.

Ciao,
Dscho
