Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3611F406
	for <e@80x24.org>; Tue, 12 Dec 2017 16:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbdLLQ5m (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 11:57:42 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:31031 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbdLLQ5m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 11:57:42 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id OnsCe54DUAp17OnsCenRlg; Tue, 12 Dec 2017 16:57:40 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=5rxgeBVgAAAA:8 a=ybZZDoGAAAAA:8 a=S3yDWP1VWZ5Qt24fTbMA:9 a=wPNLvfGTeEIA:10
 a=R-AVCXAG9WsA:10 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <FC22650D36BD4035925DCA978D52A912@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com><5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de><7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley> <xmqq1skcleo7.fsf@gitster.mtv.corp.google.com> <AB9C836772CD4391A8866DC71103CCFE@PhilipOakley> <5A25705C020000A1000292B0@gwsmtp1.uni-regensburg.de> <582105F8768F4DA6AF4EC82888F0BFBE@PhilipOakley> <5A2E4480020000A1000293D8@gwsmtp1.uni-regensburg.de>
Subject: Re: Re: Re: bug deleting "unmerged" branch (2.12.3)
Date:   Tue, 12 Dec 2017 16:57:39 -0000
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
X-Antivirus: AVG (VPS 171211-6, 11/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDT9CsgBr3CwPNe2s7KmlAJnVbWI/v23vfI3BOC5Y9U2uLTGRVNfzeXVvL8hrcOEPffnMkQeuOkuLK2KhCHU1QWXSIPdJLOpQU+5x0YGMVoGBx1cpqAO
 +/rhroE39JWd/+YV9j9TlLukDNWeZea+FqT1sggAraYCsmAw/0wOHBSVgxrUvLLygEp4PnScJw4OP7vwgimQlJYZluux89zcMnU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
> Hi!
>
> Sorry for the late response:
> On a somewhat not-up-to date manual:
>
>       -d, --delete
>           Delete a branch. The branch must be fully merged in its upstream
>           branch, or in HEAD if no upstream was set with --track or
>           --set-upstream.
>
>
> Maybe the topic of multiple branches pointing to the same commit could be 
> mentioned (regarding the status of each such branch being considered to be 
> merged or not). Also "fully merged" could be made a bit more precise, 
> maybe.
>
> Maybe gitglossary could have definitions for "merged" and "fully merged" 
> with manual pages referring to it.

Thanks, I'll add your note to my list of clarifications.

Philip

>
> Regards,
> Ulrich
>
>
>>>> "Philip Oakley" <philipoakley@iee.org> schrieb am 08.12.2017 um 21:26 
>>>> in
> Nachricht <582105F8768F4DA6AF4EC82888F0BFBE@PhilipOakley>:
>> From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
>>> Hi Philip!
>>>
>>> I'm unsure what you are asking for...
>>>
>>> Ulrich
>>
>> Hi Ulrich,
>>
>> I was doing a retrospective follow up (of the second kind [1]).
>>
>> In your initial email
>> https://public-inbox.org/git/5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.d
>> e/
>> you said
>>
>> "I wanted to delete the temporary branch (which is of no use now), I got 
>> a
>> message that the branch is unmerged.
>> I think if more than one branches are pointing to the same commit, one
>> should be allowed to delete all but the last one without warning."
>>
>> My retrospectives question was to find what what part of the 
>> documentation
>> could be improved to assist fellow coders and Git users in gaining a 
>> better
>> understanding here. I think it's an easy mistake [2] to make and that we
>> should try to make the man pages more assistive.
>>
>> I suspect that the description for the `git branch -d` needs a few more
>> words to clarify the 'merged/unmerged' issue for those who recieve the
>> warning message. Or maybe the git-glossary, etc. I tend to believe that 
>> most
>> users will read some of the man pages, and would continue to do so if 
>> they
>> are useful.
>>
>> I'd welcome any feedback or suggestions you could provide.
>> --
>> Philip
>>
>>> >>> "Philip Oakley" <philipoakley@iee.org> 04.12.17 0.30 Uhr >>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>> > "Philip Oakley" <philipoakley@iee.org> writes:
>>> >
>>> >> I think it was that currently you are on M, and neither A nor B are
>>> >> ancestors (i.e. merged) of M.
>>> >>
>>> >> As Junio said:- "branch -d" protects branches that are yet to be
>>> >> merged to the **current branch**.
>>> >
>>> > Actually, I think people loosened this over time and removal of
>>> > branch X is not rejected even if the range HEAD..X is not empty, as
>>> > long as X is marked to integrate with/build on something else with
>>> > branch.X.{remote,merge} and the range X@{upstream}..X is empty.
>>> >
>>> > So the stress of "current branch" above you added is a bit of a
>>> > white lie.
>>>
>>> Ah, thanks. [I haven't had chance to check the code]
>>>
>>> The man page does say:
>>> .    -d
>>> .    Delete a branch. The branch must be fully merged in its upstream
>>> .    branch, or in HEAD if no upstream was set with --track
>>> .    or --set-upstream.
>>>
>>> It's whether or not Ulrich had joined the two aspects together, and if 
>>> the
>>> doc was sufficient to help recognise the 'unmerged' issue. Ulrich?
>>> --
>>> Philip
>>>
>>>
>>
>> [1] Retrospective Second Directive, section 3.4.2 of (15th Ed) Agile
>> Processes in software engineering and extreme programming. ISBN 
>> 1628251042
>> (for the perspective of the retrospective..)
>> [2] 'mistake' colloquial part of the error categories of slips lapses and
>> mistakes : Human Error, by Reason (James, prof) ISBN 0521314194 
>> (worthwhile)
> 

