Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4D01F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759578AbcHaLJC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 07:09:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:65446 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758872AbcHaLJA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 07:09:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M3d9B-1aoSpP0VcH-00rImf; Wed, 31 Aug 2016 13:08:34
 +0200
Date:   Wed, 31 Aug 2016 13:08:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 20/20] builtin/reset: convert to use struct object_id
In-Reply-To: <20160828232757.373278-21-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1608311306540.129229@virtualbox>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net> <20160828232757.373278-21-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Uz1AWp3DGWqDfpzXqj9XCl9g4sZSJWtXR5tTsO4924/rQMxwjML
 dxCYeuqYGjiMXb3K2TaqFCG0qk4W8cx0QwXprBF5ZYHupmDSmPjmo8WwFYYrgYg+C8Kx0Qf
 nSljKXJCdrpQV6BWwk9fM/8JQNj15b/e/opAXLvD5kAjb+8GG+0/xfBDl9+Htx6QLR0/5JM
 M1+OsKiP/Vd+cc9CTs0ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jZ8fB67Nc00=:Hh99fC6wBL1eXfxW9Vquvl
 FAwLnANs10gVLKqrcbbGfMM8uqsZ5ap0dplnpe1q8pl2OVG8ZvS13RVjR3dxPWnNL/vSO6Cnf
 1yW6Kpn686EdD0pLEosiD4cZEPg6aztbQ++cwy7zueoZPoEyb/qrc7syjE9hY2HUHuIyD5AtH
 peZeqVYXoeRMJfhJ/dVRaanM7q0TonQX9iHgvJlHAVNo/BrKs96deSn+yQYeaLbdhM6Y/4biy
 MS9Rn0M6z9t6FcSU6V6rjBlb5hQFQ3tv7M/1wWT2lNplVX9FXvLaHexsFk8UYZziaiMYW/Glf
 3O36erIYyYAIgsa+6iefHI2lPf+cEh63DegUtxdCGJiOn7KAjrjoTqGCIHIV7TXrcX3hMXQew
 fknluMOVdbfvFwHc+ejHDUHJqAQZC2zjXfC4cJz5N0e6BmxCuR6Ka+5ZJ7iQfiy+2HeFz7brW
 dDx60YO58dZYbh3X2xBi+59lp2+98STya7QQbcx0F7EiYHmsNHqDnkuTMhBfpQ7bqSOZO+tcI
 HMjVWsje1f6yeB+zhH6Gvp2A/j/F3BZLJ/8wq37KN2puA5VxeGfeC3ZIH0COhYL3lgNAoFy14
 NRoHxYouU4uz78sLMPL1I8dpyur+7/jTPOu8xw2Y7FgTx/tEQSqy5AXqWdudpyLDnlnI0F/sb
 WlGJx+P9KEe5UGpVEcIfOA+lp10DqgA1bNpeAcekLksoPYHzoVvx4+4bkxT3emGKtEYWMrH3l
 08O6+GcDDPUTk30bLvM72PwsAAwTCDAg3W+48iPhxKJjN9g/OPMwrPhVlP+5ddZKXpeGmHR+p
 WCQZknw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 28 Aug 2016, brian m. carlson wrote:

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

I now looked through the rest of this patch series, and they all look good
(incidentally, I spotted the same update_ref() thing before reading Paul's
reply, so I guess my review was more thorough than usual, this time).

The conversion to OIDs seems to be very important to me, so I am very
happy that you keep the ball rolling!

Ciao,
Dscho
