Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1CCC4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8280023A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIUWPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:15:18 -0400
Received: from mail601b.mxthunder.net ([209.41.68.211]:44767 "EHLO
        mail601b.mxthunder.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:15:18 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 18:15:18 EDT
Subject: Re: [Wireshark-dev] Joint project with Git for outreachy
To:     Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>,
        Graham Bloice <graham.bloice@trihedral.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20200918222103.GA3352870@google.com>
 <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
 <20200919195545.GH67496@camp.crustytoothpaste.net>
 <xmqqtuvtiec8.fsf@gitster.c.googlers.com>
 <20200920161652.GF331156@google.com>
 <CACyXjPxAXgpEmK0buarb3ToHwnonLM6TG9-J-=GysXfGkmsSrg@mail.gmail.com>
 <CALcKHKoE2BCZEuW7rmsCdY4LSyvnCTBDLmgifND7TH+v5ma-6w@mail.gmail.com>
From:   Gerald Combs <gerald@wireshark.org>
Autocrypt: addr=gerald@wireshark.org; prefer-encrypt=mutual; keydata=
 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
Organization: Wireshark Foundation
Message-ID: <21f2fdb9-33e0-064c-985e-6dc8692aca61@wireshark.org>
Date:   Mon, 21 Sep 2020 15:07:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALcKHKoE2BCZEuW7rmsCdY4LSyvnCTBDLmgifND7TH+v5ma-6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-FILTER-ID: 4B9bQ1
X-MXT-FILTER-ID: a4B9bQ1_500b_101b
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/20 9:06 AM, Graham Bloice wrote:
> 
> There's also the Wireshark Developers Guide (https://www.wireshark.org/docs/wsdg_html_chunked/) and for those that are sleep deprived there are a selection of talks on dissectors from previous SharkFest conferences, e.g. Writing a Wireshark dissector: https://www.youtube.com/watch?v=Fp_7g5as1VY
> 
> and the much more entertaining one with a different approach from Richard here: https://www.youtube.com/watch?v=XFFkC4PdCbI

Speaking of SharkFest, the next one is in a few weeks: https://sharkfestvirtual.wireshark.org/. Along with the sessions listed in the Agenda we'll have a Developer Den open throughout the conference.
