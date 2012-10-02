From: David Glasser <glasser@davidglasser.net>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 2 Oct 2012 12:00:48 -0700
Message-ID: <CAN7QDoLD+igYqVCgtKQsnW7f1Ntpk-RyaP8cn24cBrMjOO6NEg@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
 <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com> <7vbogk90zk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:02:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7ik-0006gJ-HP
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab2JBTBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:01:13 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59652 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab2JBTBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:01:09 -0400
Received: by oagh16 with SMTP id h16so6600187oag.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=7G9pl1CWO7w4aDOW6IfierhWwNHBEYUdR9Ep8JzWEcI=;
        b=yde2fuU5PPmqxciSAeF+jmUKp0d2qS/dLexHd2tRM1TMM8OOEhgHJ3TfTSZQFJt1S5
         AGLptFAibAUC49NZ2d/eRxZTh6ksayGildgW/jZl+7TC4j3oOzH/MJPE5+H1d/n460PT
         EK3AR5+fF2IVHdFORh+Z/O3JOZ1N9lLzEEk6grrXi1sNKKm41kSEr/q3CVg/vadtqhHW
         I3ClfECZSXA5Y+dH8UydBx5KdaOT1R0aPE3xo7JGxxZQr88875PbsUtOTrTV3/9RgiPL
         qszjFDlSw4HRPMrgZSV0BDfqBw7ypDCYtN6VxPYx8OTVhPt4w7/NPP/Dr2BlXLaDvxhM
         79Iw==
Received: by 10.60.29.230 with SMTP id n6mr15255120oeh.123.1349204468366; Tue,
 02 Oct 2012 12:01:08 -0700 (PDT)
Received: by 10.60.4.164 with HTTP; Tue, 2 Oct 2012 12:00:48 -0700 (PDT)
In-Reply-To: <7vbogk90zk.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Jv0ssq96kjeKdubXEO7Ptui5SRY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206833>

Thanks Junio! Note that I think the word is usually spelled
"controlled" not "controled".

On Tue, Oct 2, 2012 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> David Glasser wrote:
>>> Thanks Rankumar! There's also the reference in the "git push origin"
>>> example and the "This is the default operation mode if no explicit
>>> refspec is found".
>>
>> Sorry;  here's a revised patch.
>>
>> --8<--
>
> FYI: the above is not a scissors line.
>
>> From: Ramkumar Ramachandra <artagnon@gmail.com>
>> Date: Tue, 2 Oct 2012 21:06:05 +0530
>> Subject: [PATCH] Documentation: mention `push.default` in git-push.txt
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Documentation/git-push.txt | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index cb97cc1..e1e9aca 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -37,7 +37,8 @@ OPTIONS[[OPTIONS]]
>>         `+`, followed by the source ref <src>, followed
>>         by a colon `:`, followed by the destination ref <dst>.
>>         It is used to specify with what <src> object the <dst> ref
>> -       in the remote repository is to be updated.
>> +       in the remote repository is to be updated.  If not specified,
>> +       the configuration variable `push.default` is used.
>
> I think this is way suboptimal; it is begging users to do this
>
>         [push]
>                 default = frotz:xyzzy
>
> by making it sound as if push.default gives a default for <refs>.
>
>> @@ -65,7 +66,8 @@ directs git to push "matching" branches: for every
>> branch that
>>  the local side, the remote side is updated if a branch of the same name
>>  already exists on the remote side.  This is the default operation mode
>>  if no explicit refspec is found (that is neither on the command line
>> -nor in any Push line of the corresponding remotes file---see below).
>> +nor in any Push line of the corresponding remotes file, or `push.default`
>> +---see below).
>
> Likewise.  The added part should not be inside the parentheses,
> which is about what the value used for refspec.  `push.default` is
> about what happens when there is _no_ refspec.
>
> I'll queue this instead.  Thanks.
>
> -- >8 --
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Tue, 2 Oct 2012 21:08:00 +0530
> Subject: [PATCH] Documentation: mention `push.default` in git-push.txt
>
> It already is listed in the "git config" documentation, but people
> interested in pushing would first look at "git push" documentation.
>
> Noticed-by: David Glasser
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Acked-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Fixed-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-push.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index cb97cc1..70b18bc 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -37,7 +37,9 @@ OPTIONS[[OPTIONS]]
>         `+`, followed by the source ref <src>, followed
>         by a colon `:`, followed by the destination ref <dst>.
>         It is used to specify with what <src> object the <dst> ref
> -       in the remote repository is to be updated.
> +       in the remote repository is to be updated.  If not specified,
> +       the behavior of the command is controled by the `push.default`
> +       configuration variable.
>  +
>  The <src> is often the name of the branch you would want to push, but
>  it can be any arbitrary "SHA-1 expression", such as `master~4` or
> @@ -65,7 +67,8 @@ directs git to push "matching" branches: for every branch that exists on
>  the local side, the remote side is updated if a branch of the same name
>  already exists on the remote side.  This is the default operation mode
>  if no explicit refspec is found (that is neither on the command line
> -nor in any Push line of the corresponding remotes file---see below).
> +nor in any Push line of the corresponding remotes file---see below) and
> +no `push.default` configuration variable is set.
>
>  --all::
>         Instead of naming each ref to push, specifies that all
> @@ -357,7 +360,8 @@ Examples
>         `git push origin :`.
>  +
>  The default behavior of this command when no <refspec> is given can be
> -configured by setting the `push` option of the remote.
> +configured by setting the `push` option of the remote, or the `push.default`
> +configuration variable.
>  +
>  For example, to default to pushing only the current branch to `origin`
>  use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
> --
> 1.8.0.rc0.45.g7ce8dc5
>



-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
