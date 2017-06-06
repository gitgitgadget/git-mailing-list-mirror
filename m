Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E518C209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdFFWEM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:04:12 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:43666 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdFFWEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:04:12 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id IMa9dfkKk9tMzIMa9df5mE; Tue, 06 Jun 2017 23:04:09 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=Q9fys5e9bTEA:10 a=pGLkceISAAAA:8
 a=ozy0wyFa_bDOeyGl96sA:9 a=PUjeQqilurYA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <4A4DB115A50D432A8FF7B8589C5BAC84@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "David" <bouncingcats@gmail.com>,
        "Samuel Lijin" <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>
References: <1496671452.4809.2.camel@gmail.com>         <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>         <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>         <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>         <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>         <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>         <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>         <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com>         <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>         <xmqqr2yx8h9v.fsf@gitster.mtv.corp.google.com> <1496758102.6664.2.camel@gmail.com>
Subject: Re: What does this output of git supposed to mean ?
Date:   Tue, 6 Jun 2017 23:05:34 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="ISO-8859-15";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170606-8, 06/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfID/B7NCZUgJQ8GCWfaHwDFNQ7SISPReh2cA40eoX+5MNEjbnjZjRsQrjwrV4lC2fBQ/qeXzi7HJxoakWf4JnbO/uJwkiYmX6S3UCJBD//oiBzzRS8rY
 Vy777l3E5RjBhGTGQY9NZVF2dlTFALlV5xJMmD0/cSZOy4UPM7Cmovn3dAS/S2FBYZFGnBt3OpfDJ9p7VXxo8IsfN/jAdAgLQbeqBxeSU5XXOSTW5Yw1lut4
 +0AknQxME4ke81UNi/GneujrRqSP9Gycu+5JE+kyq7ANTjDaE+jbAT7KS5J0LnZB3bnqpFml+VISbfGS8Dr17bB+mAwa7ptnqjsLwitfNq4u7OoS8uBYhIUv
 FV3PhcN8H+FIGuBNUOb+97d/C44vRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
> On Tue, 2017-06-06 at 20:52 +0900, Junio C Hamano wrote:
>> "Waiting for the initial commit", or "No commits yet", can be
>> explained to describe the state of the current branch (not the state
>> of the repository), and it is correct that we do not have any commit
>> on the branch, and the branch is waiting for the initial commit.
>>
> Looks descriptive to me too. Just for the note, I wouldn't have asked
> this question if `git status` showed a message like this.
>

Maybe have a try at a patch to update the text? See the 
git/Documentation/SubmittingPatches for guidance.

> -- 
> Regards,
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> 

