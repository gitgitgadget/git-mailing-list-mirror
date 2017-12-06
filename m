Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E7220C11
	for <e@80x24.org>; Wed,  6 Dec 2017 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdLFQD3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 11:03:29 -0500
Received: from mout.web.de ([212.227.17.12]:57214 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbdLFQD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 11:03:29 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Md4pC-1eeplw36oc-00IE71; Wed, 06
 Dec 2017 17:03:22 +0100
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
 <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <0c2aa5cd-55d3-28ea-8577-b8b2839fd4c2@web.de>
Date:   Wed, 6 Dec 2017 17:03:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:exXBGU/EvhH5bE2SB98sqjeedUoXB/3CF7rgmSiXQaIFAY82TLt
 nmurEwGQEnoNCeaSXAvukPcr7MaLoc6PpEdGWfEeiUSkWNVFNnavbwih0HLI49HBfXmc2bx
 7gBY1+sbplLGhLI4OhpK8TlXrASuw93X6XxMCfSV8HdYjtWKmx7g0rwApl9V2aMNO/sUJTx
 Ir+vAzYpFT3NQP9tA3YXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5HfEZ3weHpI=:uEToBSaYpRrWO37cGKv48l
 v5ojEBpYogpRG05J06LJdEyKkHZ75m9o4dXW3Y0ab8/+6zmeY8V/7X+PNN8nG941yJwWaTgdT
 LQuoyet8jb8f3BXwyrwiHF/W7Sc2lJbTbz5wPqu/SAKk3PnCyH+TZtwMH6GzJsxXSwUXuTTJm
 zy4srdv8dQtpc0VPYmrP8cG46ceNtcxv2T6vWsu8RMx8nIbxAQbuiYfzh84Hhn6vdxt/h/y0U
 t695qyoGR4wtYkRrAsEXI1t91/+7y5nTQAaoJibzbhI9YuKyX35dLK9BLut7GhgYw2o58hWCy
 osDfzV3vUYwI0jcEOFOGvFpNa4I1MJjryYl7NpvcEHY9Yfhy6iXpTPmRV4V/LVni1bHFeD5+M
 NNCajW5kSMZHgkiV5kvYk3NFVuFr7l228/pUdpjg7k0AKgrLA4CASb/1JE5Gd1kE4jMKDU7jL
 HlQCGb0lnwGFiRFPvRVjf79cEtSEAY9SG45C0BY0RD5Cxa7r7gf2OlIE4AQj0lwy+08UwlQG0
 Ul9snGKMFNJoxIMp0zvbLqoCETqPQxV9e+ptIi/7YeUs2bIwSlcmut2lWC1NxUf2FAMZFqmaj
 kl6xBYHvmq2YvRUCGTNkJ9VVcIMyVgSpFLnZ+Sg83Gk0Lr1WI7WznMxW14aFxhqyPXLU0RWET
 7sgekMh86z/El6X9lMLW9nMBk42HMgTI7SrVB1fjOzuhVbwiJorsl7ANb4oLJ1xfA+nzZkCVE
 qrtwmKU/SqEyoaHi0BH3T9zX4iORuwc5gb/O0pK1a+9nTlII6w4ljJZ4ysMuCftHMFVZI66L0
 zDiZjISth7S7Ztoj5xRMN2LFHgE9l4vMA2X0LLK4yzLaA85fE4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-12-06 16:14, Lars Schneider wrote:
> 
>> On 04 Dec 2017, at 22:46, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>
>> * tb/check-crlf-for-safe-crlf (2017-11-27) 1 commit
>> - convert: tighten the safe autocrlf handling
>>
>> The "safe crlf" check incorrectly triggered for contents that does
>> not use CRLF as line endings, which has been corrected.
>>
>> Will merge to 'next'.
>>
> 
> Looks like t0027-auto-crlf.sh is failing on Windows:
> https://travis-ci.org/git/git/jobs/312135514
> 
> Could that patch be related?
> 
> - Lars
> 
Chances are high, I will have a look.
Thanks for noticing.


