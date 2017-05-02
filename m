Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BFED1F790
	for <e@80x24.org>; Tue,  2 May 2017 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbdEBPyc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:54:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:61832 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbdEBPyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:54:32 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1tv-1dMy1i1IT9-00LqNv; Tue, 02
 May 2017 17:54:29 +0200
Date:   Tue, 2 May 2017 17:54:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Delanoe Eric <e.delanoe@gea.fr>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Could GIT manage revision headers embedded in code ?
In-Reply-To: <135C7A92C7D64E488B830ADC2970C70132AE6407@SVGEA-EMAIL.gea.fr>
Message-ID: <alpine.DEB.2.20.1705021751250.3480@virtualbox>
References: <135C7A92C7D64E488B830ADC2970C70132AE6407@SVGEA-EMAIL.gea.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jY7XIGK6mRJ2gKHkQIz8jUU1CTUbAGCcQA6DcooBB9Ce1xOw3bq
 4VXN3vUp3OlC7p8E9X0uVFbGwpHHP2o23wiANqwavdfEjru5pMVVgwBpHjmEXu1vDnBSymf
 tfSmp0H6gncE7bu6H0YbsRj6drLwR5RbU/V70yhpOn6ho3DTgZXqUOFFtJ3Bix+7miIKwwd
 VS64slz3ky4YH+SZtYqNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t9q9ydUZLMI=:szIzUBlXdDHIPlvZ0SrPWw
 kyD8LOxEA28YmTHw9tfzT2sgPh7hCUke1X/iE3iFi/nILKZIyjIh0zboc3P/KyJgULctezyX7
 laIyF+HkEeq3qjXziOCS+sh/rVCe+qDUTtxIRcOGIorFRFFYyKFp62dek0G7znd7FizQThl3M
 Ip0yh9xPJ7hQcEgFu6vimfCV7uMZMcVJEKIEVGdz65IYtEXxUOAxqryFpfYJqn6IGOg69Hmor
 xvxFwU6TKiW0ndnw3aREIVno9qU6mdPXb8BJ5eKH/fKOneIbp98f8OKIiOW9cZZb8RepVcXev
 fyAYyvASj49DuxqrYZ4PKI6iZdEYLD+bux/rV4T1Vqmbxb4/0JB4q/9MJm7SkofF3nNziApVd
 LWvcL42ORgc3hCtiasQwJpIFV4He1EYL3aZAuK93G1Qg9c8r3Jh3ASdmRazTvWsCvVo7635RA
 FppkxtXS+lWEjXRvCbgRKOIizjdTolgaiFauzJ47mhdfBtVblCq3qKD8ShKcSvm/s7pLhKkEa
 MQy38+zSiRyKZfb2B0c6sEeocJsB7ydvH3InJdJSDR92dKx2nKZRdEW163HJW2rZeXDpKF1kE
 H6DntL7qcT+cFcINnEDUXcESEQRWhJNkYMn7SH7GTDWtLy0qb3WqcoegWVE3EIlkSffnN08ei
 3lSpOgF1RITLnJHG6bZvDNNYSLfxrW6/llxg8UM4EjpOq5GRinQ/dLUe19aKXyhAqS3vJ3sKQ
 8yXwh0VPjOaO20RIz+9eauwXiEKCGNWVYuxiOkzOZUR9fKuZ/C1HILfHPNMm6oGbiy9yhalHD
 eOQrg5/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 2 May 2017, Delanoe Eric wrote:

> Could this kind of "keyword expansion" feature be added into GIT ?

Back in the days, it was decided that this should be part of the "export
as zip" functionality, see the `export-subst` feature in git-archive's and
gitattributes' documentation.

In reality, what most projects do is to generate a header or some such as
part of their build process. Git itself may serve as a case in point:

	https://github.com/git/git/blob/master/GIT-VERSION-GEN

used in

	https://github.com/git/git/blob/v2.12.2/Makefile#L390-L392

Ciao,
Johannes
