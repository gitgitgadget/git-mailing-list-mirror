From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 10:55:23 -0700
Message-ID: <xmqqsilzq390.fsf@gitster.dls.corp.google.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  Karsten Blees <karsten.blees@gmail.com>,  msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBFU4UCPAKGQERBOPKSQ@googlegroups.com Thu Jul 17 19:55:36 2014
Return-path: <msysgit+bncBCG77UMM3EJRBFU4UCPAKGQERBOPKSQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f188.google.com ([209.85.216.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBFU4UCPAKGQERBOPKSQ@googlegroups.com>)
	id 1X7pu3-0007jU-KN
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 19:55:35 +0200
Received: by mail-qc0-f188.google.com with SMTP id r5sf775146qcx.15
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=qkRXqa//GOnhuAYPkr7y9z6P7YrSdI8iXhs5DOFnIIk=;
        b=UndP4G3w9WJUuOkJkUb9GEhCacECRsuYpaK6QwHSUGHU+DEYgHwbxcRKzJrUBrdsuN
         WIuL3xmw/vx8JiPJI3BS01gptmXVD7mRLuJ3vVoHDdhoFCgFNCysA7pH12LyLvsIkNT/
         had+Bb5Nj+4TWgpobiioeZfMYRilYYEEG4HjFB65Z3bKOQKvlA0AEzQSQESjm8zOJYAV
         zY+VutfKBNZVBkHDreJ6R/Heo3/39oF2Dh/gGrcZs/Na5NpHG6Or6TuWwQwg9iyrwFFK
         GWf4Yhed2m+LymGx/9T1etfw9SQb2Uuo+o952Syl1QL00Vsxub2UBOpAfyS2eZ5aJ+ll
         HVKg==
X-Received: by 10.50.18.105 with SMTP id v9mr530035igd.17.1405619734848;
        Thu, 17 Jul 2014 10:55:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.16.5 with SMTP id fs5ls3589044igd.8.canary; Thu, 17 Jul
 2014 10:55:33 -0700 (PDT)
X-Received: by 10.42.27.18 with SMTP id h18mr18995217icc.25.1405619733759;
        Thu, 17 Jul 2014 10:55:33 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id o69si342830yhp.6.2014.07.17.10.55.33
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 10:55:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 620712AA23;
	Thu, 17 Jul 2014 13:55:33 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 555642AA22;
	Thu, 17 Jul 2014 13:55:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4AF82AA12;
	Thu, 17 Jul 2014 13:55:24 -0400 (EDT)
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz> (Stepan Kasal's
	message of "Thu, 17 Jul 2014 17:37:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 874C1890-0DDB-11E4-A4C1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253763>

Stepan Kasal <kasal@ucw.cz> writes:

> ... only one patch
> would only remain: gitk and git-gui fixes.)

Nice.

Will queue.

> When rebasing Karsten's work, I have eliminated two commits:
> https://github.com/msysgit/git/commit/f967550
> https://github.com/msysgit/git/commit/290bf81
>
> These commits only moved code down and up; this was not necessary, one
> forward declaration was all I needed.
>
> One of the patches differs from the original version: "Enable color..."
> Following Karsten's suggestion, I have changed the value of env. var.
> TERM from "winterm" to "cygwin".  This is because the subprocesses see
> the variable and may try to find it in (their copy of) termcap.
>
> Enjoy,
>    Stepan
>
> Karsten Blees (13):
>   Revert "Windows: teach getenv to do a case-sensitive search"
>   Win32: Unicode environment (outgoing)
>   Win32: Unicode environment (incoming)
>   Win32: fix environment memory leaks
>   Win32: unify environment case-sensitivity
>   Win32: unify environment function names
>   Win32: factor out environment block creation
>   Win32: don't copy the environment twice when spawning child processes
>   Win32: reduce environment array reallocations
>   Win32: use low-level memory allocation during initialization
>   Win32: keep the environment sorted
>   Win32: patch Windows environment on startup
>   Enable color output in Windows cmd.exe
>
>  compat/mingw.c   | 290 +++++++++++++++++++++++++++++++------------------------
>  compat/mingw.h   |  11 +--
>  config.mak.uname |   2 -
>  run-command.c    |  10 +-
>  4 files changed, 170 insertions(+), 143 deletions(-)
>
> -- 
> 2.0.0.9635.g0be03cb
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
