From: Omar Othman <omar.othman@booking.com>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 08:37:57 +0100
Message-ID: <530D99D5.5060308@booking.com>
References: <530B0395.5030407@booking.com>	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>	<vpqzjlf5q2z.fsf@anie.imag.fr> <xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 08:38:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIZ49-0002Iq-G2
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 08:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbaBZHiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 02:38:00 -0500
Received: from mail-out5.booking.com ([5.57.20.182]:49821 "EHLO
	mail-out5.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbaBZHh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 02:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=VbVzINK/CrSbnQUe1qsvm1zeC+7r++YVKQXjPfcQSYo=;
	b=fygRf9acbIYtBObuUovApcyeP1QIyi78MumefKk4iqUQMmUZbkoPmNZ+OoNAGDg8Zj8Io5d0jYH8b5iaw8s+rN3NPh1V5u56DAbYq0f4Yk7DzxgzH+IyMdeb9mYYhTUvBY8NE6YSXd5fvDpfSVSOl4P2+I8UMZ/Xk4RQeWI3biA=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:44061)
	by mtx-201.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIZ42-00015m-UI; Wed, 26 Feb 2014 08:37:58 +0100
Received: from [10.155.74.57] (port=32989)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIZ42-0003j6-P4; Wed, 26 Feb 2014 08:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242700>


> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Holger Hellmuth <hellmuth@ira.uka.de> writes:
>>
>>> Am 24.02.2014 17:21, schrieb Matthieu Moy:
>>>> $ git add foo.txt
>>>> $ git status
>>>> On branch master
>>>> Changes to be committed:
>>>>     (use "git reset HEAD <file>..." to unstage)
>>>>
>>>>           modified:   foo.txt
>>> Maybe status should display a stash count if that count is > 0, as
>>> this is part of the state of the repo.
>> Maybe it would help some users, but not me for example. My main use of
>> "git stash" is a safe replacement for "git reset --hard": when I want to
>> discard changes, but keep them safe just in case.
>>
>> So, my stash count is almost always >0, and I don't want to hear about
>> it.
> "status" is about reminding the user what changes are already in the
> index (i.e. what you would commit) and what changes are in the
> working tree, from which you could further update the index with
> (i.e. what you could commit).
>
> One _could_ argue that stashed changes are what could be reflected
> to the working tree and form the source of the latter, but my gut
> feeling is that it is a rather weak argument.  At that point you are
> talking about what you could potentially change in the working tree,
> and the way to do so is not limited to "stash pop" (i.e. you can
> "git cherry-pick --no-commit $a_commit", or "edit" any file in the
> working tree for that matter, with the same ease).
>
> So, I tend to agree with you, while I do understand where "I want to
> know about what is in stash" is coming from (and that is why we do
> have "git stash list" command).
Same comment. Everyone will have his own opinion. As long as the 
messages are not customizable, we can debate for hours and everybody has 
a valid point.
