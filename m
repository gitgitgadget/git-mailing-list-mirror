Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACDB20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbdDQRgB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 13:36:01 -0400
Received: from [195.159.176.226] ([195.159.176.226]:46570 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753914AbdDQRgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 13:36:00 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d0AZ6-0002gp-I7
        for git@vger.kernel.org; Mon, 17 Apr 2017 19:35:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Feature request: --format=json
Date:   Mon, 17 Apr 2017 19:35:51 +0200
Message-ID: <c56a5582-81a1-3714-4587-f6a12b4365bd@gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com>
 <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-17 14:44, Fred .Flintstone wrote:

> However, if I want something more suitable for machine parsing, is
> there any way to get that output?

Instead of machine parsing, why not directly get what you want via 
libgit2 (or one of its language bindings), or jgit?

[1] https://github.com/libgit2/libgit2
[2] https://github.com/eclipse/jgit

-- 
Sebastian Schuberth

