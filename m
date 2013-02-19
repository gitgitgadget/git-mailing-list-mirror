From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 4/4] Documentation/git-commit.txt: correct a few minor
 grammatical mistakes
Date: Mon, 18 Feb 2013 23:18:46 -0800
Message-ID: <CA+sFfMf8juf0rQh6S2sW=_LmsbhPc=c+erVppsZbAw-+h-4CqQ@mail.gmail.com>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
	<1361247427-438-4-git-send-email-drafnel@gmail.com>
	<20130219064304.GG19757@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7hTu-0002xM-KI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 08:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab3BSHSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 02:18:49 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58406 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3BSHSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 02:18:48 -0500
Received: by mail-wi0-f172.google.com with SMTP id ez12so4413817wid.11
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vk6BQP+IEJXp07ZxLi4cK6atVQoaXX8c+mOp+ElWxr4=;
        b=Ck4xruHi22yVnz8NlSHOL0u5zhqtKMcWgp9tojWLccoWhIdCiN5RthD9kuTvZp+nAx
         CxWzyXWEU12CvlZUdMkYCU4JI76ltEWhYvLbRCVR3GSn6ZMaw90kG00iSIl06CVEdui/
         KwpXRi2Sj1m/B5z3aL6Ckq0cMmZwb+YKLXsmSrcYN3cDl4ksAbrsNlCQEozymWSCDBPf
         PEd9n4/+4S9WR+gN/f4RNx0DWvB8hC0T7IqJl93gVi4MJZeDbe/dnpa7NG4bGLgxZL2z
         MxUjqwzSrVGVuthIYG4wcOtuZ0ZPwltFQxH7Y/f3tsD6pqvF/AfK5yICEZRn0d30PXbU
         o/+w==
X-Received: by 10.180.105.67 with SMTP id gk3mr23056480wib.31.1361258326747;
 Mon, 18 Feb 2013 23:18:46 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Mon, 18 Feb 2013 23:18:46 -0800 (PST)
In-Reply-To: <20130219064304.GG19757@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216568>

On Mon, Feb 18, 2013 at 10:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:
>
>> --- a/Documentation/git-commit.txt
>> +++ b/Documentation/git-commit.txt
>> @@ -174,10 +174,10 @@ OPTIONS
>>  --cleanup=<mode>::
>>       This option sets how the commit message is cleaned up.
>>       The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
>> -     and 'default'. The 'default' mode will strip leading and
>> +     or 'default'. The 'default' mode will strip leading and
>>       trailing empty lines and #commentary from the commit message
>> -     only if the message is to be edited. Otherwise only whitespace
>> -     removed. The 'verbatim' mode does not change message at all,
>> +     only if the message is to be edited. Otherwise only whitespace is
>> +     removed. The 'verbatim' mode does not change the message at all,
>>       'whitespace' removes just leading/trailing whitespace lines
>>       and 'strip' removes both whitespace and commentary. The default
>>       can be changed by the 'commit.cleanup' configuration variable
>
> Yeah, the current text is a bit choppy.  How about this?

Hmm, I think the original text was more confusing than I realized.  I
think we should reorder the cleanup modes, placing "default" last, and
then describe default in terms of either strip or whitespace depending
on whether an editor will be spawned.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> --- i/Documentation/git-commit.txt
> +++ w/Documentation/git-commit.txt
> @@ -172,16 +172,25 @@ OPTIONS
>         linkgit:git-commit-tree[1].
>
>  --cleanup=<mode>::
> -       This option sets how the commit message is cleaned up.
> -       The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
> -       and 'default'. The 'default' mode will strip leading and
> -       trailing empty lines and #commentary from the commit message
> -       only if the message is to be edited. Otherwise only whitespace
> -       removed. The 'verbatim' mode does not change message at all,
> -       'whitespace' removes just leading/trailing whitespace lines
> -       and 'strip' removes both whitespace and commentary. The default
> -       can be changed by the 'commit.cleanup' configuration variable
> -       (see linkgit:git-config[1]).
> +       This option determines how the supplied commit message should be
> +       cleaned up before committing. The '<mode>' can be `verbatim`,
> +       `whitespace`, `strip`, or `default`.
> ++
> +--
> +default::
> +       Strip leading and trailing empty lines and #commentary from
> +       the commit message only if the message is to be edited.
> +       Otherwise only remove whitespace.
> +verbatim::
> +       Do not change the message at all.
> +whitespace::
> +       Remove only leading and trailing whitespace lines.
> +strip::
> +       Remove both whitespace and commentary.

Let's reorder these.  Maybe something like this:

+strip::
+       Strip leading and trailing empty lines, trailing whitespace
and #commentary and
+       collapse consecutive blank lines into one.
+whitespace::
+       Same as "strip" except #commentary is not removed.
+verbatim::
+       Do not change the message at all.
+default::
+       "strip" if the message is to be edited.  Otherwise "whitespace".

> +--
> ++
> +The default can be changed using the 'commit.cleanup' configuration
> +variable (see linkgit:git-config[1]).
>
>  -e::
>  --edit::

-Brandon
