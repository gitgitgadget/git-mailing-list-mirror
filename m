From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 10:05:54 -0700
Message-ID: <CAGZ79kYiG9=px3P+k1shqvt8ouXmfJjeKgCarj6KEQy08WAmjg@mail.gmail.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
	<9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
	<CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
	<xmqqwq00fzlv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:06:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvqOl-0001wX-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 19:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013AbbEVRGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 13:06:09 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36171 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546AbbEVRFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 13:05:55 -0400
Received: by qkx62 with SMTP id 62so16392901qkx.3
        for <git@vger.kernel.org>; Fri, 22 May 2015 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HaDDYtKDlHuVTGRO0tvGmALKYHNlAqupXERE2pA5erk=;
        b=YQpilSxTgx+jq0FRkQfMYpkFHSdmHTIXPNMxHhEZoB8OGY6AyIttwFTSXJdwggFgEB
         wVYwfr3E2an0rOYWCeOa6ciJva3HGjRoveOoU1gFsUpX2+fFQXjVwHDe1O7Q4EY+Z3m5
         wSJbvcfshKB3zyttrULUvNnGoqFCV8j/UzO1FHrytK80DZZcT/i+QoUcQjZrz65lNKlH
         xkWRSJ+Q5lAdOWOvpiDLfh34AnPVWzM4ORY1DD9NbSZh/JNyJUg5BfeNkKxnIBB8cosQ
         rCuFACsj3fW9F+PoROYFO0iei8LHdBt3cXP8FfHYe6q6qrrl5kwPVz53rDOFJJvCayAj
         rz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HaDDYtKDlHuVTGRO0tvGmALKYHNlAqupXERE2pA5erk=;
        b=BJMgbjazj52PWZ8EGY25T94xq/jnTZwAUBPQ4TQAw6VpEs1R/28ByhdzTU7mcUYjOQ
         WUrZmbeeeSmUDzxXUvC2y3QGSgoQwn/Rk78/4oTjhVULUhUdCmJYQcPzhK1C6nuMhse5
         Y5MkXOE4WT3Z2N7t+5zbokcgw26an8SRC7PNEZbWStqd0MI8H5PLckOYENif9lDkGSIx
         +OUmTHxPWCR+I77h3aOZLS/H95XaRgqTJiH2aHJmnbmDuq5xo2m9w8vkyLhzrjWDuypc
         NHL5HElHIS7k5AEK5NC2QUSMsVmvjvi+kVu98zg1WtrQ9Xv0aFjJuEgl7rmyaIcOVe+U
         YbXg==
X-Gm-Message-State: ALoCoQmEMSDbFssCBtwJToD5OoMTWbROEtpbgPxb8dyAsRNla3BTY+TlXEprCCRp37KkP9nQ4LYE
X-Received: by 10.140.196.140 with SMTP id r134mr12387639qha.60.1432314354623;
 Fri, 22 May 2015 10:05:54 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 10:05:54 -0700 (PDT)
In-Reply-To: <xmqqwq00fzlv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269737>

On Fri, May 22, 2015 at 7:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, May 21, 2015 at 1:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>>> +Submodules are not to be confused with remotes, which are meant
>>>> +mainly for branches of the same project;
>>>
>>> This use of 'branches' didn't work for me. "remotes are meant mainly for
>>> branches of the same project" ?
>
> The "branch" in the original is used in a much wider sense than
> usual branch (i.e. ref/heads/ thing you have locally); it refers to
> forks of the same project but with a bit of twist.  When you say
> repository A is a fork of the same project as my local repository,
> you would give an impression that A is not the authoritative copy of
> the project.  But you can say my repository and that repository A
> are branches of the same project, you give zero information as to
> A's authoritativeness.

While this is correct, I think it is also confusing, because 'branch'
is a command which deals with local branches only in my perception
To deal with remote branches you need to use the commands
{remote, fetch, pull}.

So when someone mentions "branch" I need to think of local operations
in one repository and not on different distributed histories.

>
>>     Submodules should not be confused with remote repositories, which are
>>     meant to track the same repository, just at another location; ...
>
> I do not think this is a great improvement.  You now conflated
> "repository" to mean "project" in the latter half of the sentence,
> while you are trying to explain what a "remote repository" is.

That's true.

>
> Your copy of git.git is not the same repository as mine; they have
> different histories.  Both repositories are used to work on the same
> project.  "submoules are not remotes, which are other repositories
> of the same project", perhaps?

That makes sense.
