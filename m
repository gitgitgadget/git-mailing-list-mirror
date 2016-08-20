Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFD41FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbcHTXGw (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 19:06:52 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:26682 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbcHTXGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 19:06:51 -0400
Received: from PhilipOakley ([92.22.56.254])
        by smtp.talktalk.net with SMTP
        id bFLkbhizwHGLwbFLkbbM7X; Sun, 21 Aug 2016 00:06:48 +0100
X-Originating-IP: [92.22.56.254]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=b6TTeGxEIY1/y6ABFUBF6w==:117
 a=b6TTeGxEIY1/y6ABFUBF6w==:17 a=8nJEP1OIZ-IA:10 a=1f_8sUU9AAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=vggBfdFIAAAA:8 a=OAUql30MaUbGY_24a5YA:9
 a=x8gzFH9gYPwA:10 a=YINEebd3GXqNeZDW032c:22 a=AjGcO6oz07-iQ99wixmX:22
 a=Bn2pgwyD2vrAyMmN8A2t:22 a=ulBnneXc4k8OkFd-VeVl:22
Message-ID: <48C4D1F0A72F4C559FCBC5AF70EB494F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Zenaan Harkness" <zen@freedbms.net>, <git@vger.kernel.org>
References: <20160820072214.GB24992@x220-a02> <91F685E894D94BB89892C695B8C1796E@PhilipOakley> <20160820222519.GC5044@x220-a02>
Subject: Re: git rm --cached should be git rm --cache or git rm --stage
Date:   Sun, 21 Aug 2016 00:06:48 +0100
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
X-CMAE-Envelope: MS4wfDTG8onfka0Q9Y8UGzjWzWN8ng7xLMONZo2bU3+T/skDPziGiMrDbvGUfYrYPmwb1zNUsGw90qcC0yywhltbc3R77Kue2I7kUJDJ0Sydh3mTmelzP1Oh
 kOL2610sbxGVLl1xOcvXb9TB+ZYHJKDMZzHK/FDn/CxHtHZpr6ZWnQXu/K6PSEVH37wgnUG31Y8HhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Zenaan Harkness" <zen@freedbms.net>
> On Sat, Aug 20, 2016 at 08:14:25PM +0100, Philip Oakley wrote:
>> From: "Zenaan Harkness" <zen@freedbms.net>
>> >
>> > Please CC me :)
>
>> >  or perhaps something like:
>> >  "does not unstage a file, it actually stages the removal of the
>> >  file(s) from the repo (assuming it was already committed before) but
>> >  leaves the file in your working tree (leaving you with an untracked
>> >  file)"
>> >
>>
>> The easiest way is to simply swap around the two sentences so that the
>> positive action is listed first - this better matches people's typical
>> cognition. Human Error (by Reason)[1] tells us to Never state warnings 
>> and
>> caveats after the instruction, and preferably be positive.
>>
>> "--cached:
>> Working tree files, whether modified or not, will be retained unchanged.
>> The option will remove paths from the index (only) to unstage them from
>> future commits."
>
> That's much better. +1. Thanks.
>

One better maybe to add (at the end): "The paths become untracked."

That way we hit all the key codewords that the user may recognise, or need 
to see, to understand.

Submittimg a patch is faily easy, especially if you have git send-email set 
up.
"patches to git@vger.kernel.org (read Documentation/SubmittingPatches for 
instructions on patch submission)." (from the README.md)

https://github.com/git/git/blob/master/Documentation/SubmittingPatches


>
>> >
>> >The git "stage" is a primary concept, and a primary noun (one reason
>> >many of us have come to appreciate git), and git's cmd line options and
>> >help docs ought reflect this.
>> >
>> >Thanks,
>> >Zenaan
>> >--
>>
>> Philip
>> [1] https://www.amazon.com/Human-Error-James-Reason/dp/0521314194
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

