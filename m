From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] glossary: add "remote" and "submodule"
Date: Wed, 27 May 2015 16:29:13 -0700
Message-ID: <CAGZ79kauSsZK3_X+zTwL8TKuZiHNMGvMZfoCemW9-K7RWgrgCA@mail.gmail.com>
References: <1432761209-4120-1-git-send-email-sbeller@google.com>
	<xmqq617dk621.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbz6d8j1p5d-pO2cpou76ivhkCQPq4cpGxozc-9cnACPQ@mail.gmail.com>
	<xmqqwpztiptw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 01:29:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxklD-0006o8-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 01:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbbE0X3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 19:29:14 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35607 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbbE0X3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 19:29:14 -0400
Received: by qgg60 with SMTP id 60so9911593qgg.2
        for <git@vger.kernel.org>; Wed, 27 May 2015 16:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hqzZTLs9kQnF+L3bJIwNTFhQogoKHnUai/7UsENobBo=;
        b=HvGLQPdCKnRQCBQ+e5IiOsnkB4g+9phVAiKMdtC4jk6dSet5JkRSNoviEy7uFZX7yh
         TOHe14ilplAymkqX4IH8NXklsCqXfnXkNtpW7+P3fYTDEvLszy9JryzOxZ3c3LTYyWkB
         Z3s3EAd/2r3p2gqwFW1cPD4dPMH2BcKIfqlMKQYyhE0uXRuj0FD2Z5IkjLH65nJWfPWh
         oU58hFGcgMF6SHyOrJTcurPnB97cMGabhz4vaWzGEZ2BfE0rkpB9J15QrAVaPEoY5qEz
         8bJNtur3Q65n4H9Q/Cc+A194SzfcpBQLihemscshMx0rM9vcmgxCr3MYd17WiuAp1G9A
         r8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hqzZTLs9kQnF+L3bJIwNTFhQogoKHnUai/7UsENobBo=;
        b=IGPoRTgSiDVfhEOqvIg4G9JVPxFYSh1ekC94Iea1os8my7B2nK3ESLu/41Uzrh+OUh
         b/pJfSCt+4rY0S1n0dmeFIqjgIqfV3TmybpEkuqEgz//XiUGwpwjOamv//hUoHejRsHf
         A705lgPhRGFDbaoBPTJvOwh5ExyZo+h93xCtRGOvCs6bkXq3/SvRLK/TP3+Vlmny6Uc/
         uet6hiWY1oHz5NZzBI8chvVBX/4L+U92kPHEWrK72QZl+AFcpAjXEBm0T/GV2gaE7ELh
         xQpkMlowdsnTCcoel/GtkhhhdfiOxF13/a73Igb1+1bXDuldkSnd/cqxyCdKyR6K/r2h
         XUXA==
X-Gm-Message-State: ALoCoQl/23NDt1qok5u/P8zM2MqA5FRqFpofyM6MIqYrWy33vnCdl/zNqr28Ad3XuHeiL2TbzhXP
X-Received: by 10.140.96.202 with SMTP id k68mr43046162qge.102.1432769353221;
 Wed, 27 May 2015 16:29:13 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 16:29:13 -0700 (PDT)
In-Reply-To: <xmqqwpztiptw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270119>

On Wed, May 27, 2015 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> +[[def_submodule]]submodule::
>>>> +     A <<def_repository,repository>> inside another repository. The two
>>>> +     repositories have different history, though the outer repository
>>>> +     knows the commit of the inner repository.
>>>
>> ... But correctness trumps brevity indeed.
>
> I do not think the correct way is that much longer, though.
>
> A repository inside another repository. The two repositories have different history
> A repository that holds the history of a separate project inside another repository
>
> Heh, they are the same length, no?
>
>>
>>>
>>>        A repository that holds the history of a separate project
>>>        inside another repository (the latter of which is called
>>>        superproject).
>>
>> This is better than what I proposed, but confusing. When naming
>> a project a submodule, my mental standpoint is the superproject.
>> ("This project has the submodule foo and bar"). But In your description
>> the superproject is called "another repository".
>
> That is because you are adding an entry for "submodule" to the
> glossary, no?  I was writing from submodule's point of view, i.e. "I
> (submodule) is inside another repository, and my project is separate
> from that other repository's".

The submodule doesn't know it's a submodule though, so the point of view
"I (as a submodule)" only happens rarely in the real world?
I have a library in mind when talking about submodules. And the libraries
maintainer may not care if their library is used as a submodule or just
"make install"ed or just put somewhere in the filesystem

Usually submodules are only interesting from the superprojects point of view,
like "I want to upgrade libfoo now, so I make a commit changing the gitlink
of the submodule to point at that tag/commit"
That's why I found the presented perspective a bit strange.

>
>>>        The containing superproject knows about the
>>>        names of (but does not hold copies of) commit objects of the
>>>        contained submodules.
>>
>> That makes sense to point out here. Though should we also introduce
>> "superproject" now?
>
> Yes, that is what I was hinting at.

ok
