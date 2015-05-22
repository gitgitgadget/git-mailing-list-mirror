From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 20:47:38 +0100
Organization: OPDS
Message-ID: <7A83EF56E45A425A9756B4B084CA69A1@PhilipOakley>
References: <1432163517-22785-1-git-send-email-sbeller@google.com><9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley><CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com><xmqqwq00fzlv.fsf@gitster.dls.corp.google.com><CAGZ79kYiG9=px3P+k1shqvt8ouXmfJjeKgCarj6KEQy08WAmjg@mail.gmail.com><05CAAED4A70A416590A620BF584E7F3D@PhilipOakley> <CAGZ79kYD9hjKGK=G7p+3-JEiFP7gGd8ERzdnocGDU8S1h6nDNA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>,
	"Petr Baudis" <pasky@suse.cz>, "Heiko Voigt" <hvoigt@hvoigt.net>
To: "Stefan Beller" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 21:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvsun-0001mF-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 21:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbbEVTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 15:47:24 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:30615 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756229AbbEVTrX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 15:47:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DFEAAkh19VPJBLFlxcgxCBMoMfgy5twzUEBAKBO00BAQEBAQEHAQEBAUABJBtBA4NZBQEBAQECAQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBMMsB6GVJ1hgSGKGYQ6S4JvL4EWBZMCeYs8kiSDWYEEZh8kHIFTPTGCRwEBAQ
X-IPAS-Result: A2DFEAAkh19VPJBLFlxcgxCBMoMfgy5twzUEBAKBO00BAQEBAQEHAQEBAUABJBtBA4NZBQEBAQECAQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiBMMsB6GVJ1hgSGKGYQ6S4JvL4EWBZMCeYs8kiSDWYEEZh8kHIFTPTGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.13,477,1427756400"; 
   d="scan'208";a="520523381"
Received: from host-92-22-75-144.as13285.net (HELO PhilipOakley) ([92.22.75.144])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 22 May 2015 20:47:21 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269752>

From: "Stefan Beller" <sbeller@google.com>
> On Fri, May 22, 2015 at 10:35 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Stefan Beller" <sbeller@google.com>
>>>
>>> On Fri, May 22, 2015 at 7:36 AM, Junio C Hamano <gitster@pobox.com> 
>>> wrote:
>>>>
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>
>>>>> On Thu, May 21, 2015 at 1:03 PM, Philip Oakley 
>>>>> <philipoakley@iee.org>
>>>>> wrote:
>>>>>>>
>>>>>>> +Submodules are not to be confused with remotes, which are meant
>>>>>>> +mainly for branches of the same project;
>>>>>>
>>>>>>
>>>>>> This use of 'branches' didn't work for me. "remotes are meant 
>>>>>> mainly
>>>>>> for
>>>>>> branches of the same project" ?
>>>>
>>>>
>>>> The "branch" in the original is used in a much wider sense than
>>>> usual branch (i.e. ref/heads/ thing you have locally); it refers to
>>>> forks of the same project but with a bit of twist.  When you say
>>>> repository A is a fork of the same project as my local repository,
>>>> you would give an impression that A is not the authoritative copy 
>>>> of
>>>> the project.  But you can say my repository and that repository A
>>>> are branches of the same project, you give zero information as to
>>>> A's authoritativeness.
>>>
>>>
>>> While this is correct, I think it is also confusing, because 
>>> 'branch'
>>> is a command which deals with local branches only in my perception
>>> To deal with remote branches you need to use the commands
>>> {remote, fetch, pull}.
>>>
>>> So when someone mentions "branch" I need to think of local 
>>> operations
>>> in one repository and not on different distributed histories.
>>>
>>
>> If we are having difficulties defining a "remote" here (its not 
>> defined in
>> gitglossary.txt anyway),
>
> Now that we have a discussion on what remotes are, I'll send a patch 
> for that
> as well.
>
>> why not simply put a full stop (period) after the
>> "Submodules are not to be confused with remotes.", and bypass the 
>> problem,
>> avoiding digging the hole deeper.
>
> I think we should dig deeper and point out the differences as it may
> not be clear what
> the differences are for new comers. Not digging deeper sounds to me 
> like saying
>
>    'git frotz' is not to be confused with 'git bar' FULL STOP AND I
> WONT TELL YOU WHY!

Hi Stefan,
This was more of a case of "simply a full stop, 'cos I can't easily tell 
you why" ;-).  I've seen too many work situations (*) where colleagues 
just dig deeper when they should stop digging, hence the note. It may be 
that the style of reason could be changed. This is the final 
introductory paragraph and was being pushed down partly because of this 
problem (explaining things by saying what its not).

(*) The usual phrase in a report would be "A moments thought will show 
that ..." for those concepts that would take two pages to explain and 
would still be misunderstood by the unthinking folks.

That all said, if a nice well understood explanatory phrase can be found 
then I'm all for it.

>
> which is not helpful. (Why is the documentation pointing out there is
> a difference to
> that other command/concept, but not saying what is different?)
>
>>
>>>>
>>>>>     Submodules should not be confused with remote repositories, 
>>>>> which
>>>>> are
>>>>>     meant to track the same repository, just at another location; 
>>>>> ...
>>>>
>>>>
>>>> I do not think this is a great improvement.  You now conflated
>>>> "repository" to mean "project" in the latter half of the sentence,
>>>> while you are trying to explain what a "remote repository" is.
>>>
>>>
>>> That's true.
>>>
>>>>
>>>> Your copy of git.git is not the same repository as mine; they have
>>>> different histories.  Both repositories are used to work on the 
>>>> same
>>>> project.  "submoules are not remotes, which are other repositories
>>>> of the same project", perhaps?
>>>
>>>
>>> That makes sense.
>>>
>>
>> If maybe that the feature we should pick on is the common root of the
>> development between the local and remote repository, and quite 
>> distinct for
>> the submodule. This allows remotes to be on the same machine, as well 
>> as
>> distant machines and server.
>
> I don't think this is actually true for all remotes. Think of shallow 
> clones
> (they have no root or a different root) or even subtrees which are 
> pulled
> in via a remotes?

I'd avoided mentioning that potential explanation mud-hole on the same 
basis that it would be hard.

>
> The main thing about remotes is "not being here" (as in "part of this
> repository". As you point out it can be nearby in the local fs or even 
> on
> another machine, or in the cloud)
>
>>
>> It is I believe technically possible to have a submodule which is its 
>> own
>> super project, with and without recursion, but would be very 
>> atypical, and
>> would belong in the 'don't do that' category
>
regards
Philip 
