Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE6A1F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215AbcHDXKH (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:10:07 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:41592 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759316AbcHDXKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:10:05 -0400
Received: from PhilipOakley ([92.22.58.0])
	by smtp.talktalk.net with SMTP
	id VRm5biS2SgKstVRm5bsSoN; Fri, 05 Aug 2016 00:10:02 +0100
X-Originating-IP: [92.22.58.0]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=NfeqYv5mxLrwTvklEzeiGg==:117
 a=NfeqYv5mxLrwTvklEzeiGg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=8q6LdnVOAAAA:8 a=JTmXVXfvzvuLIeEKvZcA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=jNYSTCpFY2gkngftge3H:22
Message-ID: <62BF22F2A6654F5DBB84660A7E32CFBD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:	"Marc Branchaud" <marcnarc@xiplink.com>,
	"Jeff King" <peff@peff.net>, "Jakub Narebski" <jnareb@gmail.com>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Date:	Fri, 5 Aug 2016 00:10:03 +0100
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
X-CMAE-Envelope: MS4wfJ21F9kMvLbHLKibIx+TF5hPo/ai5G6C/BOeIfwiXA3EK8VeamU4sVEFmsPqIRzUTnpsCXlU2DZ0UHTQzcq6s625cvkA8wK4O9QLlIQbcpNNYjg331EA
 sbgT2jTIH5P66RAelowNP36xwRI6w7kfhHLYbAv3f5bAqIX3BT3P6O1VafZrMPeTGXXvwL3s+tLb3nUu3aYt2Ld6exdyg4ehVGXsIgtcv76aTEFfWWdhEE3Q
 opZyatek4lKgrC1lv4VCxCnxgbrITXfmjkX+pvegTrk=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>

>
> * po/range-doc (2016-07-20) 8 commits
> - doc: revisions - clarify reachability examples
> - doc: revisions - define `reachable`
> - doc: gitrevisions - clarify 'latter case' is revision walk
> - doc: gitrevisions - use 'reachable' in page description
> - doc: give headings for the two and three dot notations
> - doc: show the actual left, right, and boundary marks
> - doc: revisions - name the left and right sides
> - doc: use 'symmetric difference' consistently
>
> Clarify various ways to specify the "revision ranges" in the
> documentation.
>
> Updates in 4/8 ("give headings") is reported to break formatting?
> cf. <57913C97.1030001@xiplink.com>
>
>

Just to say I haven't forgotten.

The format breakage was analysed by Jeff (12 July 2016 23:12) and looks to 
be internal to the man viewer.

There's still a suggestion surrounding one of the headings to sort (which 
has gone around in circles;-).

Also I now think I have a sensible idea for the <rev>^@/! examples (i.e. use 
the Loeliger illustration) - that'd make if 9 in the series (was originally 
2).

Plus ensure all comments across V1-4 have been attended to (including yours 
of 12 July 2016 18:04).

--
Philip 

