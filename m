Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C40D20899
	for <e@80x24.org>; Wed, 23 Aug 2017 15:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbdHWPTk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 11:19:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:53507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754090AbdHWPTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 11:19:39 -0400
Received: from [192.168.178.43] ([188.108.200.6]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MILxX-1dhVAc2HBn-0049fY; Wed, 23
 Aug 2017 17:19:37 +0200
Subject: Re: [BUG] rebase -i with only empty commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git <git@vger.kernel.org>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
 <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
 <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <ece1018b-98b1-e9b7-546a-d7c68dacfbb7@gmx.net>
Date:   Wed, 23 Aug 2017 17:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qFpUEYM9w7Nn2FHazYmlTy3rkzv8m+9rxMCEYd3qHs8cmQrFGgQ
 jcBPZzx91EkxP3i+xghU5fOXJRO7WIFJUVi/CpDGWyc8IBLUOj9b+76aZkiQmZZrGKaN5lW
 Zh+7JFKlhOCnJ5FYhGrMRONpD9rQOTMKA/TLDlqdT+nM1Fmi8iwNwjg4aDmBOnRHw2zEEyR
 oktsNdGTQnAtIj8GmkZ5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MQqU27BPsLI=:PGytjz7sM5pnmaIE+PDj7l
 EpwSSQecEtkxyLk4mw2F2Tlk1feSZsqT1WjeYYhZ4ISqJ1bFwINIIA6drWGI5IxVywGTOLV1y
 wDdYRvgiEzIBHhIp4xHooHF5nRsglO7Ua4ajKwhdkf2uB9eM6dSFjSUKAFcqAySiXpcSHXyqD
 6J4/qvEIwPdfH/ujKG5qIrcDTW4skACbTdIwdL64zfAb61fhe+LTzvPzpyKA1E1AcySoN6Uzt
 HPYiNGQ/VdXK5HUCl+6oO5yacX4TGb7f3pULJIRKwMg7ntz7G0XTsBairSHfwn2CZxmiSoZd2
 bG2AvIFyiBGpAOl10gcB/EoesgWk0fTp6OK4NpNt2+PdVmT+q9uZfbMjl4Qk+Q4Hu62a1ifCq
 b+EWa4Z4wX1a38/MZayxIt7bYHD3d014+VlMy85PaLpf0zzcABLlsKnpKSjvKS2rbowe1cT8Y
 zsdO4eST2NJzoGMC+uNq9bDA1I3tZu6Ak1Q6zxTtYfReRiRmVAI1mOnMjbX7PtmKcIqilEKCQ
 qgrEblOfe9PYcrc+03J41StAvjbczpAqBxIqbdYezYyKUeKftwgmzqAw4xVZBKsYNKheBCLbF
 4NpysNNyT4l7Wb8UY4lTJ0pAAqjEoDlnWTwusXqW9Twdcv6t9Dr+KPQH6q30JjRBIoOnSrjRP
 lhI0+QK2kqGTpsz8BsIhAqQkWPZqkC2Xay+bpHApDv6TN+zmWGxVt8ugvZhPjwRuD/VNm1kQh
 JKnaYAnn7tg4PAN7N/CqMD1YnXu4ZWG4oggb+f5QlWdkKjIiPmkZjAHqccnJJhdWi0jPVTFp2
 E0N0SwnUdDG7Lgbri/Fu16y64dDn2wSgcusuGrwSaPlnRLRt3Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 08/23/2017 04:40 PM, Johannes Schindelin wrote:
> These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
> you want to do that, too?

That's a very valuable hint, thank you very much!

Best
Stephan
