Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1574120C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbdK0Uoq (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:44:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:62203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbdK0Uop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:44:45 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyVIk-1fE5qj0dks-015nsQ; Mon, 27
 Nov 2017 21:44:31 +0100
Date:   Mon, 27 Nov 2017 21:44:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
In-Reply-To: <20171127052443.GB5946@sigill>
Message-ID: <alpine.DEB.2.21.1.1711272142120.6482@virtualbox>
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org> <20171122161014.djkdygmclk227xmq@LykOS.localdomain> <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org> <20171122202720.GD11671@aiede.mtv.corp.google.com> <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com> <20171122220627.GE2854@sigill> <alpine.DEB.2.21.1.1711252240300.6482@virtualbox> <20171126192508.GB1501@sigill> <alpine.DEB.2.21.1.1711262231250.6482@virtualbox> <20171127052443.GB5946@sigill>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0sslU7aIDgsBKpZ/DrlU1UvY2N7XSxQKmk6whnjvx6uZJ964jO+
 in8NV6+LNewjGYy+jWn1/UNVIqivwigGDVOZX6kKAjkx5NTj3A+8bz9BHR+PbvjGqSi+4D2
 rSXzxACvZrPjsSnwR5WO6soLQZ7K1F59UdPjKsmst35CxdCU6bN1Er9ftj8o3AX9VtE6I3A
 Lx2/cdW9JjPdRLEyUKeTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cngqOMF2VvA=:+/gYqskdNV4+AKNhQbNQA3
 RKEO/zNGFbttJ0Xe8pHv2rOdKmttAGaAKQCbFQFWVgJCBi0AgfZoc2ihWhcHpfczwEdJE+KV7
 AnHninTiS7OZ9SPEdXhvc8I3teuYVxKCBr/2Cy/cYhvLaSKXuDoGW+peHXgO868kuSoaGzXLN
 OGqsxFvVrt3YNBUOOrm6x3dIMmVaSnnER/Rl4+G4WPX09hZNst5O7LRC2g3RyhazDrAveudJ3
 PP5ndHISlbFqFJmRMYE3dnCHaA5PdBtPddv8z4UMlv8qNHHvqEdBpPTh+a86S9jzftINFOh6x
 yRlj+43JozgRn17/V1BEoHg6fuKT6P9YaMPJC4HWVp0I1EnXD4DA1IpM3TymSzS5OxRfKQj1/
 zLJcZeqPy8YsdCcJwdnQUftjYek6emCfLVl1mEMSoNTB3Su1IiaZSpiaZVfNsGk0Vkt2jpekK
 8NI64X9xgC4mrBxFVIB93BKJs7dVVW8wPyOLbqWPsjq02XiSC7tKhcC0s8OCi/nP69dLG0fnd
 bBi+t3C+/s7onxiv53QlRqS4VVp0ExN4SR/hBkfP17jCVx4wKiNFqGdrRm8ebmUJChCoicLWy
 pF6OqzQ22atteJhUdyfrU2o0YvZfaO+LmsvyNT5IAuv20EGUz0JIp6lIl24SjsMV8/GiYfpos
 GCw7kXgBm5Rj1GoyTVirvN1jJblb/DYWYJwG7/EMFh1VGs7c1OzQx4sqDRK/Tv5tbn5rIsTSw
 6TCRrPxFVUlp6vDh+OU/iNOOmm2c9FQ/fo9mxiBKWvtmvDCo7DB7x31qgjuy0tDNfyU7wBv/f
 S3li6D8ClJ4GI1O/BdHh3fuZJkgJ7E7A2/jBYlUjAPf8qj39O4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 27 Nov 2017, Jeff King wrote:

> [...] IMHO it argues for GfW trying to land patches upstream first, and
> then having them trickle in as you merge upstream releases.

You know that I tried that, and you know why I do not do that anymore: it
simply takes too long, and the review on the list focuses on things I
cannot focus on as much, I need to make sure that the patches *work*
first, whereas the patch review on the Git mailing list tends to ensure
that they have the proper form first.

I upstream patches when I have time.

Ciao,
Dscho
