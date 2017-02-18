Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFCD8201A8
	for <e@80x24.org>; Sat, 18 Feb 2017 11:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbdBRLt2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 06:49:28 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:45770 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdBRLt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 06:49:27 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id f3W0cpyxwxR4bf3W0c42lh; Sat, 18 Feb 2017 11:49:25 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=uPZiAMpXAAAA:8 a=XBZPwp8dKfLoi_RSh9AA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=svzibyHiZmA4t4YY0eFS:22
Message-ID: <D4A69FDAB8BD4D0080108611B61E5EF8@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Christian Couder" <christian.couder@gmail.com>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox><xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com><alpine.DEB.2.20.1702142150220.3496@virtualbox><xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com><CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com><E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley><alpine.DEB.2.20.1702151509251.3496@virtualbox><77C7E23E18774409AA1818B12C844985@PhilipOakley> <xmqq60kb0ywi.fsf@gitster.mtv.corp.google.com>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
Date:   Sat, 18 Feb 2017 11:49:25 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPNZcvkaxZHdaDCPs2owCd6vuBHIkdHNVDF6Ka/vlFfX73PUPP1wAssBVBelF/ibMXvE8tw9k4mupnd4wVW8G8WbCMFjW5kSIcGK1BTNPE7cZgG5Rrzl
 084x/B984wIEkb6vTQoXagOuQ57zmbqkMQ1V4dhBUa2qarATZ8vI49QZdW0iGuOxK4NXH/3LAAfu9xxkghtO7YI1XcT6a8pjiGg1zFPpStf6+D19/8dqOjiw
 Iq9Cdie0BFXWYc7NoRhgHw9CzkC1rwVIYmZdQYIc0ifGTEdj3JrlU7n6hki0zg3uBgLMPP7zi5OjUUF+zottEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, February 16, 2017 12:20 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> It may even be worth 'splitting' the pu branch sequence into the
>> existing pu (with merges from series that are selected as reasonable),
>> and then a pr branch (public review?) on top of that holding the rest
>> of the series that have been submitted, so that the CI can do a full
>> test on the tips of them to support those devs with limited test
>> capability.
>
> I won't stop you from publishing such a pr branch yourself.

But would others see it?... (rhetorical, better thoughts below))

>
> For patches whose merit is not clear because the problem they try to
> solve is under-explained, whose solution is ill-designed, etc., IOW,
> with issues that makes me judge that they are not interesting enough
> for 'pu',

It is reasonble that that a project's integrator is able to make these 
decisions. For some projects they may have a layered approach of descisions 
which does allow the gradations for the submitted feature series.

Some of this does fall into dscho's differentiation between those patch 
series that should pass the CI (continuous integration) testing, and those 
that are there for CT (continuous testing) feedback. This could either be an 
extra branch marking the transition, or a named commit similar to the 
"pu^{/^### match next}", etc. In some ways it is similar to my 'pr' 
suggestion, without the inclusion of the 'all and sundry' series.

For for integrators who are willing/want to recieve any/all contributions 
for public view (usually those for projects of a more lenient and less 
critical variety), then even the CT grouping could then have those 
additional pr submissions. For Git, you provide that that 'voice of reason' 
for gatekeeping the pu branch.


> it is not worth my time to deal with whitespace brekages
> in them to make them not even apply, to figure out what base the
> patches are meant to apply to, or to resolve conflicts caused by
> them with topics already in flight, etc.
>
If a centralised CT service was available to the project, maybe via the 
GitHub PR process (which isn't curently used by the project) then is may be 
a way of allowing the 'all and sundry' contributors to get their ideas upto 
a basic level before even bothering yourself (because PRs do not trouble 
you).

It may need an extra gatekeeper between the passing patches (PRs) and auto 
submission  (the Heroku script thingy) which could flood the list with with 
inane changes - one only has to look at the 
http://stackoverflow.com/questions/tagged/git stream to see that.

At least if there was a break point within pu that allowed differentiation 
between the series that should fit a CI view, and those that are still at 
the CT stage, then that may help.

Thanks

Philip.

