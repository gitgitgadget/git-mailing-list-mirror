Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8881F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 13:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbdAZNp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 08:45:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:58312 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbdAZNpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 08:45:38 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWTO-1ch9x73DGg-00ATts; Thu, 26
 Jan 2017 14:45:31 +0100
Date:   Thu, 26 Jan 2017 14:45:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
In-Reply-To: <xmqq37g6akfx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701261441290.3469@virtualbox>
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de> <xmqq37g6akfx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8+yN3NroOxRpnycw7Hsb0rNCwTwcxWLfzLnf69UHv5XCvdS/8FN
 002JZ1duk1sw1fKE/0P5Mz+gt/c3HwGusenLFPvZmWcwyvpPRW6j5JPPb1X01ZN/QFoBj08
 U/6LbZuEwx5pCnjlMFdXoZxCPBPE1ZBVPV0B6n7X6v/HDxYWr14VfqVmXUWhXuAwDjCYYAx
 b/hAMpJE9Y42AuztqujFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fpfirZ1HAOM=:UCutVPjfgbAS4wFrDAztEY
 1y0qUznSglg8Md1NB0jCD+j17Vx29pF9o4jqwEEt0OAYQsIfLf/Us2j1Ml23f3/lM31hdcLdZ
 GCitDsjMvIlSQ08Tjwzz1RfKUcW9w+TbDm9HkLTczxiHlhRgX5DGucDoVWurqSSvUhDw1BN9A
 geRuImlExxlOS5jfWwfSFKtHpsyfrR67Qg+uL2U6r4pi2pvLlyuzublzA7JfjImh6zOid+7VX
 t2shLaee1CuocQINgBZZrmBNhyIUcO+BNRCzQ3novvhnskjrCsRUx7vbqDok+wFdO7f4/LDnO
 9bJkSitimIUJS6IpGubgifKUrU8BLb3uhprqN1Qnom1xWn69GYZkm9LSxgsXLct2dv1+wm6r6
 5ipsjdCCw9KexexWwcfRand00tF5EIu0YXIF1HIXGaEvhwixZBnMbKWvRPrSPjN8wJL0Xja6F
 KDH5GDK/6AKw2i5ecR4rNHNmUXc/ka7BG19wjwq+1B0F2TYs/L1LDQuYLFtruOOFMjxSDbdsn
 JDZ/eqDCLsB+Yz9rdNWvzNd7oOtac8eRkegrJJoBZh6mVzM3oWvAicdx+fAe6R8042Anp3gfm
 U+MT9v/WieeewbQWFCIUmuLeU9Xau0FZ50yemW1TES7Ibq9j7nPzfIxAhxa/4w5d2LDdXCEB4
 X9vd/8qQdJ9pvFLlud4tDSSTImGpwsZVg4zLSN+3saj+zI6fVCqb78E/eY+YUMOwweP3o2VP6
 fMgtzPP9vnhVg5b8oW58lo80gKfMvTSEApFNFmCBwuh9mPoJ8HnY/tBXBz6Faf09eyLZJkhwc
 0+Zs3NH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 25 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This change is necessary to allow the files in .git/hooks/ to optionally
> > have the file extension `.exe` on Windows, as the file names are
> > hardcoded otherwise.
> 
> Hmph.  There is no longer ".com"?

No, no longer .com. You have to jump through hoops in this century to
build .com files.

> I briefly wondered if hooks/post-receive.{py,rb,...} would be good
> things to support, but I do not think we want to go there, primarily
> because we do not want to deal with "what happens when there are many?"

The answer is correct, the reasoning not. The reason why .exe is special:
it simply won't execute unless it has the .exe file extension. That is not
true for .py, .rb, etc

Ciao,
Johannes
