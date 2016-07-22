Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A964203C1
	for <e@80x24.org>; Fri, 22 Jul 2016 07:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbcGVHct (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 03:32:49 -0400
Received: from mout.web.de ([212.227.17.11]:63464 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbcGVHcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 03:32:48 -0400
Received: from [192.168.178.41] ([79.211.127.152]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M09ZI-1bByrd1BZk-00uLkc; Fri, 22 Jul 2016 09:32:25
 +0200
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree
 setup
To:	Stefan Beller <sbeller@google.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
 <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
From:	Jens Lehmann <Jens.Lehmann@web.de>
Message-ID: <64e9e8fc-50b3-98d8-fca8-6a70028c6398@web.de>
Date:	Fri, 22 Jul 2016 09:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jkVOot9P85GvoXviG5ZJja4rw7zTL1/+0IUZbtMmhowLAmHYDb7
 dEhBJKh5BKxkuSODDyht4ap9o1t88YR5fxgU5XvzHZpNa6ivhMclN0B4bZg2ydGN+dqJ1Yx
 Ug2Hm7v6bY7ZoZEY9GUeHKWgGjxO6yut/aJeQLP/7w9qaLvMbfuPRFZ4FzxCSHAIQNzIS/I
 z/pUhjJrbWK7oLNNJ1ZdA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TocoaT5ebjk=:JbQSm+IiBI/LN7MWK3H2AX
 q5h8hRe7QDkKklFOjD1xBOdQ90g4mDhfFmj9ab48M/ieUWomNR+104mAGtLXc/ctFc1ZYAxcJ
 t50PR5SBa+cvyRjPAQqvVSQVuqXYLG5HMGBYyh/s8B+yCsGSCfxuX3MCdXGSRPJV+KwuJG8fo
 moXsQqNyqWmk4Si26nwFvh2Wg1PQdeOJifjbPsD91wxbrvI/O3bC9x4odvyou8ih9tsIEsT4n
 kEM5uH7wKC8MIevonGGcelR3uKPMmgVPPDqGEqNoLc5HCzS06BvMt/hXmnYkGg4Zlr2Y6d+8n
 RZnGq7ETQf0CL9h1WDjOP62yhsd/1eyFCSFgpWUvOOwC0K9a5yd4RrgYClU1Vow3878khhLSB
 PgsF/haVhm/rDu8diK/d8DXJMi89jnbVuOlarpeS+ZDs3SwYeAhW5VH8xueP2yvJVULGaEzp9
 umGlWQC1MjbuQeYBTppHuEP2qQI7OXpziZGYPmXw81SXM/aCy/6/pgXVuEV2yq0ZlB/U98zKn
 P0u3lMp4gWZ6JUA1LOuwKBeyX0dbRix1UHjzKeVZrQflfrpx+GNzu44vERvRZkF7H/xhiUdlQ
 a9tFIt8ekYsqL8TO4SYJpu5pktOqyTfWazUjhWfWX+k0vgx30al4KqaGO9kPuJ15WSma4uhHg
 WAbDrduGlK7K36H+xrQrNPqWzcw7W4Gfcpomu+xrMqCTZhZ2PBwF6abnEMJHeHkQJs1QlDnKe
 2Br/ptPaoG2bw/4bV0BEyQpUPaXY6G2m1Ot3PCGWwwv03xWzqaOzR3Prem7ungcB9QKCmijSJ
 ofQ8sNZ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 21.07.2016 um 01:22 schrieb Stefan Beller:
> So maybe we want to drop that series and first talk about a migration plan from
> the current state to a world where we have the existence depending not
> on the url
> parameter, but a boolean variable submodule.<name>.<good_name>.
> Depending on <good_name> a submodule would be ignored or tried to checkout
> in e.g. `submodule update`

Whoa, that's a very intrusive change with a ton of compatibility
problems waiting to happen. Maybe its simpler to make "git submodule
sync" aware of worktrees and error out with an "you cannot use
submodules with different URLs in a worktree scenario" error when
the URL is going to change? That should make most use cases work
while avoiding the problematic ones.

> If we want to move the current behavior of submodules forward, we
> would want to have
> anything but the url as shared variables and then use the url variable
> as a per-worktree
> existence flag.

Without having though deeply about all submodule variables, I see
them as worktree specific. E.g. "update=none" is used on our CI-
Server to avoid the disk space cost on some checkouts of a certain
superproject while using "update=checkout" on others where their
content is needed.
