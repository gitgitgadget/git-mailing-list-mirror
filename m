Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2E71FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 09:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970417AbdDUJeS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 05:34:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:59005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1036438AbdDUJeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 05:34:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcBPV-1cKEFm0sS5-00jbUQ; Fri, 21
 Apr 2017 11:34:07 +0200
Date:   Fri, 21 Apr 2017 11:34:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Turner <David.Turner@twosigma.com>
cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] Increase core.packedGitLimit
In-Reply-To: <4c111acb3f134aa9aef8648d75bd741f@exmbdft7.ad.twosigma.com>
Message-ID: <alpine.DEB.2.20.1704211131310.3480@virtualbox>
References: <20170420204118.17856-1-dturner@twosigma.com> <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net> <alpine.DEB.2.20.1704202355230.3480@virtualbox> <4c111acb3f134aa9aef8648d75bd741f@exmbdft7.ad.twosigma.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yxN8wODqCqofkwJ1lqO3cwHQQMpSwtPvAuI7iE7rG6WAZbHJgSW
 FROBMV1+lpYBTWSrgL4ATWuVqP6WEFlugSOAdN8CbkvbwqIHI//ERXSLPDggaY56Bgi3gIH
 OBqbQD6tXYZ0uzPuPMgHduSzMRoB6UmEILv1TVeTcV3Kx5SOd1fFJ0SdXMN9bAIrD538mXh
 AaY1C8ib+7ZiQpvtxnMhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4EcVau9cxqc=:PrLwzQhP45Ot7mvLV+REib
 vO9KInzTP3wAY0AfRWV+/N099w1s+w0lbobJbAuh30YsCDoLFL55dUxvhy6z/RFrQfCzF0vyE
 Dwa3xlnNhmoUWMWKBJmu/SL9WLZS6WgNBRIJdCMMjfoq4Vf5A8rVw1d6vnVmWmYQW/HtdvECw
 2a8pCIKew4JnUhB+N8d9X2Q0Cv4nAf2/LfEuQ3fZPqsepD63cX8lmXRAIypS+aX9JxWkrMKUa
 EzfokpjFZDnG5NOdBFTQQf5GuAt5G4Ka/gCc4FWrg+jcEf1QKebcUPXinF71D8H9SXEvXIkyp
 JkOPFk003wWT7cMVGBbNkfK7wXv5WLSbhK2+jqfYkuuqzQ1wDZMIo2HO/vG42L3MBczZSHELk
 fdsTgwswOAh/m0iG9zDaybkRxVJ9/UQkvv0wvMCNSuFFNGQXFydufuYbgLbaJcDPyuErT4+vZ
 TVnEsyBYAUjnEKyUWJX0nQhst0xqNrsJVjY5SLEqNmjK3RXkjqrNIwjDbzLCuqxDvtBgAosXW
 PYYZ01MphpHPI5ZxRPsrdKm2bMGHIW0i9xFGU9xYQsTmj2jiVTCCT3x8Sz3xsKLIwYo/MOklA
 4x/+11PTs5zQLn7bWK+pbqt6bYvqs+ZsqxZoGa3+i8o7y9HPHlNEUeHRzfCSw3fj+epxJpmAR
 H0JJQHSpNM2NJYsrAKi/bCwkb29Ua7dQm7yh1dKDfKatCySama+VqpncU3gdkE9O5DpQiDZIo
 S3jcftzuX8GRHH2CNwA7IWp7oclapox9l8e7TgBAM0l1j5rD6HENKf7SNEGLhhHthhqF1FnM5
 zQkIA19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dave,

On Thu, 20 Apr 2017, David Turner wrote:
> 
> We might want to think about replacing git_config_ulong with 
> git_config_size_t in nearly all cases. "long" has ceased to be 
> useful.  More modern versions of C prefer uint64_t, but I
> think that we'll usually want size_t because these values will
> be used as memory limits of various sorts.

Indeed, `unsigned long` has ceased to be useful ever since the
introduction of inttypes.h. It is just too undefined.

We probably also need git_config_off_t(), though, and maybe even
git_config_ssize_t().

I would definitely welcome a change in direction where we use datatypes
also as a documentation of the variables' purpose.

Ciao,
Dscho
