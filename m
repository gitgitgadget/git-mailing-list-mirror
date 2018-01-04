Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D781F406
	for <e@80x24.org>; Thu,  4 Jan 2018 00:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeADAnf (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 19:43:35 -0500
Received: from mout.web.de ([212.227.15.4]:54408 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbeADAnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 19:43:35 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDRB-1eJKz3135N-00ML0u; Thu, 04
 Jan 2018 01:43:28 +0100
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
Cc:     git@vger.kernel.org, mpsuzuki@hiroshima-u.ac.jp
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
 <81b882a5-0c35-f3c4-78e2-d3e36290fec1@web.de>
 <5a4ad314.C6wihAr5rEC8jRkB%perryh@pluto.rain.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <24162f60-d6bf-8ab4-ee69-9834292fadae@web.de>
Date:   Thu, 4 Jan 2018 01:43:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5a4ad314.C6wihAr5rEC8jRkB%perryh@pluto.rain.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:sOGA0w9hKtbIrOncBlZFHlkDTHBXhVcd+/w28CBBD/TZe0WryH9
 YQoI4HifuRuVc5bh17cunrJOEldq6r7wwk01dLHnklasaLkuqf49AdIp2scUHSTCOg6ch81
 NkxO11ZBZAO+CJOcCfJ/9N0ehKPcTIS3Jh7nw8TDK1mFpv4tlVBrAA7W+Xg7Tv4As7IoITS
 VCo75YBnFB2naRj2bXWxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j9ohyxJE9wg=:86oKA+1vrRmSA4ZAkB1rCH
 6XcuvKvnNGiYdesJJvxJLlTwSOthaG1yU0ry4usL3ImT7IGHmAWLKn3vR8IzLN86UGROTkvi6
 9R3ZbLO6OG3Qy6Fjz1+n8QcksOniPGqV0nsvpTY9dqDcMr/N8IGdxG1qUrpNpGdBJOWi+/Quj
 CoK8JtomlM9WjjwNcOk5J01sNIWQSeDXN9aVUoH5QxtVCvDmtBVSaHDqmMUQbWckNFz7oGbYA
 OHzL4DiYVYYCVZw+runsd/zOzdZkK8ZHd7Wh33e9Y8QtoUAq1rWWcv9JISQRiXhXgkjc0G8Jt
 A7bWT1s7s+l9Hp0xY3PMCkOmHa8vMfRTNJVB39DxKzZBhMwpeI53ChfwJ3biUUHQ2/r3yOBfE
 LOi1WTxE0K+hj266LFkGb63ZX5X2C2ttxznY82HWTktMRInF3pxIo+BnLiHmYlihuDFaYwo1n
 AAGixsvLpo+nV6z86nz3iT44GTlBZ3ieHgG9y/JFAecIINghb2EjmxPkddgAg+BPtohu/lm9E
 pmc5KtieJV5U2WUsmhLcMAMXgeWIsxLkR8WVfl6XiQe/P5CCxwrx/1IMIOpIeWIqKBMDUIvCv
 juzK88h/YK+FbfakHOyvW9A6+qbJ9fLM1lpDLaVZOcUdw/7oeLM/pqTez/eM8FccGBXbwQT9R
 94A7b4LKOvWlwfdxD+1plIgpZ3VhtdtarEtrEiqtkHXeCvdXPcFPU+47Nj7PhZD2m7uC8hofL
 PqqOGOFuCQwfWRVdYM3xr75+bwqXGfkTbdDukujpD6YLDOzkmxf/uEepXdcPRE5hADmh0Bx4K
 ls5j2nUdVvnN9xg/OOCNAa7ac2MljtQmh+z2992aZ4/6PYCn+Q=
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[replying only to the list because emails to perryh@pluto.rain.com
 are rejected by my mail server with the following error message:
 "Requested action not taken: mailbox unavailable
  invalid DNS MX or A/AAAA resource record."]

Am 02.01.2018 um 01:32 schrieb Perry Hutchison:
> Ren?? Scharfe <l.s.r@web.de> wrote:
>> Am 29.12.2017 um 15:05 schrieb suzuki toshiya:
>>> The ownership of files created by git-archive is always
>>> root:root. Add --owner and --group options which work
>>> like the GNU tar equivalent to allow overriding these
>>> defaults.
>> ... the receiver would need to be root to set both IDs, or be a
>> group member to set the group ID; I guess the latter is more common.
> 
> If the received files are owned by root:root as stated, I guess the
> receiver must be running as root, no?

That depends on what you mean with "must".  Users who want the files
they extract to be owned by root need root permissions on Unix and
Linux.  If they are OK with owning the files themselves then regular
user accounts suffice.  I assume the latter is much more common.

René
