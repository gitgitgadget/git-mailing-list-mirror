From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] Adding list of p4 jobs to git commit message
Date: Fri, 15 Apr 2016 23:10:30 +0100
Message-ID: <CAE5ih79hV-76SxjW0NHjD+WsvO1s6rthM=pvqyrh10zbrFi2rQ@mail.gmail.com>
References: <010201541b7a24b8-83b0f526-2f01-40e3-afc8-d81549af70d4-000000@eu-west-1.amazonses.com>
	<xmqq4mb2bot7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jan Durovec <jan.durovec@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:10:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBwh-0003J3-VN
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbcDOWKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:10:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33282 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbcDOWKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:10:31 -0400
Received: by mail-oi0-f66.google.com with SMTP id v67so15292174oie.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8EwWGiNozEPIXQVjwZh/wtqgVpsJjID1tq0KF2YJh30=;
        b=Q5p8rJ3p7dgaWxX7FmcaqIr6UHiw/MkTPafMZpFgX7FpReLjsUA/4Q4ucPnzb/gEMu
         hHdFP8WRh+f8/9Bkx8lPVhHeHDZ3YmWOZMKHu11HgS6aNh6PlATMG0EunsLx0hirl0/b
         SpNrUYWV9AXYcB/KGNX3n0axaEDVROECUmHW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8EwWGiNozEPIXQVjwZh/wtqgVpsJjID1tq0KF2YJh30=;
        b=IKUI7HhS8IOlD5nxfKKZ/rapzcV2zZUGapwMCywdAo3ANwE5CIdTSFAVrOE2F2Y6EY
         bivEPadXhIUfO7gFoxeTCUVcN9voKykCEwIbk4trCFWV4ch1fuldn5aIaSoXP8AyHVal
         alvh9XeNpj9ww71PJi4RyxkcNq9s2OibTrAp+zs3tMDa6W8PMUxBdEBJ87dv+vRTdFDb
         yBnf31kISUVvj45hXeGod28YQbAc0lWTCe/K9QW062FuhzpXyNkB6Td4FKS885AvMUhD
         spguIvKig61wq52buDcIxBjP65M7+4uApvNkuMUahH4yGavDDAdhOBgLWWGl3SdxDz6k
         71ag==
X-Gm-Message-State: AOPr4FXpPEcg/3M8cqGjfxrA55b/zFDKlx4zPgUG69vNJdBoxcZlX9O5WiLpw/NUTxKOUp6jLlHEf08LDclfkQ==
X-Received: by 10.157.4.23 with SMTP id 23mr11182146otc.190.1460758230123;
 Fri, 15 Apr 2016 15:10:30 -0700 (PDT)
Received: by 10.202.44.74 with HTTP; Fri, 15 Apr 2016 15:10:30 -0700 (PDT)
In-Reply-To: <xmqq4mb2bot7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291679>

On 15 April 2016 at 21:27, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Durovec <jan.durovec@gmail.com> writes:
>
>> ---
>
> A few issues.  Please:
>
>  (1) Sign-off your work.
>
>  (2) Try to find those who are familiar with the area and Cc them.
>
>      "git shortlog -s -n --since=18.months --no-merges git-p4.py"
>      may help.
>
>  (3) Follow the style of existing commits when giving a title to
>      your patch.
>
>      "git shortlog --since=18.months --no-merges git-p4.py" may
>      help you notice "git-p4: do this thing" is the common way to
>      title "git p4" patches.
>
>  (4) Justify why your change is a good thing in your log message.
>      What you did, i.e. "list p4 jobs when making a commit", can be
>      seen by the patch, but readers cannot guess why you thought it
>      is a good idea to extract "job%d" out of the P4 commit and to
>      record them in the resulting Git commit, unless you explain
>      things like:
>
>      - what goes wrong if you don't?
>      - when would "job%d" appear in P4 commit?
>      - is it sane to assume "job0", "job1",... appear consecutively?
>
>  (5) Describe what your change does clearly.  "Adding list" is not
>      quite clear.  Where in the "git commit message" are you adding
>      the list, and why is that location in the message the most
>      appropriate place to add it?

Additionally, it would be very useful to add a test case (see t/t98*).
There are quite a few test cases for git-p4, and they make maintenance
a lot easier.

Some documentation (Documentation/git-p4.txt) would also be useful.

Thanks
Luke
