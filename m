From: "Zorba" <cr@altmore.co.uk>
Subject: Re: is there an easier way to do this ? [Scanned]
Date: Tue, 30 Dec 2008 12:00:48 -0000
Message-ID: <gjd2hv$c31$4@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D1B@ALTMORE-SVR.altmore.local> <8c9a060812292017m600ca246pf8660630d49a7067@mail.gmail.com> <gjc83i$juc$4@ger.gmane.org> <3ab397d0812292132h6ffe7e49o650fbf35588666db@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 13:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdJ0-0002M9-Uc
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbYL3MBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYL3MBO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:01:14 -0500
Received: from main.gmane.org ([80.91.229.2]:56431 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbYL3MBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:01:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHdHa-0008GG-HT
	for git@vger.kernel.org; Tue, 30 Dec 2008 12:01:10 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 12:01:10 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 12:01:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.1 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.1 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104174>

Hi Jeff,

Thanks for that, and yes, I will be more careful with my postings. There is 
already so much traffic on this list, the last thing anyone needs is more 
fragmentation.

I'm so chuffed now that I got $ git add -A (don't even need the dot, i read 
!) $ git commit !
Thank you !

I was up till 5:30am this morning working on this. Another in a series of 
late nights. My partner stuck her head round the door at 4 and at 5 and 
looked at me like I've flipped out (gone crazy). I think she's gonna try and 
get them to take me away, so I've only got limited time to "get git" :-)

Its exactly what I need for versioning off my project where the file 
"portfolio" (i.e. the configuration of the containers) changes every version 
(probably the containers change more than content - I know, badly written, 
but hey, that's all in the past)

On another note - your name is very resonant of this part of the world 
(Northern Ireland) - I'm guessing you're from here or have some roots here ?

"Jeff Whiteside" <jeff.m.whiteside@gmail.com> wrote in message 
news:3ab397d0812292132h6ffe7e49o650fbf35588666db@mail.gmail.com...
> you should reply to the original thread, so that you don't create a
> new one.  makes it almost impossible to find what you're referencing.
>
> also, don't bother with git-rm.  a simple rm is the same thing.
> (committing will notice that this file is gone)
>
> On Mon, Dec 29, 2008 at 8:29 PM, Zorba <cr@altmore.co.uk> wrote:
>> (punches air with fist)
>> yes indeed !
>>
>> sorry, I didn't follow up on the --update flag first time
>>
>> $ git add -A .
>> $ git commit
>>
>> home in a boat!
>>
>> "Jacob Helwig" <jacob.helwig@gmail.com> wrote in message
>> news:8c9a060812292017m600ca246pf8660630d49a7067@mail.gmail.com...
>>> On Mon, Dec 29, 2008 at 20:11, Conor Rafferty
>>> <conor.rafferty@altmore.co.uk> wrote:
>>>> Ah, but what about the files that have been removed from this version ?
>>>> - that's the whole point of doing commit -a, so I don't have to spend
>>>> ages doing diffs to produce a list of files to feed into git-rm
>>>>
>>>> Or have I missed another glarer ?
>>>>
>>>> -----Original Message-----
>>>> From: Jacob Helwig [mailto:jacob.helwig@gmail.com]
>>>> Sent: 30 December 2008 04:01
>>>> To: git@vger.kernel.org
>>>> Cc: Conor Rafferty
>>>> Subject: Re: is there an easier way to do this ? [Scanned]
>>>>
>>>> On Mon, Dec 29, 2008 at 19:51, Zorba <cr@altmore.co.uk> wrote:
>>>>> The manual shows you can SHOW untracked files, but not add them as
>>>>> part of the commit -a jig
>>>>>
>>>>> Seems a bit strange that git-add operates on both exisging and new
>>>>> files when used standalone, but its behaviour changes when
>>>>> encapsulated in commit -a...
>>>>>
>>>>> So, I thought maybe $ git commit -a, then $ git add .
>>>>> but then the files tracked have missed the commit boat they were meant
>>>>
>>>>> to be on, haven't they,
>>>>>
>>>>> hang on -
>>>>> what about
>>>>>
>>>>> $ git add .
>>>>> $ git commit -a
>>>>>
>>>>> I do believe I've cracked it
>>>>> if so, it seems a bit wasteful, 2x adds (one explicti and one embedded
>>>>
>>>>> in -a) ? shame on you linux kernel guys, i'd have expected better :-)
>>>>>
>>>>> "Zorba" <cr@altmore.co.uk> wrote in message
>>>>> news:gjc52u$ehc$4@ger.gmane.org...
>>>>>> ok, now I'm in this for real, archiving versions of our website
>>>>>> project (5k files approx)
>>>>>>
>>>>>> so here is the workflow:
>>>>>>
>>>>>> - copy version 1 files into GIT dir
>>>>>>
>>>>>> - open git bash
>>>>>>
>>>>>> $ git init
>>>>>>
>>>>>> $ git add .
>>>>>>
>>>>>> $ git commit -m "version1"
>>>>>>
>>>>>> all vanilla ? cool
>>>>>> next job = store version 2, so delete version 1 files from GIT dir,
>>>>>> copy in version 2
>>>>>> version2 has different files from 1 - which ones? Out of 5k files
>>>>>> could be 1% = 50 new ones, and same amount removed. Why should I
>>>>>> care, with such a powerful friend as git around, n'est pas?
>>>>>> THIS TIME we are going to be CLEVER and use "-a" flag on commit to
>>>>>> pick up any files that have been REMOVED (or "deleted" in git-speak)
>>>>>>
>>>>>> $ git commit -a -m "version2"
>>>>>>
>>>>>> BUT this does not pick up any new ones that have been added,
>>>>>>
>>>>>> and when we run
>>>>>>
>>>>>> $ git status > ../git_status.txt
>>>>>>
>>>>>> these are referred to as "untracked files"
>>>>>> only problem there are 50 ish
>>>>>> is there not another flag on git commit to treat any untracked file
>>>>>> as a new file ?
>>>>>> (would save me typing or creating a list out of these untracked ones
>>>>>> and feeding them into git add)
>>>>>>
>>>>>> I know, I realise now I should have looked up git-commit in the
>>>>>> manual - in case its not there, pls enlighten me !
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe git" in the
>>>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> If you do an explicit git add, then you don't need the -a on git 
>>>> commit,
>>>> since everything you want to commit will already be in the index for 
>>>> git
>>>> commit to work with.
>>>>
>>>
>>> See the -A flag for git add (and it's reference to --update).  -A will
>>> remove files that have been removed, add untracked, and update ones
>>> that have changed, all in one go.
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
