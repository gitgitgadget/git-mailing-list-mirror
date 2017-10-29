Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B43202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 13:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdJ2NOG (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 09:14:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:57232 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbdJ2NOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 09:14:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7H2Y-1dCpCg1agY-00x0G4; Sun, 29
 Oct 2017 14:14:00 +0100
Date:   Sun, 29 Oct 2017 14:13:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #06; Fri, 27)
In-Reply-To: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710291409390.6482@virtualbox>
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tKgdqWAIPl8V8iPUT7OBA8r8+WeqR+TsdvjzMapF4+FJnrVowDC
 acadVWDKoNrTwZ4taDVcsrtBM942ko86k4/1U0dd6RM+RmtME5sJ7qNgwLPLUSFQNgeks0v
 +8diESus8AXGG2wcBBN32X6TTvOZf1RFw0RIglwYhDCZkEkNNr6xYEbx2n/zXbxHiLIxloL
 tN32YW1xZc1bdf8/+ARzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4vnG5ay5W3k=:LTYC0Pc0x8sB/Z58O51CTF
 wrgVnV9UNhs/4zTOCnkOBmRfKF8d9ZB+eKv1Vz6lHcWWI13iXQU04YENUTfPynz9Fd1/SfP1u
 OnfJcXbFpxhs6/EqEA6lwnGm6dUxGf/V+lfZDQDj5PFbb8VBBsFell3D7soRm3nlXse/xGa4r
 5H9/ky2DDJm8PlXw0Tryqn/DIdVA1ipScliJM1rkdvnyLR2VJu6lfxFlUhmASGIZnTKUx/8FO
 Ka4n9aUDNZMe1fT7R3xgjfm/gy2xWqpWzte+ZuDoJSWWyLaA74BmfJJJpnhsPVnTiBO/uJa4f
 9kq0GjUqQOM4/nwkOzxUf0KiZ22Y+uC6iGuUDUAIZHdXLmU23B+/rvCrWhmhrMrwLrloycnlq
 mRNxqwarN1nnA6BJVjUWbRv2T18Ed2D6AB7vNMc0UAetpSMVyOcBk/g4K7ws3QGdzEkTo2l+4
 OeogFpBR+CipjWDqczKrb0YxHH/C6hEuSVPmwB53nTdiT0PEAZ5yGswKhE+iOjEkHUuUURinK
 181vjYZMepTP5QpKaf+OcBTrQO8Yfv+pvvu1/PFgu9gbAUx4xBSk/x1pTy27MySGlQySlOa3B
 CBjcEmfTfCLDrt7JUb/IKDsVFQMXsBFlZbr6rq+p/yUH8tgFkVHeoFDWoSR6mEzoBJPFnH86P
 14iori4/mzp8YMmusqUQ8QD9bZ97BfTjSvLTWGCQkLRw996CtYat5I7Ppqq55b6UOQ4oS3kzH
 WuSpmE/Nf70N61ndUtbKLBPeJynW7rfuzeMTvGhlkJis1ELb/kb45hGhGW9aMa3Q9Vk/H5lGE
 dmN+dJkVtijtSBASAx+lclFuTHaeMnpS/MOY2sEmqyrV4Odap9ZKaQmv6U0YSH+aYt3P1H7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 27 Oct 2017, Junio C Hamano wrote:

> * cc/git-packet-pm (2017-10-22) 6 commits
>  - Git/Packet.pm: extract parts of t0021/rot13-filter.pl for reuse
>  - t0021/rot13-filter: add capability functions
>  - t0021/rot13-filter: add packet_initialize()
>  - t0021/rot13-filter: improve error message
>  - t0021/rot13-filter: improve 'if .. elsif .. else' style
>  - t0021/rot13-filter: refactor packet reading functions
> 
>  Parts of a test to drive the long-running content filter interface
>  has been split into its own module, hopefully to eventually become
>  reusable.
> 
>  Expecting a reroll.
>  The original unfortunately is quite broken in error detection
>  cases to make the result sub-par as a standalone module before it
>  gets fixed.

Would you terribly mind adding a SQUASH??? with my suggested fix for
PERL_NO_MAKEMAKER?

Otherwise, the Windows build will keep failing for `pu`.

> * jr/ssh-wrappers (2017-10-24) 5 commits
>  - ssh: 'simple' variant does not support --port
>  - ssh: 'simple' variant does not support -4/-6
>  - ssh: 'auto' variant to select between 'ssh' and 'simple'
>  - connect: split ssh command line options into separate function
>  - connect: split git:// setup into a separate function
>  (this branch uses bw/protocol-v1.)

Likewise, this needs a SQUASH??? to remove the uplink$X before
(over-)writing uplink, to pass the test suite on Windows.

Of course, if we could eventually have Continuous Testing of individual
*branches* (instead of `pu`), then we would not have to see those test
failures in every effing single build of `pu`. I mean, there is no need to
test things after they were tested already, and failed, right?

Ciao,
Dscho
