Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0A11F744
	for <e@80x24.org>; Wed, 20 Jul 2016 15:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbcGTPTt (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:19:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:60787 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbcGTPTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:19:47 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M0y47-1b46LF1obP-00v4XU; Wed, 20 Jul 2016 17:19:30
 +0200
Date:	Wed, 20 Jul 2016 17:19:05 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff Hostetler <jeffhost@microsoft.com>
cc:	git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v1 2/6] Status and checkout unit tests for
 --porcelain[=<n>]
In-Reply-To: <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
Message-ID: <alpine.DEB.2.20.1607201710240.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VR1FURpzemNldqRBxfWq7DXxe5Tft/eBkAmVRATn6ZPH3Ud5CII
 MFJxTjeENTlwjQtQa5ySOTGiMAW+lPtoyE9/bg6FbJfwQWEPbS5uhKLeR/SES2HP9bd4phC
 yu60PTn1oPOJvFCi8lhb+HKQOoVxqahMBiQAa6bRUFZiBAjazcXXL/XzadzD3QrKPngmSdT
 WVtulDx+sUNfor1F34fsA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Tzx5cYppCkk=:49nMTjuzd4xBnqAAR8Vqz5
 3bIefkZcL5jb9oYY7ObxCF6goIrau8qtt9UO4RJJwmqQR+y9iqGkJ3/750BQYYplooDd8vrns
 w+/usHBc3eI3AZU8OV9y40AW67M0IkVK3hKkVfivEf3Yrdbj8ngqMRrGNHk0g5D6zREhSrnXd
 sT5izYrMSk7CdsKqjLSfaK+VpyRcfy1d5lNw+g0AvLeMT3+Q0Tml9u4p/cpYtC+3dV3GWhZ0q
 6BH6o37nkLlQQIZdF0ppQm20Iq1WBC5jVBrSsil6nNm3CV5/VoVfWK12VPpIehNcOACegxG/h
 CxaUWulWHopUn4WmbQtfA1GA8Atga82+Tqn+5uJYFiYITvTPuMqgjCjptnh6G8eLPcpS1NGep
 RYhJsFMFwCggeVQQNwLa9bR6I2BORfpPmlZAOCuUA4juf9I6lWWLq/irAuqPKi6PfXhmAAKF7
 lFmbQeLyIzE6AOMMeAnQSC/fEcrERWnpgBkfpD7+LeCsIgRcGC+qAGWEW+BH3gNlC0KF6mWko
 VxaneE10R0bIEbhbRU9m4+qQkz1Yoxa4n+Yx8A4dv352WDT+L7q24mmNUlqJ3HXFdQGtWrxv+
 rNk3TNgU/Bj2mNq/Q1JWv4rYFG7oyR/TixLb7eBCY3R45ZIxTecHMrZ6yMQX8/qn+JcjL9qBJ
 Xn50ag8vcL7McUoLzG/KIog1fuUOH5+cFWxsQ+NFSwnUx4TpgdXtFscX2TleotqCQz3PbZc39
 OpBXOd9G2E7TFJc2C3MtmNhXy6iw+HGYvIMX0R8FzgiEWCieQs1V8TQvIO5Br2/H1LXn+Gmmq
 Ud4mlnn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff,

On Tue, 19 Jul 2016, Jeff Hostetler wrote:

> Simple unit tests to validate the argument parsing.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

They are simple alright, but do we really need so many of them? I would
like to keep the ones in t7060, but I do not think that we necessarily
have to add the t7501 ones.

I know I am a bit at odds here with Junio, who frequently prefers more
tests. It's just that I have to run the complete test suite so often and
it does take 30-45 minutes to run here (due to the fact that the test
suite exercises quite a lot of the POSIX emulation layer via shell
scripting).

So do not take my suggestions as the sole basis for deciding how to go
from here.

Ciao,
Johannes
