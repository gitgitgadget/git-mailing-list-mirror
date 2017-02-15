Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A04F2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 16:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbdBOQN4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 11:13:56 -0500
Received: from mout.web.de ([217.72.192.78]:56202 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbdBOQNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 11:13:55 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGicf-1cZrKs1D05-00DYA3; Wed, 15
 Feb 2017 17:13:47 +0100
Subject: Re: What's cooking in git.git (Feb 2017, #04; Tue, 14)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq60kc750b.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <df42ec26-d1b1-e31b-b16d-554441a335f0@web.de>
Date:   Wed, 15 Feb 2017 17:13:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq60kc750b.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:C2owoOKrcyWLrfz/RRnaUb8XHcoXZPMC/2TjAlh9UhwH9783T0c
 fOxzECQGuYKXfmFIVBzKAIUU4RySAwtOUSNLse188qclcFdo7/M8rPTvG2+CvXdgcoFJsiR
 NbGdmH97gvdabkBbXAsx7lRkaJ/cy+mCy9KXCX65g+qZk//Sb39JRzguokqcVdWHBfYy86u
 oWX69fHoGZLbSR1zYiDww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O76mDUWBnTY=:vbfW39OOzWuigC5TVrt4+l
 EYzWvanLN7mDoQyQ30M9FOQpEgOB+u9lb4Cm7f0zeJDJzwbuKT6WM8obLbEb8QOJxLJfNFDOC
 Qmplk9O5/xixrgVyNKc6gsfpu5Yq/1QyfwGJJChjfw2bpZXeCLiHNKs+sc/7/OUgxVWS1XVJi
 cHV611uW1NdMgO/l3k8hnbFRA789IaL0E8vRVQVEEyVkh9EW5Ms8Tr1Dnqxajrq4xml2MaBw9
 tnnCjZaABJ88JVlcoHuAd4yX0rwfGmu7N0HkxFv2Xl/MuOBUJ+VNeZVRLAjvfQyWeSPyHN9Ru
 u3canceoIEgnt1GvZ/U8T8hEtFTbLmgpaZVqKbF9LQwxDnNqzfSz028g1AIA0vbygSJBUD0un
 x78pcR9uqVp+Hhsmk2+KhJmzbAqZXtARLqDOGGA5NlYSPRVcrayt67KkQQRiD3YWFgkOliKRj
 67gj3oZcXP1MNg3/Ydpj3lrypI9W3xpCZ14ygsExqgKoFzMtkXvWu/p/RPXjk73xnOh9CrjQ5
 2RavwTZlLHc+yKKmqZjNofuq3pceuKQvrwhNUKTdPUHGe8MD98D0lwja5N5IW8lmbprkxcxg3
 58xa2XPfrrlyRNLeRiIZLHQegd0XgHS/kvG6hRc5TFNe6mosZWkponSk1f094Z6sSpBFSwF0T
 K+4UddCLgs1wxVNSMDmqYDc77M5dErRN8pJ1k3llUezfi1Hy8R7tm44Zuar5gM1Bg2LtGKU3N
 uc/MCJn076m1QbObHdZcptKIYbRlQxggVKF/s66cGGR68/4tBFOmOosV9iMyRant++y2ZmBqS
 yszqCaP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.02.2017 um 23:59 schrieb Junio C Hamano:
> * rs/ls-files-partial-optim (2017-02-13) 2 commits
>  - ls-files: move only kept cache entries in prune_cache()
>  - ls-files: pass prefix length explicitly to prune_cache()
>
>  "ls-files" run with pathspec has been micro-optimized to avoid one
>  extra call to memmove().

Nit: The number of memmove(3) calls stays the same, but the number of 
bytes that are moved is reduced.

René
