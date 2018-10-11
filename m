Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6465B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeJLEPV (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:15:21 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:32794 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeJLEPV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:15:21 -0400
Received: from [192.168.0.105] (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id 0646594EC03;
        Thu, 11 Oct 2018 13:46:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
To:     =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011003440.GD13853@sigill.intra.peff.net> <20181011154319.GA6386@rigel>
 <1409ebd2-d72c-fbd6-bf5c-777342723ca2@umanovskis.se>
 <20181011175136.GA8825@sigill.intra.peff.net> <20181011203518.GA2385@rigel>
From:   Daniels Umanovskis <daniels@umanovskis.se>
Openpgp: preference=signencrypt
Autocrypt: addr=daniels@umanovskis.se; prefer-encrypt=mutual; keydata=
 xsBNBFKoLuABCADTUslhPOYPDA+TmmmJr7l5Ybrp7dUTs9A8O6Vkd3ucNeZQue+3lS3/VJwG
 ZPJprysTdFEeZkJWEleO9rYNe4l4EciaqaRjXRR9r95qEqgf7tc37RU003VNxkuvJnweKypJ
 5G247dy6Z3ORMKw8usX4uO+tsxsZqXprgSJJyU1QPMMT9oc5Qyec9ny5GdhRCIbwhVI9y6Q4
 RPpI4Czh9s1Mau0V0Yf9eOoW2zPlD8R67AUZ+myR6Eg9T71STAdYYEy9+EA/G27kc8J+yB43
 NQZ9sAFbMdundbISUoAALxqzC672u83YoTsHdFEzztz76PkY7KpDKH8Kd4Qzr0NZSHAzABEB
 AAHNKkRhbmllbHMgVW1hbm92c2tpcyA8ZGFuaWVsc0B1bWFub3Zza2lzLnNlPsLAeAQTAQIA
 IgUCUqgu4AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQUfamH/05PVqFzgf/Xf0y
 Kx6kovYltkRZovLL+YNQ8ung4dCleC4MHegkscndLX3zgIu7VgqniLWjEnkFA5g/MaKwzKir
 YR9pvb5WlEXjK/Rh1LY+W7laBuGwJHXoPTHb843OGAuGoxbyRXiylsICx95/W0m9UZea/8xM
 6kmIEh1cD+g0Pd7VkCUm7SnOQSEHSnqvsspsGpFe4GuB+8X8dVOCa/4IRMwDSj5JDwX4gmlH
 DF1k4+gqvEzBgNX+ayA+uME0BN1PJ4u/iqo680F5DQGTOBXZCug+nlxYb7gJQXhFVlvdG5uh
 TypRTzCvC/aPAcULaHoCz9M6hwJgvoO/IK4uvEXY7P+qN7Xxtc7ATQRSqC7gAQgA4+8pYlGe
 1s7CFYl2OaHLLeupVpXd6eDMhi4NDKA/0Qnr/VnuF/VaPQ79KEiNDl1HMV1yoXzuQsdvfeQc
 DsnchnJI/YhlSF6m67jG5PQtkcrGqEB87f0JQ1mcgwpJCQx4EzvMlHbg6O9k0vIsP3O8+v7h
 +a8n78gKVUm/nMqIT939eqxtmccfIbiE/KKbigiOwUpiOrUAk8TR4dZ8U2YtIU5WnWhGIJeK
 fzLLHO2Gb5uk4toQBq4fEUW4I6Ar8blHmo1vHvG+gWWKeZA0n2sxjqGpfnGNZNyd4fkh728F
 reiGd2lWA/vB4m9Oh9auOKIOFdgUlDgSK2TvuALrzUmUbQARAQABwsBfBBgBAgAJBQJSqC7g
 AhsMAAoJEFH2ph/9OT1aC/sH/2JWo3MEK7/gpIfAFgqBsxWAeggbiBnu06NTc7u5G2q2znzN
 MhWlHEr8tOtPwV/6IxoZsHEdyUxBvM90vtmRnYoDL0S/xiwlimUuA+GxPFEN67HjEik3NJQU
 in36Q69hT3HyzG4pyWB2Uk6cx6D+4tMdSCHcO5wxjFPIFHL7/2YLpUfLWHXVdtxT6/2Roo+G
 +Wx2BSEgXqGR2i0HLZUqU0Oz/BHxLTtef+dUAWu0FmByPChoN92+0CLWEm/s5mBaCsMHd76v
 NIofCYEIBFTeTe2hKuBv4D5UtZNCz7MucSzG1tIOWg+vifpLm69WNfXhvpiZ8GDCLeL2Bs09
 msVfFOM=
Message-ID: <3b6f9f63-8512-4fb3-7506-5b149370724f@umanovskis.se>
Date:   Thu, 11 Oct 2018 22:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011203518.GA2385@rigel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/18 10:35 PM, Rafael Ascensão wrote:
> The output of the proposed command is also a bit inconsistent with the
> usual output given by git branch, specifically the space alignment on
> the left, color and * marker.

The proposed command therefore takes a new switch. It's definitely not
perfect, but doesn't give the existing --list new and different behavior.

> At this stage it's closer to what I would expect from
> $git rev-parse --abbrev-ref HEAD;

The proposal is largely to have similar output to that command, yes. I
expect that "show current branch" is something that's available in the
branch command, even completely disregarding questions of whether it's
API stable, etc.
