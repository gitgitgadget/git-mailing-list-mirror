Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2399E2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdHGVHR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:07:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:51422 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbdHGVHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:07:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LedVG-1dI9vE2Am6-00qQxQ; Mon, 07
 Aug 2017 23:07:10 +0200
Date:   Mon, 7 Aug 2017 23:07:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
In-Reply-To: <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708072300310.4271@virtualbox>
References: <20170805064905.5948-1-mforney@mforney.org> <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fpXKMPZ1TH3C9bMiJT88V+rDDz+T1eKh43UkxV1P187eFUS62Bo
 5buPJOj61Y20WUm/W86UTyl63fQ1xo9bBkgHN8ClXc9DRgPXzyHt2pknJEaaFNSDP26hysX
 5JjsOBgHrf5lm46/z+hci6UoR4Sxt6CFu/xx7iZIDwCc3hrTl78PGD++EJn/KQVD0iJkWc0
 ClboyNK8NKRs4m+80WNUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DzdNl30pU7E=:wMp/tiLBs57jk3JFyih0VJ
 zalz3HkAkl/BXLwFFqyvfBPyExcBIHx7JjCQg1sn4bRRDZZsAAJrRrDDcwYrQhdc6WZcWQdNY
 VPTEKeCJ/Sdnmg5n166WipDUc8oV9rnHty+Utjk2snJOg3FzRKzAdGP0gj9LPogfVI970RGBL
 CdiRXwXktnL2Hl8IqI7jgt1tDe3Q1hLVfYBGpR3qkOUVylHJV8/Yd2IXCJ6YNbNh1Atulbpqd
 3R4UEDkaoSVuIbtlnHqVcdQtT8RvRyzsRhYxUyqSEwBrtwDdZ2MdpnJaeV9TD0z1eXpyaf+fk
 K+0gudHX5NVoJsupk3a8t96U2TppYgZJllXM1HaMhchQGkJeHwjazP6hOqoy8KVuhUwrQPhxX
 RRepQtmFeex26ZdVVj+0U2xOPSnskW3bW+fPZjZaajfbXq/ZbmniNafGhbQYnSaZ+cf5Mcvgg
 CTHqSUqQ6i2w+h/0zkkRsYOc5BE75Y2B97WeTvmtSQRNb00LfhjyT5TrPniWWdEjqJgSZSZF5
 fV9RJB9LRpEEnfpylp5i72tXDLu2+2qQh6n9yjcCg/1VK7OKhsROgVrzHt2YBIcgeFPMfXpDe
 R9GgDUpI9Ylq7Sm1+whjm7a/HScnLzCYCucvZxRa9wvEj06n12J6WmS/2GiljFywg6PpQTiyT
 eYWkEDXRF48Ws3LT1BLt1zbnfKIYmK0cTn4sX9udanNzfWEt0Fqypo514m1aRFTZjOcnDS4lY
 A7GcCXY1MRcIwo43FQukAqxbbPlqmlgVMHg8mDGyatBERD7wB8wiboOBSlkvCEff9YVjITu64
 n2Q5X7NRfDqZ2YDcMCcbZyPA+gbAsgCFhQAu1xn+qsSMM+ePjs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I feel a bit talked to my hand, as the only reply I was graced was a "I
think I already did". So this will be my last reply on this matter for a
while.

On Mon, 7 Aug 2017, Junio C Hamano wrote:

> IIUC, you will need "$GIT_EXEC_PATH/git-checkout" on the filesystem if
> you want your "git co" alias to work, as we spawn built-in as a dashed
> external.

And of course this is just the status quo, not an argument why it should
be so for eternity. Because that would be circular reasoning and prevent
us from improving things.

It is still arguably wrong to call the dashed form for builtins when we
already have enough information at our hands to tell that it is a builtin:

	https://github.com/git-for-windows/git/commit/bad2c6978ec

Granted, this duplicates code a little, as it was developed under time
pressure (and it is necessary to allow the test suite to be run on Git
built in Visual Studio using an installed Git for Windows for the Unix
utilities). As above, though, the current state of this patch does not
prevent any improvement in the future.

Ciao,
Dscho
