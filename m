Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A782202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 12:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbdJCM0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 08:26:34 -0400
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:36480 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752555AbdJCM0c (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2017 08:26:32 -0400
X-Greylist: delayed 2328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Oct 2017 08:26:32 EDT
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-web-02.w4a.fr)
        by mut-mta1-se01a-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1dzLfm-0002f8-VL; Tue, 03 Oct 2017 13:47:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-02.w4a.fr (Postfix) with ESMTP id 9E76D141B00;
        Tue,  3 Oct 2017 13:47:21 +0200 (CEST)
Received: from zose-mta-hub-out-web-02.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-02.w4a.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R58syp2yDP3c; Tue,  3 Oct 2017 13:47:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-02.w4a.fr (Postfix) with ESMTP id BD7B6141BF8;
        Tue,  3 Oct 2017 13:47:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-web-02.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-02.w4a.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rD7rFWv5P6af; Tue,  3 Oct 2017 13:47:20 +0200 (CEST)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by zose-mta-hub-out-web-02.w4a.fr (Postfix) with ESMTP id A4F34141B00;
        Tue,  3 Oct 2017 13:47:20 +0200 (CEST)
Date:   Tue, 3 Oct 2017 13:45:52 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, rpjday@crashcourse.ca,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <1964024229.332266.1507031152104.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <xmqqfub1m6u5.fsf@gitster.mtv.corp.google.com>
References: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca> <20171002171300.GP19555@aiede.mtv.corp.google.com> <xmqqfub1m6u5.fsf@gitster.mtv.corp.google.com>
Subject: Re: What means "git config bla ~/"?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.6_GA_1776 (ZimbraWebClient - FF55 (Linux)/8.7.6_GA_1776)
Thread-Topic: What means "git config bla ~/"?
Thread-Index: MwlOh8WOfyjWmruLCfiEIPSrR21NCg==
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5uf1QWafz+yxw7C0TRj36srj1g3/PwYZaTCzSym8uE9HMtvy10EysbYR
 jIG9c63ImYqffHXy7MTP1hkfW3TmDpgod0m/B3atS0yigu4IXAzDQCfbyXkyCIOc4HEG+muVFDQJ
 /1nO68mXrIgvr4s1gpzNmvFv7gEYLu4xv1f/LHK7ff4Z+4+qiquKjlu1hYsjjFprjQPFk8m4tSTf
 ORUp3ylzmY/pt5I0dsoxBXVR9uIERajiGnmEMQjNQ3UvlQO9n0UbJ4nQhjQKvWllH4svC9CMzdHr
 kNElmcbCeCj+KW5Mg71V+o4dEAc41OSjJZzKlo6Y0xynlrNX6Jdvj668dFfSXd33tMscXgH8tHBz
 ebMh0j+4sB4At/e8tafDQX/j55bXVm6rGErPrBDuX/xO8xOJkhKeIhbigKYpagWVoiYnnEnKJyuQ
 b3VBBrj67F5Poh21S3bhuz7LR03u4f+/w+ZjkFqg9hIMSBLfLekpwhar/sNvTPqyZiPX9OudbKYp
 XwWgZXY2o9fr4SCO7mjMuu34TlbCwf/6MjjmGOkiWu6hf0b5IfXLj/DwsTDUodajPMpYjw3SpwiZ
 CpJ5vqdKVn3CX+kpBOT3o15QXaLsUcXynrr/glxSctLzxp4bh3v8DL/oaTEMBpWbx/ahMq6//WEI
 ZFgKOEDAvn/Pe0myXtfoCIYazYmfXdTLYHncJgBH8MKM9wBhh2uNOjRTMvu2BRyudNbJBTnlOI/w
 qW7/OJX73fNifyQmDG9Bl18zywTFAJQ4J776lTBV2lFfvARFoQ1xN5OCyB1nAY+SvkDaTwpcfMmw
 r0h6gpRCxy4/rMf5kW15AIswpdDsvAqPkwCdAnXWZCEscrlYhn99/UV07e6HmlxP5mXi73rJddao
 KLkuEp74tPj5kCGFVFBMXckcw4Ndxg41mODwzm7mYSPL1GtkJBPvPDjBPaowofdkfHH45uOa+2za
 ijFWOhQGQ5qWVRvOXjTzodyMhfB5Nsj7GDjTR7LfnmtZGhid75BRkdl1uuhwq772x8t0GfT6IY6N
 BmtvlPE9yn4+7R7hw716lUpV
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano" <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>> what's with that "git config bla ~/"? is this some config keyword
>>> or something?
>> ...
>>
>> I agree with you that it is less clear than it could be.  Ideas for
>> clarifying it?
> 
> Yeah, if it were
> 
>	git config section.var ~/some/thing
> 
> that would be far clearer than "bla" that what we see is a mere
> placeholder.

Agreed.

> Another obvious option is to remove the parenthetical comment.
> 
> Or "(but you can give values without quoting and let your shell
> expand it)", without a confusing sample command that proved not to
> help very much.

I prefer your "section.var" proposal above. I think people who really understand shell quoting do not need the explanations, and others probably need the example.

While we're there, the formatting is also wrong ('' quoting, while we normally use `` quoting for shell commands).

Sounds like a nice microproject for my students :-). A patch should follow soon.

-- 
Matthieu Moy
https://matthieu-moy.fr/
