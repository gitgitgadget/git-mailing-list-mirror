From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 10:51:57 -0700
Message-ID: <CAGZ79kYD9hjKGK=G7p+3-JEiFP7gGd8ERzdnocGDU8S1h6nDNA@mail.gmail.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
	<9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
	<CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
	<xmqqwq00fzlv.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYiG9=px3P+k1shqvt8ouXmfJjeKgCarj6KEQy08WAmjg@mail.gmail.com>
	<05CAAED4A70A416590A620BF584E7F3D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Heiko Voigt <hvoigt@hvoigt.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 22 19:52:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvr76-0004Jk-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 19:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbbEVRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 13:51:59 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34135 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359AbbEVRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 13:51:58 -0400
Received: by qkgx75 with SMTP id x75so17584188qkg.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bRNHGl5dm3j8pRqYZ+sn5tGOC5t1nsLPj7e6UxDPc14=;
        b=c294RHZlLUS7YHU2XSi8LDgzxxC2PJlgnbqL9h+oTC7k5NT8xtzOE+zxvdHys1ZxjL
         7lQhfsRgJwt6yZ4HWNrYz9vF28rtk2i3ai3wyhX2jA2EfT9oZ9ILZdYjIrpR87GwKRoB
         GnHqtiw4yqUWrRj4OkLILT8BK5L8z58jpq/tyb9EurXMY2yRLYTpGtbrUJ+IpEd/Imgw
         7j9D5wyj14n2WrsI/j/KSBfc6hHdw56Tgw9InQZdIQBxmu8Y6d7v8Z4X1+NHW9bn+ClW
         q9yXf56FL4yFfXylGCrudfitWMGiPFx6MUNiRiUXBVsEYw17sPBDTJFk5AG3W4HV101f
         /O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bRNHGl5dm3j8pRqYZ+sn5tGOC5t1nsLPj7e6UxDPc14=;
        b=EbLOWMmsF2B/YQqR9h+AV6cMqFG8SqDNoasEXmpZsTvsx2K6kOuoUI1rldtDwFVNyO
         kdnbtRRj5C1xL2R3KjnvNcnpievBvmx2WPzVvp3VPSIIxlOsD96am7TQo1/8lLonMDdX
         bRORIn8b79aQOo4S6Au5vOG+LPS81OqPLsqm8O56HlEhzTZbu+mR4NzTJ9qgKazD799V
         cB636wHS3dceqTitr1vN0z+ngpALxkz1+Q3ZNrTBjyIteakLVB3m8j/0ywbTD8PEx1wG
         dJJ+YyPlix4Otbj/7EqRWZ8sC5IyXBInOogBGED9r8JLxQlpz+9lBlOFa2ORsNEqRgRK
         GwXQ==
X-Gm-Message-State: ALoCoQnOcwN6iYzcZydYjGRYIGcLDZdEgKygsEDHTElup/sFzY+0I4dohYAEiQG5+YCyTafUY4+W
X-Received: by 10.55.51.141 with SMTP id z135mr20693050qkz.84.1432317117312;
 Fri, 22 May 2015 10:51:57 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 10:51:57 -0700 (PDT)
In-Reply-To: <05CAAED4A70A416590A620BF584E7F3D@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269744>

On Fri, May 22, 2015 at 10:35 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Stefan Beller" <sbeller@google.com>
>>
>> On Fri, May 22, 2015 at 7:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> On Thu, May 21, 2015 at 1:03 PM, Philip Oakley <philipoakley@iee.org>
>>>> wrote:
>>>>>>
>>>>>> +Submodules are not to be confused with remotes, which are meant
>>>>>> +mainly for branches of the same project;
>>>>>
>>>>>
>>>>> This use of 'branches' didn't work for me. "remotes are meant mainly
>>>>> for
>>>>> branches of the same project" ?
>>>
>>>
>>> The "branch" in the original is used in a much wider sense than
>>> usual branch (i.e. ref/heads/ thing you have locally); it refers to
>>> forks of the same project but with a bit of twist.  When you say
>>> repository A is a fork of the same project as my local repository,
>>> you would give an impression that A is not the authoritative copy of
>>> the project.  But you can say my repository and that repository A
>>> are branches of the same project, you give zero information as to
>>> A's authoritativeness.
>>
>>
>> While this is correct, I think it is also confusing, because 'branch'
>> is a command which deals with local branches only in my perception
>> To deal with remote branches you need to use the commands
>> {remote, fetch, pull}.
>>
>> So when someone mentions "branch" I need to think of local operations
>> in one repository and not on different distributed histories.
>>
>
> If we are having difficulties defining a "remote" here (its not defined in
> gitglossary.txt anyway),

Now that we have a discussion on what remotes are, I'll send a patch for that
as well.

> why not simply put a full stop (period) after the
> "Submodules are not to be confused with remotes.", and bypass the problem,
> avoiding digging the hole deeper.

I think we should dig deeper and point out the differences as it may
not be clear what
the differences are for new comers. Not digging deeper sounds to me like saying

    'git frotz' is not to be confused with 'git bar' FULL STOP AND I
WONT TELL YOU WHY!

which is not helpful. (Why is the documentation pointing out there is
a difference to
that other command/concept, but not saying what is different?)

>
>>>
>>>>     Submodules should not be confused with remote repositories, which
>>>> are
>>>>     meant to track the same repository, just at another location; ...
>>>
>>>
>>> I do not think this is a great improvement.  You now conflated
>>> "repository" to mean "project" in the latter half of the sentence,
>>> while you are trying to explain what a "remote repository" is.
>>
>>
>> That's true.
>>
>>>
>>> Your copy of git.git is not the same repository as mine; they have
>>> different histories.  Both repositories are used to work on the same
>>> project.  "submoules are not remotes, which are other repositories
>>> of the same project", perhaps?
>>
>>
>> That makes sense.
>>
>
> If maybe that the feature we should pick on is the common root of the
> development between the local and remote repository, and quite distinct for
> the submodule. This allows remotes to be on the same machine, as well as
> distant machines and server.

I don't think this is actually true for all remotes. Think of shallow clones
(they have no root or a different root) or even subtrees which are pulled
in via a remotes?

The main thing about remotes is "not being here" (as in "part of this
repository". As you point out it can be nearby in the local fs or even on
another machine, or in the cloud)

>
> It is I believe technically possible to have a submodule which is its own
> super project, with and without recursion, but would be very atypical, and
> would belong in the 'don't do that' category
