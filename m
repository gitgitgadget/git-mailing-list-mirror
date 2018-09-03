Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5FBB1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 12:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeICQbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 12:31:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:50511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbeICQbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 12:31:46 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWxtA-1gQXwn0iW4-00VuCs; Mon, 03
 Sep 2018 14:11:49 +0200
Date:   Mon, 3 Sep 2018 14:11:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 05/20] stash: add tests for `git stash show`
 config
In-Reply-To: <xmqqpnxz33v4.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1809031409050.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>        <65603caf56cfaeb1dff92546b7efe38dccb2d071.1535665109.git.ungureanupaulsebastian@gmail.com> <xmqqpnxz33v4.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ijkiL5xW1Bx/oLnWQKe6u6EMyU/R5OIKudtvTTTk07/GtSu9jqb
 ba5CfmU3ka14NG9eEwVQ8P6+ZJzjbTNipoxoheQOYeVjKPqgJKnBjvXf0YpLYIu8dd42BX9
 UA1Tw9YbmK8doDJ+YBNw/0g1kjfHYErafjQTdCaRLr0brm7iE5n3rftXYI3hiHUlZUUETIX
 kA1c/TOHkPh/pOxcsaFpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FppfmcMJoPY=:aGWnyWSp0z/M5At9eicNbH
 wttrEWOwum/hfsMAsBKK9Py0Sfx63zcYBXYHyVoTxM+V1CkeFHlr3HzFdzaM8af6RgIJMgGUn
 BG+/vvdsB6M64IgxNN2IegwFdoT7t6FuMYFfvMnWzEKsUgAvQhqfTO5RE6IDpxBBfjulzIk/v
 92tn0sRzaQtx1pWzHWHDsNFIMygQ5XNelBR4tQckN/dp6YhU6RKUyim3kieyHhTxl7A6hEGO4
 KRr9hRqAtxzvYIwRCegBCqJ5hW+ZZKZ2UN0O/YSXNKpfZ719G9zodvNqTb+kYtT2tdmP0C4Nv
 a8D6H07Bk+khV16APMc/KDawCIEuSUc+EW+Z/dGNI2yw09PDuz2SB8POvAD4NgdzttWAb3htA
 LwNrwTpM8MMMTFu0wCoxwDnruqYbLHGftC1kTZm3kLW5THJPshZfRcRp2HselKZ96h4HlLFTZ
 DD65X81eIs6U0lUFcbpHCSNQyYcG72qYffeapvR/Mxg378+wYLPHAGL0NhMwNxx9+UaBMMKKA
 ZQZ5XhaCfQZtB2YbxL5pGOIkUHksLKXrLaczWV9gyWG7ZHS00Ilc9qSXSgAlVRtyRJ4PfYCc+
 WUibZ64RQvni4jP4+fxvu/je0HXRlCoWQopMTx5sVlCTNyRdYK3gjek/P4JdS+kGX+5ArOs54
 Cw2lcpjDEVR6AhIBLeSQnEtp+HubYVyuE2pZtW0+hok3OurkRZMIheg9WiPBltpCjEpYZzaHo
 riu0+G3zu9KEhyg+sPO3pw0rq5JawiBCOdcHAFFNMFrlFfbkA4z4zEOx2Z8KCRF4V5Us7446O
 n+sxq82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 30 Aug 2018, Junio C Hamano wrote:

> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> > +test_stat_and_patch () {
> > +	if test "<unset>" = "$1"
> > +	then
> > +		test_might_fail git config --unset stash.showStat
> > +	else
> > +		test_config stash.showStat "$1"
> > +	fi &&
> > +
> > +	if test "<unset>" = "$2"
> > +	then
> > +		test_might_fail git config --unset stash.showPatch
> 
> I think you are trying to protect yourself from an error triggered
> by unsetting what is not set, but for that, test_unconfig is
> probably a better choice, as it still catches errors of other types
> and ignores only that "unset a variable that is not set" error.

My mistake. I did not realize that tehere is a `test_unconfig` when I
suggested the current version.

> > +	shift &&
> > +	shift &&
> 
> You can use "shift 2 &&" here (not worth a reroll).

Again, my mistake. I was not sure how portable that construct is. (Is it?)

> 
> > +	echo 2 >file.t &&
> 
> > +	git diff "$@" >expect &&
> 
> When the caller does not give $3 to this function, it does not look
> at 'expect'.  I think it is clearer if you did
> 
> 	if test $# != 0
> 	then
> 		git diff "$@" >expect
> 	fi &&
> 
> here, and ...
> 
> > +	git stash &&
> > +	git stash show >actual &&
> > +
> > +	if test -z "$1"
> 
> ... wrote this as
> 
> 	if test $# = 0
> 
> The only difference between '-z "$1"' and '$# = 0' is when he caller
> passes an empty string to the function as $3, which you never do, so
> the distinction is theoretical, but using $# makes your intention
> clear that you do not mean to treat an empty string any specially.

Good advice in general (in this case, we know the callers).

Paul, when it comes to shell scripting, listen to Junio more than myself
because he is even more of a shell script wiz than I am.

Ciao,
Dscho
