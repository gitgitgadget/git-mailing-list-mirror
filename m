Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D276B1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 07:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbcIIH2o (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 03:28:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:54082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbcIIH2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 03:28:43 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MPZuP-1be9dM0jcf-004k09; Fri, 09 Sep 2016 09:28:13
 +0200
Date:   Fri, 9 Sep 2016 09:28:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
In-Reply-To: <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609090925150.129229@virtualbox>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net> <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net> <alpine.DEB.2.20.1609061827290.129229@virtualbox> <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox> <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net> <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net> <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2BSs6DKAg1UDbo2cr+0aRdCf8Lf4LSgOyu+31YkbWiMetbhNGKf
 Neq0fbRQet7UwAmt6RSQEB0u1z6s9Eu4eB8Cqra2AQFaMrCmsQlCCy4PPXHPxp0HEmgSd46
 2kNefTyIBzs3mQjOp3rFUI7N/6haksOieOWkCJDDJt/RPPu7g2WnvuYgd6D1VhZV11J9GgP
 NiP4wAn6l3eDsWDePNirw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G0CizULN0Eo=:A8CJfqnVAJSoXIafFL+948
 1gkBh8Sn3sBRjXJqppc69Nu+xL8CpeIajbgEkAdd4/XNjXYxWtgwkir0C0zsRAzdTx+BUi4Kt
 TgU3PHbtquL8TFrU/sXNg70MzmPvw9/+iWZohPJTp+i3rYE5Sc4Yt1QQJkz3dc5jvOrpU57eC
 stgXmBun39lYU2DPLJrkreSteH3aRd1V/S9JAoHY1g072kwdhzWh1iRV17Z/qUTWsDJhseQ3W
 tnKQnbTFQuRt/MwmlIpZPDFQnRiuiht0+vp240Jew5ML3z1/aA24CkSQRJ2pAeBBrysvDEE3q
 lg5g37eYVBycWpDe4tfSzg6Qk2HXisSPvxCrrifR1TcLSsXdfQfXW+vgjFOonVfTxurTDBAT/
 82qUZ+8BwYycbZy39VRj4gSymH5KARsleUNIBGjEdWwMi5nby+VLqNqA/NP7XWDl5YAKdUJKt
 Q8wgGxBTknE8osUc2xoOWCBwDuXGR/160MJgaCdxyxhRbk71+Foeji0V0HqbAOTwtpE+eAmBe
 DgImKkVK0TYdOa6HImiWJiAEddHfxqMlLeHoAKoFd/zHTLSJ/SAvSYdsUZug87FVNMDTbA9G7
 ThWqPXsu/SDordtNLQoXqZbhR4VS74q/SXEzf/3FwdQZpHbCwIYdpeeoQ+vYsTPRX6C0FGuTN
 RHvfOap6p5C7zEyWRGG2YcZlNxvCxj+EVieWZ1tMUNIIWjN43m61HDtsw7hhG7+dxSvzOSOLO
 I/knykewzY1DVonRGFauMWyYj4oFDJMVqapphhGnYllfES+6XzNzJ40MSZLnfiQDAuHBChGRt
 WB1ADsn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 8 Sep 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Sep 07, 2016 at 10:27:34AM +0200, Michael J Gruber wrote:
> >
> >> Now, I can't reproduce C on Linux[*], so there is more involved. It
> >> could be that my patch just exposes a problem in our start_command()
> >> etc.: run-command.c contains a lot of ifdefing, so possibly quite
> >> different code is run on different platforms.
> >
> > Maybe, though my blind guess is that it is simply that on Linux we can
> > open /dev/tty directly, and console-IO on Windows is a bit more
> > complicated.
> 
> True.
> 
> Even though this patch is fixing only one of the two issues, I am
> tempted to say that we should queue it for now, as it does so
> without breaking a bigger gain made by the original, i.e. we learn
> the status of verification in a way the authors of GPG wants us to,
> while somebody figuires out what the best way is to show the prompt
> to the console on Windows.

Between protecting users from their own mis-configurations and allowing
them to enter their passphrase interactively on Windows, I would argue
that the more important thing to have working is the latter, because it is
not at all the user's fault that they cannot enter their passphrase
currently, and they cannot fix it by fixing their mis-configuration.

Unfortunately, you obviously disagree with this assessement.

As I *need* to fix this *major* bug for Windows users, you basically put
an additional burden on me by applying Michael's patch, which not only
does not fix the problem for Windows users, but conflicts with my
work-around.

Pity,
Dscho
