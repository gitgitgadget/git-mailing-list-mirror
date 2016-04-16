From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH] Adding list of p4 jobs to git commit message
Date: Sat, 16 Apr 2016 15:46:48 +0200
Message-ID: <CABEqOBwcb1BAmvcBLow38BnQoxRNVYtfXzGAodUv_qwEBWRFvQ@mail.gmail.com>
References: <010201541b7a24b8-83b0f526-2f01-40e3-afc8-d81549af70d4-000000@eu-west-1.amazonses.com>
	<xmqq4mb2bot7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih79hV-76SxjW0NHjD+WsvO1s6rthM=pvqyrh10zbrFi2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 15:46:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arQYr-0000Qh-5n
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 15:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbcDPNqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 09:46:50 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35877 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcDPNqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 09:46:49 -0400
Received: by mail-qg0-f66.google.com with SMTP id f105so12629417qge.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=azSVI4yMuZXqp/gPE5TLwPTdqEpqS/vrs2LYCDG+3qY=;
        b=Z72V1Rt/8XAUi1YFYpcx2IXN/3pwzKO7IJoPm2h9y6E/7MIHZ/sVl8/gaF2q60zA6U
         OdIHWNFpxAGnUSHiAhyTxNFoBp05YslsKItNA0abwz9BsDQ+Mhe7QSu8EKxO6Ytf3lIO
         5GItHqcGFu4/okvIJqhp14FmvdAHIk19YFjWeKHuf1zah5+7Q9rMeI+b40Y4wrI5tiHC
         1NKm4hGKIgJkFOnsMYDyY1iAaiON5kuQongOx+Aw7VapgZc+kxZd5SOcLXLNgpDMd902
         fSrJiZBc9K6UIhjHNpg0jyhqMnvYZp9RVfVY3mSdaIFriltwcbDB+tvmUc17NKZhHT9u
         dPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=azSVI4yMuZXqp/gPE5TLwPTdqEpqS/vrs2LYCDG+3qY=;
        b=LYW3Tg9G811hiwvo8N6h8FBUVVPuVriB7MLViheZJq+idQ2YOSCsW40itVe39kMV8o
         KUZ/gucJzHVkxXn00IuHcxArwAtXE54QpVo9APfDb5fmTMdL78q7qV1lcxZUKVJmeS4/
         0Ce3llJQm3sJPYC2XznUaivIxk2c2rQlZ4xRUWbfBJXHZLQkZWcrgJza2SURn5E3Ravz
         Fc2wClAde/5eruVb30MEphGeJfb/4ZRoZnMCdURNmHm5PkXUi0+q4xT7ASA04KUhUQMl
         EqTG7nXYW4e7T+xuwLc8dsykyOGMEl/k9QXmZmLI7rGu1PPlxjbNC40Pag5b/vOEaP/n
         t7oA==
X-Gm-Message-State: AOPr4FXl90AUNaOGMrufX+9FBrdsuy3Z4+dYJ6EF45nwZJ+u7JFZdJR9wQBDEc5riTYm9yiO0rt/TwEqo9QboA==
X-Received: by 10.140.255.3 with SMTP id a3mr12630567qhd.20.1460814408524;
 Sat, 16 Apr 2016 06:46:48 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Sat, 16 Apr 2016 06:46:48 -0700 (PDT)
In-Reply-To: <CAE5ih79hV-76SxjW0NHjD+WsvO1s6rthM=pvqyrh10zbrFi2rQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291723>

Hi,

I tried to address all the issues and (among other things) I've added
a new test case to t/t98 group (t9829-git-p4-jobs.sh).

Unfortunately, Travis CI build now fails with "non-executable tests:
t9829-git-p4-jobs.sh" (https://travis-ci.org/git/git/jobs/123555944)

Can you please advise how to mark it as executable? Does it need to be
added to some configuration file? Or am I interpreting the error
message incorrectly?

Regards,
Jan

On Sat, Apr 16, 2016 at 12:10 AM, Luke Diamand <luke@diamand.org> wrote:
> On 15 April 2016 at 21:27, Junio C Hamano <gitster@pobox.com> wrote:
>> Jan Durovec <jan.durovec@gmail.com> writes:
>>
>>> ---
>>
>> A few issues.  Please:
>>
>>  (1) Sign-off your work.
>>
>>  (2) Try to find those who are familiar with the area and Cc them.
>>
>>      "git shortlog -s -n --since=18.months --no-merges git-p4.py"
>>      may help.
>>
>>  (3) Follow the style of existing commits when giving a title to
>>      your patch.
>>
>>      "git shortlog --since=18.months --no-merges git-p4.py" may
>>      help you notice "git-p4: do this thing" is the common way to
>>      title "git p4" patches.
>>
>>  (4) Justify why your change is a good thing in your log message.
>>      What you did, i.e. "list p4 jobs when making a commit", can be
>>      seen by the patch, but readers cannot guess why you thought it
>>      is a good idea to extract "job%d" out of the P4 commit and to
>>      record them in the resulting Git commit, unless you explain
>>      things like:
>>
>>      - what goes wrong if you don't?
>>      - when would "job%d" appear in P4 commit?
>>      - is it sane to assume "job0", "job1",... appear consecutively?
>>
>>  (5) Describe what your change does clearly.  "Adding list" is not
>>      quite clear.  Where in the "git commit message" are you adding
>>      the list, and why is that location in the message the most
>>      appropriate place to add it?
>
> Additionally, it would be very useful to add a test case (see t/t98*).
> There are quite a few test cases for git-p4, and they make maintenance
> a lot easier.
>
> Some documentation (Documentation/git-p4.txt) would also be useful.
>
> Thanks
> Luke
