Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2A91F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcHOPAH (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 11:00:07 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48055 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcHOPAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 11:00:06 -0400
Received: from PhilipOakley ([92.22.3.79])
	by smtp.talktalk.net with SMTP
	id ZJMxbc5Fv0KuvZJMxbJj1I; Mon, 15 Aug 2016 16:00:04 +0100
X-Originating-IP: [92.22.3.79]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=LkKjIWfvQdKNf3TZC4q4CQ==:117
 a=LkKjIWfvQdKNf3TZC4q4CQ==:17 a=IkcTkHD0fZMA:10 a=8q6LdnVOAAAA:8
 a=Y0naqFM5TM7HVrFlFV4A:9 a=jNYSTCpFY2gkngftge3H:22
Message-ID: <8191B8FB581F44AAA7E2467A845C7532@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
References: <20160811215035.4108-1-philipoakley@iee.org> <20160812234522.7792-1-philipoakley@iee.org> <5338959f-985f-d1b3-7287-eccde559d2c3@xiplink.com>
Subject: Re: [PATCH v6 00/12] Update git revisions
Date:	Mon, 15 Aug 2016 16:00:03 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOPRkWQ8UJK2E0x8G+D1JyOoO5jiTWOgY38SJI00HOOqJFGR2g43a9GQyMLgH+U4S++PbybP8JI3Tt9UruOjhcmuwZnKgf+jPtrLu1eFS0MD1SMjs2xh
 8un8QjJO+oB5Ewvg9iW1nvegh3RJCl+wlsR9XLly0d/urBObXj0C7jo/+y33gIDvuQfgrRixfvpNil7E/RluyKsUo8nh+4BUYpQT8GNBl6tflia2bJ2oCdyv
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-08-12 07:45 PM, Philip Oakley wrote:
>> These are the quick fixes to Marc's comments to patches 5,6,11,
>> and a consequential change to 12.
>>
>> Only the changed patches are included.
>
> Looks good to me -- no further comments!
>
> However, I still don't understand why git says 11/12 has "indent with 
> spaces" problems.

I'm guessing it's that the text is monospaced rather than tabbed, and it's 
flagging that.

I'd noticed that it was highlighted in the Git gui (which I use to visualise 
both the diff, the message and the part after the three dashes at the same 
time).


>
> M.
>
>
>> Philip Oakley (12):
>>   doc: use 'symmetric difference' consistently
>>   doc: revisions - name the left and right sides
>>   doc: show the actual left, right, and boundary marks
>>   doc: revisions: give headings for the two and three dot notations
>>   doc: revisions: extra clarification of <rev>^! notation effects
>>   doc: revisions: single vs multi-parent notation comparison
>>   doc: gitrevisions - use 'reachable' in page description
>>   doc: gitrevisions - clarify 'latter case' is revision walk
>>   doc: revisions  - define `reachable`
>>   doc: revisions - clarify reachability examples
>>   doc: revisions: show revision expansion in examples
>>   doc: revisions: sort examples and fix alignment of the unchanged
>>
>>  Documentation/gitk.txt             |   2 +-
>>  Documentation/gitrevisions.txt     |   6 +-
>>  Documentation/pretty-formats.txt   |   2 +-
>>  Documentation/rev-list-options.txt |   4 +-
>>  Documentation/revisions.txt        | 125 
>> ++++++++++++++++++++++++-------------
>>  5 files changed, 88 insertions(+), 51 deletions(-)

