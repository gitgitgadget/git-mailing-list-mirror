Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2100F1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 17:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFBRsm (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 13:48:42 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:23903 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFBRsm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 13:48:42 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id XUb1hXa2rnuQZXUb1hL5rW; Sun, 02 Jun 2019 18:48:40 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8 a=k_DvvmLAlhJi9s2Jc-4A:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet>
 <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <45a46a7a-8fdb-dac3-37bf-79569cd4d600@iee.org>
Date:   Sun, 2 Jun 2019 18:48:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLlk1ZW2p7umuZq/3kk+2CP5OVrtGC3TgOAUn6ykVBNkOcToIpx/PW3aiGcPCDWlrKHzCRMwloS4VVGAL5mJTQqoQhg42AiOGJV6+x+JDDJdsRnZAf2Q
 dcizJWKJx4fcTImKqzPButEXX0xtY/aINq78DYFqS24lF1w1vEWCeO/9X0HwBgaGNkjpOLYVirPus0bqQmlndZHmX+Txqyitz3xfRomLolkdKebOsU2M5rsM
 NVYUDapE3eYmLhGOPP+V7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2019 18:34, Junio C Hamano wrote:
>>> * po/git-help-on-git-itself (2019-05-16) 2 commits
>>>   - Doc: git.txt: remove backticks from link and add git-scm.com/docs
>>>   - git.c: show usage for accessing the git(1) help page
>>>
>>>   "git help git" was hard to discover (well, at least for some
>>>   people).
>>>
>>>   Will merge to 'next'.
>> I guess it would not hurt anybody (and get a bit more exposure) if it was
>> merged before v2.22.0, but it does not fix a problem introduced in this
>> cycle, so...
> Yeah, I think you already know this but my stance towards these
> "would never hurt to merge even in -rc period" topics is to merge
> them soon after the final.
>
I'm perfectly happy with this. As a small patch I thought it worth 
'getting started promptly', even if it was in the early rc period, and 
I'm happy to wait and let the wheels turn steadily.
--
Philip
