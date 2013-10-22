From: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
Subject: Re: Moving commits from one branch to another (improving my git fu!)
Date: Tue, 22 Oct 2013 18:21:59 +0530
Message-ID: <CAC+QLdS-DFdQpkhFZ4ZTV_zLk0gst3FgNd+EFcX=8Qgpf2ZdOg@mail.gmail.com>
References: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
	<87d2mx1nq1.fsf@sanitarium.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Noufal Ibrahim <noufal@nibrahim.net.in>
X-From: git-owner@vger.kernel.org Tue Oct 22 14:52:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYbRP-0007Nw-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 14:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3JVMwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 08:52:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58487 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab3JVMwA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 08:52:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id un1so2000224pbc.19
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uep1hSdbNSOUb6XqlUWmiGU3yka6oWUSClX7tMh/O0E=;
        b=sPt0m2SktNNFOGIgb6tLdEW0a3rrlWf277iMWi3qo2PEA5L/okzgBXyl/0AcQ9t3f2
         r8enxEqYU/zzuOnDWYr5y+ylHONcKNZopKbCnTfp6Y/ipJ0oZpFsJ0jG3dG85LZ1hXB9
         Nj7erKC/ULyR2KZ0aNawtBeEEfVDUp7sFv5TLsWZ7uqad0IPM7ZEf0aAU1WcBPj4GtiY
         0+q3dkPzf4vjoEdkFjGMsgbXvVZf7I9vSiSgvUQQ+OM1ybv+xVicuFExEoc78jpHuj23
         D7WIlc9uOfwHZZsXRgGpvXSKSoE5rxKWaNXglt47KoXfNfB39SkJSD2vm4ZtQHrHPPpn
         KKSA==
X-Received: by 10.68.254.132 with SMTP id ai4mr22744864pbd.51.1382446319677;
 Tue, 22 Oct 2013 05:51:59 -0700 (PDT)
Received: by 10.66.165.233 with HTTP; Tue, 22 Oct 2013 05:51:59 -0700 (PDT)
In-Reply-To: <87d2mx1nq1.fsf@sanitarium.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236466>

Thanks for the link.

I too tried doing a rebase with --onto, though as I said, I was
getting a lot of conflicts while doing it.

So cherry-picking my 2 commits was the solution that worked. I had
also screwed up my topic branch by doing different combo's of this cmd
and using --set-upstream-to option to point to 'dev' on a branch that
was branched off from 'stable'! :)

Lesson learned. I'll be careful when doing branching next time :)

-mandeep



On Tue, Oct 22, 2013 at 6:12 PM, Noufal Ibrahim <noufal@nibrahim.net.in> wrote:
> Mandeep Sandhu <mandeepsandhu.chd@gmail.com> writes:
>
>> Hi All,
>>
>> I'm in a bit of a pickle! :) So I've come to ask for help from the guru's here.
>>
>> My story is not unique but somehow the various suggested solutions
>> don't seem to work in my case.
>>
>> * I was working on a feature which was supposed to be done off our
>> 'dev' branch. But instead I forgot and branched out my topic branch
>> from master (or as we call it 'stable').
>> * I did 2 commits and finished off my work. Only later realizing that
>> it had to be done off 'dev'.
>> * Now I want to move my 2 commits (which are the top 2 commits on my
>> topic branch) to a new branch which is branched off 'dev'.
>
> I had a situtation similar to this a while ago and used the --onto
> option to rebase. The details are at
> http://nibrahim.net.in/2012/01/09/moving_topic_branches_in_git.html
>
> [...]
>
>
> --
> Cordially,
> Noufal
> http://nibrahim.net.in
