From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 10:26:17 -0700
Message-ID: <xmqqvbfked6u.fsf@gitster.dls.corp.google.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
	<9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
	<CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
	<xmqqwq00fzlv.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYiG9=px3P+k1shqvt8ouXmfJjeKgCarj6KEQy08WAmjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:26:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvqiO-0005qI-1L
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 19:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946437AbbEVR0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 13:26:22 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33819 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946421AbbEVR0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 13:26:19 -0400
Received: by ieczm2 with SMTP id zm2so36203434iec.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sJl6nK0YUTMI5p64tuO4xa9K152uF9JnbKzPl229sb0=;
        b=vwvchu+1sM+JigTrjd3Au1HJfAUAWt82cjwZ3+Pwaq3B8LWH0ID+3DwrTM9Sol9QoE
         sAqAmCQMIsrQCWm855v8CdPvVSTNvxjfJ0cxQbxMlcMr/eE/iErbG4dwvS0LD2KyRreb
         bRQ9DmxFx8lhWYB2EA9fFPAZgs3YmEKwKpesONwtgA1+bXXlFAapm4EBosPF8DcuIbLj
         hPhHNq/TmsE/KbCzE94UdD6mK4jARgfBs+TeVQZaPeRZKMIroTrdt0oiwWGXEVLOuopT
         baXQa9Ze+Oeomtx4s2/jeKkHvxDizFrRoJXh3S/bQi089ufl7ml9NdMgD+0TYTvSC1oQ
         Ipsg==
X-Received: by 10.50.36.9 with SMTP id m9mr6994563igj.15.1432315578906;
        Fri, 22 May 2015 10:26:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id t7sm4407194ign.8.2015.05.22.10.26.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 10:26:18 -0700 (PDT)
In-Reply-To: <CAGZ79kYiG9=px3P+k1shqvt8ouXmfJjeKgCarj6KEQy08WAmjg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 22 May 2015 10:05:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269741>

Stefan Beller <sbeller@google.com> writes:

> On Fri, May 22, 2015 at 7:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Thu, May 21, 2015 at 1:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>>>> +Submodules are not to be confused with remotes, which are meant
>>>>> +mainly for branches of the same project;
>>>>
>>>> This use of 'branches' didn't work for me. "remotes are meant mainly for
>>>> branches of the same project" ?
>>
>> The "branch" in the original is used in a much wider sense than
>> usual branch (i.e. ref/heads/ thing you have locally); it refers to
>> forks of the same project but with a bit of twist.  When you say
>> repository A is a fork of the same project as my local repository,
>> you would give an impression that A is not the authoritative copy of
>> the project.  But you can say my repository and that repository A
>> are branches of the same project, you give zero information as to
>> A's authoritativeness.
>
> While this is correct, I think it is also confusing, because...

Oh, no question about it.  In modern Git parlance, it confuses by
conflating 'branch' (which is local ref/heads/ thing) with something
entirely different.  I wasn't saying "'branch' is correct and we
should keep the description that way".

If you dig ancient list archives, you see Linus and I using 'branch'
to mean "your copy of the project" quite often, and that is likely
where the above phrase originated.  It was one of those "explaining
historical background", nothing more.

I probably should start prefixing all my "explaining historical
background" sentences as such.

>> I do not think this is a great improvement.  You now conflated
>> "repository" to mean "project" in the latter half of the sentence,
>> while you are trying to explain what a "remote repository" is.
>
> That's true.
>>
>> Your copy of git.git is not the same repository as mine; they have
>> different histories.  Both repositories are used to work on the same
>> project.  "submoules are not remotes, which are other repositories
>> of the same project", perhaps?
>
> That makes sense.

Thanks.
