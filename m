From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 07:36:44 -0700
Message-ID: <xmqqwq00fzlv.fsf@gitster.dls.corp.google.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
	<9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
	<CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:36:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvo4C-0001Ot-GA
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbbEVOgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:36:48 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34451 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011AbbEVOgq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:36:46 -0400
Received: by igbhj9 with SMTP id hj9so37864626igb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9rzJkqsNnjdK/TnA1cSTTHUTVAB4eNwl1K081IAyRy8=;
        b=Gw5Q+L4RJQ2F+pLQFdLczvmCnT9yji6EonnQ/E/UCODfnYLyMrY8e+DvnwE9vOKwih
         BJ0HWUlbav0S3+nmzpCdoD8af/Ec1L1dME3niQ1I6Dp+rCygywQUl8kFJcCyLqV6RhCk
         Q6aIplGMVMuHPT56eSQdBJaiSwsynwqBXXECq8jMTiFR2cgOq5kOT/8TR8FejnkYEPLR
         lZWanXV4nMeQLHUVgZfu3mTBp+kX0IcVEJuwteNB2Kscj82aXMq+TdfRuJU12HuSq1z9
         K14N+D3nJNQQv4cYaaaNuze0F3rGUKhAwzfl+W1TGDlQ+HHNwVQaY6ZNr0AdC8rOd+fs
         yAmA==
X-Received: by 10.50.43.137 with SMTP id w9mr6062904igl.30.1432305406305;
        Fri, 22 May 2015 07:36:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id p74sm1906971ioe.27.2015.05.22.07.36.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 07:36:45 -0700 (PDT)
In-Reply-To: <CAGZ79kZ5yxG7k++9QFRhnb=6A3HD64Kz3_B9UBrHA+Akht8tZw@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 May 2015 15:08:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269721>

Stefan Beller <sbeller@google.com> writes:

> On Thu, May 21, 2015 at 1:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>> +Submodules are not to be confused with remotes, which are meant
>>> +mainly for branches of the same project;
>>
>> This use of 'branches' didn't work for me. "remotes are meant mainly for
>> branches of the same project" ?

The "branch" in the original is used in a much wider sense than
usual branch (i.e. ref/heads/ thing you have locally); it refers to
forks of the same project but with a bit of twist.  When you say
repository A is a fork of the same project as my local repository,
you would give an impression that A is not the authoritative copy of
the project.  But you can say my repository and that repository A
are branches of the same project, you give zero information as to
A's authoritativeness.

>     Submodules should not be confused with remote repositories, which are
>     meant to track the same repository, just at another location; ...

I do not think this is a great improvement.  You now conflated
"repository" to mean "project" in the latter half of the sentence,
while you are trying to explain what a "remote repository" is.

Your copy of git.git is not the same repository as mine; they have
different histories.  Both repositories are used to work on the same
project.  "submoules are not remotes, which are other repositories
of the same project", perhaps?
