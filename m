Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480B920989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbcJJS4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:56:43 -0400
Received: from mail.pdinc.us ([67.90.184.27]:51500 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbcJJS4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:56:42 -0400
Received: from black7 (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u9AIuaRG005011;
        Mon, 10 Oct 2016 14:56:36 -0400
Reply-To: "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>,
          "Ian Kelling" <ian@iankelling.org>,
          "Xiaolong Ye" <xiaolong.ye@intel.com>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Ian Kelling'" <ian@iankelling.org>,
        "'Stefan Beller'" <sbeller@google.com>,
        "'Xiaolong Ye'" <xiaolong.ye@intel.com>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com> <4B3747D8D2724E98B6AC000FE4072A09@black7> <CAGZ79kaHOBaVCsVPen-K_5LyitcDzVbjL_kAqMkYKk_fQxH4PQ@mail.gmail.com>
In-Reply-To: <CAGZ79kaHOBaVCsVPen-K_5LyitcDzVbjL_kAqMkYKk_fQxH4PQ@mail.gmail.com>
Subject: RE: How to watch a mailing list & repo for patches which affect a certain area of code?
Date:   Mon, 10 Oct 2016 14:56:34 -0400
Organization: PD Inc
Message-ID: <AB0A757A7BE241B39C8193A633C61FED@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIjJj3QTHwrRBnWRSCOByTZosTA0gAAWTbA
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.23403
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Stefan Beller
> Sent: Monday, October 10, 2016 14:43
> 
> +cc Xiaolong Ye <xiaolong.ye@intel.com>
> 
> On Sun, Oct 9, 2016 at 2:26 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
> >> -----Original Message-----
> >> From: Ian Kelling
> >> Sent: Sunday, October 09, 2016 15:03
> >>
> >> I've got patches in various projects, and I don't have 
> time to keep up
> >> with the mailing list, but I'd like to help out with
> >> maintenance of that
> >> code, or the functions/files it touches. People don't cc me.
> >> I figure I
> >> could filter the list, test patches submitted, commits made,
> >> mentions of
> >> files/functions, build filters based on the code I have in
> >> the repo even
> >> if it's been moved or changed subsequently. I'm wondering 
> what other
> >> people have implemented already for automation around 
> this, or general
> >> thoughts. Web search is not showing me much.
> >>
> >
> > One thought would be to apply every patch automatically (to 
> the branches of interest?). Then trigger on the [successful] changed
> > code. This would simplify the logic to working on the 
> source only and not parsing the emails.
> >
> > -Jason
> >
> 
> I think this is currently attempted by some kernel people.
> However it is very hard to tell where to apply a patch, as it 

This is one of the reasons why I use bundles instead of format patch.

> is not formalized.
> See the series that was merged at 72ce3ff7b51c 
> ('xy/format-patch-base'),
> which adds a footer to the patch, that tells you where 
> exactly a patch ought
> to be applied.

Cant wait for that.

> 
> The intention behind that series was to have some CI system hooked up
> and report failures to the mailing list as well IIUC. Maybe 
> that helps with
> your use case, too?

I envisioned that it would try for each head he was interested in.

