Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17391F403
	for <e@80x24.org>; Mon,  4 Jun 2018 19:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeFDTPg (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 15:15:36 -0400
Received: from mout.web.de ([212.227.15.14]:51553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeFDTPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 15:15:35 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LeLmv-1g4EvC2mKr-00qDiK; Mon, 04
 Jun 2018 21:15:27 +0200
Subject: Re: Regression (?) in core.safecrlf=false messaging
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CA+dzEBm_doNMjEs_OWwia_mm7u3ztAFpCpaFJP3DRpFhEo93jg@mail.gmail.com>
 <20180604073855.GA20922@tor.lan> <20180604075549.GA21063@tor.lan>
 <CA+dzEBn7cCey-LDa1Y-PUeFQs7JiucS30FFiLfw4sfu6ZX34JQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <81c6709d-8f8d-9387-1649-6bdc80c30ae8@web.de>
Date:   Mon, 4 Jun 2018 21:15:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+dzEBn7cCey-LDa1Y-PUeFQs7JiucS30FFiLfw4sfu6ZX34JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l/cmrr3f6VQfKbENmq3QuLB9bC1IfGbdDgpBENoV6AbZpnGkKGn
 K+b8j4ydYzL4Ry77WQZ0rS9r+0ZktiITs2WZs+KtO1gSd1yA1I0eNIVrREfGiRB/LOoIikP
 PP4iqoE8xdR/KBuaAiOIfX70700KLSf1g7nel9h/gltEEAz8tkLXTKyVstzlwJFkNvnVbRa
 cUCxldiPKieqVrgqJ6WSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gVatzmSjE6E=:x4vNHlz9LL8zkbDhmi9JEM
 mlPR6wO7l9V2U1ejlmG8DRFLh1RFxqg3bawf25WIuMiJ2V/WmRXRGo4+WvlaZw1S039DsBhSl
 +WIQBBuPOaJtasYI5ZgvRqbvgSxZQbhtO1kY08Kv8Eeik/m4A0uQKXFADywQikxEZTW5YW3QA
 ayl34DLgwQ/m+KX7H7Rcn4hT/hKuGzWCIh9tU72KXLB7dXp5oeJaL92WcsUHNj12m5ujM2XI7
 67RCK84fPGGuhrayPHI//Hskk1gJ2fyVD11lA1BasS/73cSG6/UIDGPMWtCXI46OCta2KZrdj
 ONyTGojI1vXe+KZQXP330YNLYO2gm/M5GCG2rgLU+rroX2glUSvqqjvaAdC5sxS1k8eBKNKo2
 2CLNAgp2Jdoz2KW8evwkUXV+B0VU354ZbGZQXMvtHe/dk2C5jN1uGJgmj5Ma4+G3quvQ0nyDE
 FVRUwYAfwJGDimBqaTQ6xdzGyKdkWnLTsmciiHEO/deBgPKsBbWmKW3+CqBJX5VhHLKMPMrAZ
 RGF7HGf2yk1cAZ7L1k6dA9A0O9yQ8NV8REBTPH/1ITn9RknvfF6jqszgWR8/Mj4O1uGh7yKMo
 1MrP9p+LRJoMWYqsjRc4MCYFSFO+8AfgTpGstp4Rgwip/0qHHuyVDkEWbQqs3cB4IOMIrgIRt
 DDotVpU+omBWbjfEXT2Bta+XwmY/RSzhpnD35yqpsCZcSPKeMcpFFC6bwY5QfigP6zgGdUAsL
 hv/HtEr8pWwBNhqqWRVPOxfn5doKYrJUFNwDSH1oWz/6sAEGtMIGFAYjWiPXe+vaskVDpuMpY
 8mg+Plx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.06.18 17:43, Anthony Sottile wrote:
> On Mon, Jun 4, 2018 at 12:55 AM, Torsten Bögershausen <tboegi@web.de> wrote:
>>
>> Does the following patch fix your problem ?
>>
>> diff --git a/config.c b/config.c
>> index 6f8f1d8c11..c625aec96a 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1233,7 +1233,7 @@ static int git_default_core_config(const char *var, const char *value)
>>                 }
>>                 eol_rndtrp_die = git_config_bool(var, value);
>>                 global_conv_flags_eol = eol_rndtrp_die ?
>> -                       CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
>> +                       CONV_EOL_RNDTRP_DIE : 0;
>>                 return 0;
>>         }
>>
> 
> 
> Yes!  After applying that patch:
> 
> ```
> 
> $ PATH=$PWD/prefix/bin:$PATH bash test.sh
> + git --version
> git version 2.18.0.rc1.dirty
> + rm -rf repo
> + git init repo
> Initialized empty Git repository in /tmp/git/repo/.git/
> + cd repo
> + git config core.autocrlf input
> + git config core.safecrlf false
> + echo -en 'foo\r\nbar\r\n'
> + git add f
> 
> ```
> 
> Anthony
> 
Good.
Do you want to send the patch to the list ?
(You don't have too, if you don't want,
but as you already did all the work...)


