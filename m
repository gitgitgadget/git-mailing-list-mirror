From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Sun, 27 Mar 2016 13:08:54 -0400
Message-ID: <CAPig+cQyXi3_EwZakwrL3JahqZPFsJEifaTOB-KrZLtkxn5Oew@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cf9b-1417ac08-005c-4d72-91f1-0b07f00a24d5-000000@eu-west-1.amazonses.com>
	<CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
	<CAFZEwPMaZkUi+DvohhVrc_dW_8cdfJsZX-YA_SRWDp021UvDLQ@mail.gmail.com>
	<CAPig+cTFK=HPAtk7MeMQSTccmiaai++3sVn6J_pRcSi+w_4Lng@mail.gmail.com>
	<CAFZEwPMJiCTKszfCAVrzsA+jNHwoHPaXySSD3HyiO=f5AikvZg@mail.gmail.com>
	<CAPig+cS3usDDeTMzjqbxqi+k+XbmjawZ0TF20s9-vM6o=Fm=OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 19:09:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akEBQ-0006nM-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 19:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbcC0RI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 13:08:56 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36770 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcC0RIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 13:08:55 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so12562521vkg.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=i3TMbY8p0bK4kgRxX4J7WfeEtpTwexwVEnZRIkr/DLY=;
        b=bbv+pOLSoqvQJaeFDfb81sC0JjDUW9WykFVG0IoVAd78zAdRjE/GDEmZFJbBMgdElA
         yz81wO5Eh7Kkd78ZO2Ic8H8Bc0DjFHB6MDV5dMAh1KoRK93787NeWqWYbMeZCAJ+0Gtg
         Xu+0Qz1vWMnmpM5toc0AKcVJ5l8gl/aPYuAxlP2ij3ZMyadqHpsO9jFneL9hR+KWRfI0
         XB1xnKPLg/DXUi9B/Zh7d7wQ732RUQKNQNXP3lrmUVkHFBwr7hqogjhKsMqb8POfF/3a
         lBTqizPqy/FcoFa/tEbD4qauZsdQAuRIxVePaRZgg1BahPyA8DKMXjI/6a3JqbICHGGE
         f8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=i3TMbY8p0bK4kgRxX4J7WfeEtpTwexwVEnZRIkr/DLY=;
        b=OvLZlLILSVqLSt9bz1+Uuw5G9HX/ePO09BDbUPjLWBAODLE43ir601aN5RiITzgdCL
         SSBdEzQfdmlDujEePGvldTLQwjB5J70b3Zbil59EuuEWWzTlLYtcR/Fh5NrEHGjbFjZs
         mnhx0LxyNXugZdBJAonwjU587klNJ6Q1Bl2a23tfXxNaRBOJCrSf0RmJ2VDDGKHn6Fvg
         1reD+DypqdacgWkYNxRi2NFkDdZi4gp6no6ib2te9lL2T2PCcoVei2mTvtOz6DS71IaL
         ENInnkppVr6TqQWWX8JmO4pih62x5kmtiS38Mmboc9IU9253KwJiQNw1/HuIbewi/Uk9
         eq/A==
X-Gm-Message-State: AD7BkJJI4ydIsyObxWmYX5/pE2t7kAzU33zm1P4+EyZb6XJfX6k5vqQ/vw1giUvIwRoLlPgK3xtC6eZtubzVSQ==
X-Received: by 10.159.36.172 with SMTP id 41mr1033742uar.123.1459098534670;
 Sun, 27 Mar 2016 10:08:54 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 27 Mar 2016 10:08:54 -0700 (PDT)
In-Reply-To: <CAPig+cS3usDDeTMzjqbxqi+k+XbmjawZ0TF20s9-vM6o=Fm=OQ@mail.gmail.com>
X-Google-Sender-Auth: 7SfXEYjIxJ5f2l3k74oHkDCNKI4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290017>

[forwarding this to the list, as well, since I again didn't notice
when replying that Pranit had accidentally dropped the mailing list as
a recipient]

On Sun, Mar 27, 2016 at 12:59 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Mar 27, 2016 at 5:05 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, Mar 27, 2016 at 12:40 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> However, even if you take the approach of making 'check-for-diff'
>>> succeed unconditionally and always count diffs, the current
>>> implementation is still overly complicated. It would be much simpler
>>> to let 'check-for-diff' always create the output file, and then use
>>> "test_line_count = 0 out" when expecting no diffs than to sometimes
>>> create the output file and sometimes not. The shell '>' operator will
>>> truncate the file to zero size even before grep is invoked, so you
>>> don't need to worry that results from an earlier test will pollute
>>> 'out' for a subsequent test, even if grep finds no matches. Thus,
>>> 'check-for-diff' collapses to this tiny implementation:
>>>
>>>     grep '^diff --git' "$1" >out
>>>     exit 0
>>>
>>> Or, if you want to be terse:
>>>
>>>     grep '^diff --git' "$1" || exit 0 >out
>>
>> I tried using both of this and it gives an error
>
> These worked fine for me when I rewrote the test script before making
> the suggestion. You'll need to provide more information if you want to
> get to the bottom of the problem you experienced (for instance, show
> the exact code you used and the actual error message).
