Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361261FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 13:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbdFPNvE (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 09:51:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:59645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752762AbdFPNvD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 09:51:03 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZKF-1dC8U20Zr1-00RG2b; Fri, 16
 Jun 2017 15:50:45 +0200
Date:   Fri, 16 Jun 2017 15:50:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v5 00/10] The final building block for a faster rebase
 -i
In-Reply-To: <xmqqo9toyhd9.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706161550110.4200@virtualbox>
References: <cover.1497444257.git.johannes.schindelin@gmx.de> <xmqqo9toyhd9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sQ6MwJ2ftg/okRuPCOBkQhJyS45QpoPCnY9XDNFznK+z5An208w
 AtT8SELQQ1nFf07M0s3u8anYapHziQd7ZUzwn2yksdE+lv3Ab4dXIw+yQTKv8AJb/ixVdn5
 fxXzF1BDDSHv6OiA27Licws4sE61itWi5g5EkgEzi4xaIco05whIY53wFV1imPCT/zidf3z
 HHVLwni9HtnUI5APASXTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BuNw6Q9l16o=:lDQqqY++7i53WlJAFE7xtZ
 7a8UKQSeLsiBc8bQi6BVeaePdRnrVhgdeGT6F7hTjv/8kpuBFvMILKEObSTOmOLEKK7lc7G+E
 Q6xHmgL+FlcahtZGkTRfopapKMiy5wHDwtFq2hXoqSsFZZe6yLJTaBcR+9EoigIyF3UzdcPIk
 gAm7buVOKpLE4yJ8cTC9SFZ5bg0TNrmeKQM0htMVYcBneW9LSZAXARsRRbxQdv2i9ezs+jVpq
 kMvtiB62zxk/6+rzhmFTXuMMJA3rrV4HmQlRFUXfWk3yaywDEQ0XMBXTAC23HJ3oW+Ejvs4YY
 xDsOb9EeBr6JstovG3pdUidQ7UIJtj6iUGPzMC3GvoG2B5dnMtQJTgw3drxTq7meVt1wFwAE8
 SN9A4/dIZ3ysj9pqcvRzeQyrIRpN51KVdUCoztUh53ZfPZ0J0+ygrxWNdOv+TF0nYGDLq1MV3
 9qK0Nyo1eMUYXJE4KnFJ+V68JvA3qwBnjJscRONMFs7BA4MNpxG63xWRA27pD9jd05HJM533g
 ekiCXhlQ9oGLR5SONc0QQT42n7z5MsNQ3+2hjb1TsItDclDFYFVrD18m5sHWI7fwYZXmN0xq1
 ctwWLsQrAAIzaAOZHGdLF2xzDYh0MIaCC7T6qUAa87uj9YjF419azE6zDEZq+0WX62PJjo/2H
 iOHY80zo2gve2Um2OQoOZHZbT9BokqZPltvv99by8Z/u38n7QM4M06Z7oNRx/dit1SLtnppi6
 rNlr7Ebt0Ukllxqbl3xGFD0wt96pqJ+utSWjfRUdd72PutZtCM4dauRbmdSXfmIBomoDPKPc4
 mZ6TwHp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Jun 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Changes since v4:
> >
> > - replaced the "sha1s" part of the names by "ids", to reflect the
> >   current effort to move away from the cryptographically unsafe SHA-1
> >
> > - replaced the confusing term "instruction sheet" in an error message by
> >   the more commonly used "todo list"
> 
> Both are good changes.  Once this follows the API properly, it would
> be perfect.

Okay, then drop it. What you call "properly", I call bad programming, and
I won't do it.

Ciao,
Dscho
