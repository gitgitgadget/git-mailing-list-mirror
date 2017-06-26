Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A07A20401
	for <e@80x24.org>; Mon, 26 Jun 2017 09:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdFZJRr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:17:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:4688 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdFZJRp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:17:45 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id PQ9OdsVXscpskPQ9PdIQuG; Mon, 26 Jun 2017 10:17:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498468663; bh=uooIfFDEoMtZ6rwDCOUM89kocZiqpajuO/OoV3YCu9M=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OybGonUKrLwYgXkTmu5jXiE2v0gyn/wtLKLEQxDECOSzSJqDHMlVUalDDK0NFuXoV
         CXVRNJuDg2+SILPbDmyCB74lXOefX1yKHMRS2qVCsT2T1le7vIC7GK1c1+qxjuuD8m
         /5ROUCNgKmG+CxcXV+TLgFIGpKaZ40O7Ux/NI6Wk=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=8BrscKeRk7yehTjArlIA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170619175605.27864-1-phillip.wood@talktalk.net>
 <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com>
 <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
 <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net>
 <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com>
 <xmqqr2yaedsv.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <955e36fb-a6e9-51d4-84b7-b33859c3fe36@talktalk.net>
Date:   Mon, 26 Jun 2017 10:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2yaedsv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMWDbQuNS/mGq5O/QVD071dTJnA3Nvj4Dwt3rdcloBXwbYTsWCTmtrI6SpieMbPIFiEWmUy/CJ5dMRY9ozDO1oCacIK/M+aAmwSDf7ACxdws14no0Mkn
 u5sBANvrEZgUuB5fq1apcEwRQSF4DhQbTbs5XKqz6PqWIIBwo1BJA16eQldovtblJivI2jE5L+JyvZsCDfyjg0518vUaZhbJWEmiOtIB/YIsoqj6nFYWoo3U
 EopdEGsTkqXtrxxit6Xz4NBTKL2tpTcx7NrHaIAGTcM3k6ceq++gIC183Xnptt9qDE3ep+GY1O6y9AooLT9Ptg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/17 19:53, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> 3404 needs a similar fix-up for the series to be able to stand on
>> its own.  Alternatively, at least we need to understand what in 'pu'
>> makes the result of the merge pass---the symptom indicates that this
>> topic cannot be merged to a released version without that unknown
>> other topic in 'pu' merged if we want to keep POISON build passing
>> the tests.
> 
> Ah, no worries.  I think I figured it out.  
> 
> The topic "rebase -i regression fix", which this "regression fix
> tests" builds on, is queued on an older codebase than 0d75bfe6
> ("tests: fix tests broken under GETTEXT_POISON=YesPlease",
> 2017-05-05); it is natural these old test breakages can be seen when
> the topic is tested alone.

Oh, that explains it, I was pretty sure the reflog messages were not
translated so couldn't understand why it would fail under
GETTEXT_POISON=YesPlease

> So we can safely merge this topic down.

That's great, thanks for taking the time to track down the reason for
the test failure

Best Wishes

Phillip


