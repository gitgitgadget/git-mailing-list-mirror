From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule does not yield complete logs")
Date: Fri, 22 May 2015 22:35:04 +0100
Organization: OPDS
Message-ID: <BACC0468FBD24DA584507676EC4E6A5A@PhilipOakley>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com> <73db761f3c737965f64ac45005f7a716@www.dscho.org> <5b4bab2727a9fcee3a07724c64752cf9@www.dscho.org> <0B3203305DF54249930E5903864B4988@PhilipOakley> <93994cca5e27388aee7e7c5fd4508816@www.dscho.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Roberto Tyley" <roberto.tyley@gmail.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Robert Dailey" <rcdailey.lists@gmail.com>,
	"Heiko Voigt" <hvoigt@hvoigt.net>,
	"Jens Lehmann" <Jens.Lehmann@web.de>, "Git" <git@vger.kernel.org>,
	"Thomas Ferris Nicolaisen" <tfnico@gmail.com>,
	<emma@gitforteams.com>
To: "Johannes Schindelin" <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 22 23:34:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvuaF-0003ZX-Fc
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 23:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033AbbEVVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 17:34:19 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:41987 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757058AbbEVVeS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 17:34:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AyEgD7n19VPJBLFlxcgxBUXoc6vSMdDIVrBAQCgTlNAQEBAQEBBwEBAQFAASQbQQODWQUBAQEBAwECBQEBHREeAQEQBgsLAgMFAgEDFQMJGgsUAQQIBwsGBwMUBhMIAgECAwEKA4d5AxYJtmGYMQ2EcgELHASLOoE9AYEPgVUQAgFQgx6BFgWMBoZ8eYM8hB1igwGGbogOgyiDWYI6JIE+PTGCRwEBAQ
X-IPAS-Result: A2AyEgD7n19VPJBLFlxcgxBUXoc6vSMdDIVrBAQCgTlNAQEBAQEBBwEBAQFAASQbQQODWQUBAQEBAwECBQEBHREeAQEQBgsLAgMFAgEDFQMJGgsUAQQIBwsGBwMUBhMIAgECAwEKA4d5AxYJtmGYMQ2EcgELHASLOoE9AYEPgVUQAgFQgx6BFgWMBoZ8eYM8hB1igwGGbogOgyiDWYI6JIE+PTGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.13,478,1427756400"; 
   d="scan'208";a="520526962"
Received: from host-92-22-75-144.as13285.net (HELO PhilipOakley) ([92.22.75.144])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 22 May 2015 22:34:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269764>

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> Hi,
>
> On 2015-05-22 19:14, Philip Oakley wrote:
>> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
>
>>> On 2015-05-22 11:42, Johannes Schindelin wrote:
>>>
>>>> On 2015-05-22 10:33, Roberto Tyley wrote:
>>>>> On Tuesday, 19 May 2015, Stefan Beller <sbeller@google.com> wrote:
>>>>>> On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
>>>>>> <rcdailey.lists@gmail.com> wrote:
>>>>>> > How do you send your patches inline?
>>>>> [snip]
>>>>>> This workflow discussion was a topic at the GitMerge2015 
>>>>>> conference,
>>>>>> and there are essentially 2 groups, those who know how to send 
>>>>>> email
>>>>>> and those who complain about it. A solution was agreed on by 
>>>>>> nearly all
>>>>>> of the contributors. It would be awesome to have a git-to-email 
>>>>>> proxy,
>>>>>> such that you could do a git push <proxy> 
>>>>>> master:refs/for/mailinglist
>>>>>> and this proxy would convert the push into sending patch series 
>>>>>> to the
>>>>>> mailing list. It could even convert the following discussion back 
>>>>>> into
>>>>>> comments (on Github?) but as a first step we'd want to try out a 
>>>>>> one
>>>>>> way proxy.
>>>>>>
>>>>>> Unfortunately nobody stepped up to actually do the work, yet :(
>>>>>
>>>>>
>>>>> Hello, I'm stepping up to do that work :) Or at least, I'm 
>>>>> implementing a
>>>>> one-way GitHub PR -> Mailing list tool, called submitGit:
>>>>>
>>>>> https://submitgit.herokuapp.com/
>>>>
>>>> Wow!!!
>>>>
>>>> I will make sure to test it with a couple of patches I want to 
>>>> submit anyway.
>>>
>>> I just tried this with https://github.com/git/git/pull/139 and would 
>>> like to tell you about two wishes I had immediately:
>>>
>>> - If the author of a patch I am submitting is not myself, could 
>>> submitGit maybe add that `From: ` line at the top of the mail?
>>> - The patch series is sent without a cover letter, but it would be 
>>> *really* great if a path series consisting of more than one patch 
>>> could have the initial comment of the Pull Request as a cover 
>>> letter, with the link to the original Pull Request at the bottom? 
>>> This would also be the mail to use in the "In-reply-yo" header 
>>> instead of the first patch.
>>>
>>> Thanks so much!
>>> Dscho
>>
>>
>> A separate request would be to be able to use PRs that are for forks
>> of git/git, such as msysgit etc. (i.e. have a common --root), which
>> would help in the upstreaming of some changes.
>>
>>
>> I ask because I just logged in and my preparatory PR318
>> (https://github.com/msysgit/git/pull/318) for rejuvenating the
>> msvc-build system wasn't listed, probably because of the forking.
>
> You can easily change what upstream your PR is intended for. For 
> example, I made my PR from my own Git fork (which is based on 
> msysgit/git) relative to git/git by entering the URL:
>
> https://github.com/git/git/compare/next...dscho:non-win-fixes?expand=true
>
> So there is no real need for anything extra: the only git.git project 
> that requires emails (that I am aware of) for the submission process 
> is git/git.
>
> Ciao,
> Dscho
>
Do I read you right.. That it's necessary to create a PR on git/git 
before submitGit can be used.

And that if I already have a PR which goes back to an alternate fork 
(e.g. my example), then I must move or duplicate that PR onto git/git 
before it can be used.

[I find a few UI issues with the github interface in that I'd hoped to 
be able to see which outgoing PRs I have from my own fork but I can't 
see how to do that]

regards

Philip 
