Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46461FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 13:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdILNjs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 09:39:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:59199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbdILNjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 09:39:48 -0400
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M09BU-1db4TP49eO-00uKIV; Tue, 12
 Sep 2017 15:39:40 +0200
Date:   Tue, 12 Sep 2017 15:39:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Michael J Gruber <git@grubix.eu>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
In-Reply-To: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.21.1.1709121538360.4132@virtualbox>
References: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SeUGn+Dtzfn3UYX0GTmqumzSjUSIc98GF0Fzk236cmCY2GcmoG7
 hNhP4c13gcFWyRYz+PPlQo3ECAvdIWctWehgd93ocaDVvYxD4CSU0WR4HJeNdRXAbc8Uapy
 /ZWf2X3Vwev3xcLW7mTOqNWULqIFzWcFz1mUlBSKKYHWnIRG5PRsk3/u1mPi+ePztsxsBBe
 ZE+jAjE1gASI+I/5zLAhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fS95vfM5HWw=:S9idZX0w0B76qsiCWkCW81
 V79FNAQWm9d8xdGanBSVayz/QM/xK1V0cDwaX/lV0vxMnIurFXbKLw+2mUO47Y/yE1wbcZruH
 MQvLmA5Pbai11i5NLLGCSpA2opp5z3DamYQntqUhUYscGrIEtmgP4dWyR6sABWViz4kRgBm2T
 PUaa2lhxoeQTHQAAwYO6C8sL7KDlCWCJ8amnsv4xW6R1FTcOtJ7LjOOOEeIX2VJrQ6pLTBG0P
 FS0oCqdw+LUKpNnvEBXmaKvppFJYBcF8SdoCoz3GoqJ72zLGMMjZUW8D7Yg4AJyfo7xGqL8Pb
 PC4mSTt9XcplbWpugQrOGsJPgJfMox2cpVdU+mp76YbVbge8JyBrKAZcIeQhXG678JkV2o8Il
 em0Qw8uDrA75/uWKenv0f4o1ozMuqezpPwGTlzwFxtMwemGJsbgZO+0bb6A0kC5LH5YPAtrXH
 DoKPFEX9SFhFOxWPomMxdmVWtq/vK2oWt3IGvZNr3ke956SivthhFEJwe6+PgtM/BodBjj0TW
 CQAFgRTQc39i/fnTPXGURefvio+FyqZ+gRdzkoJjkmpnAXJzvR8XgdxoO6lJFC4pN1i/b9Nq/
 ZQi/yacGZOYlAZH0ydRFLJzDKckUhGx/i9BKoMxr6ihsE4I6WTu37/FWijzN+9yUuEm8fmEU2
 T0Wz182HOCIp7PQJxNKujEtZ4h3ruX1tZSvLx41FEmepgERFQsgnBmbt4bt+jdw4RmKaDolW8
 BrgH9SkZix/1nXKqFM1x9R1DgFmE/JHrPEdE5O7j9efpGnhdBpaqnOqGmCIA58Jlkq/bWNNyQ
 jzxwj0RGJIPtE2N1NtYwQdBLAUT8Kfe5UgZOLZVzjhJWtq/5lQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Sat, 9 Sep 2017, Ramsay Jones wrote:

> I ran the test-suite on the 'pu' branch last night (simply because that
> was what I had built at the time!), which resulted in a PASS, but t6120
> was showing a 'TODO passed' for #52.
> 
> This is a test introduced by Michael's 'mg/name-rev-tests-with-short-stack'
> branch, which uses 'ulimit -s' to try and force a stack overflow.
> Unfortunately, 'ulimit -s' seems to have no effect on cygwin. I created
> a test program (see below) to eat up the stack and tried running it with
> various ulimit values (128, 12, 8), but it always seg-faulted at the
> same stack-frame. (after using approx 2MB stack space).
> 
> So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
> on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests, but
> haven't looked into it.
> 
> Given that 'ulimit' is a bash built-in, this may also be a problem on
> MinGW and Git-For-Windows, but I can't test on those platforms.

It is.

Thanks,
Dscho
