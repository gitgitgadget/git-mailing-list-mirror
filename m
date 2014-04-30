From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Wed, 30 Apr 2014 17:53:29 +0200
Message-ID: <CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com> <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Borowitz <dborowitz@google.com>, GIT Mailing-list <git@vger.kernel.org>, 
	Pat Thoyts <patthoyts@gmail.com>, Marat Radchenko <marat@slonopotamus.org>, tuomas.silvola@knowit.fi, 
	msysGit <msysgit@googlegroups.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBINZQSNQKGQEMJSUEKQ@googlegroups.com Wed Apr 30 17:54:15 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBINZQSNQKGQEMJSUEKQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBINZQSNQKGQEMJSUEKQ@googlegroups.com>)
	id 1WfWpn-0002Uy-3X
	for gcvm-msysgit@m.gmane.org; Wed, 30 Apr 2014 17:54:11 +0200
Received: by mail-ob0-f186.google.com with SMTP id wo20sf434274obc.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=DMp0F7SpivIcehLRxJPiyw+XluXP0iM0bWLgiE62AdI=;
        b=BjKzcOpt9C3XNaFATUud/aDU+ltdvap0RIH4aA2J5EA+5eEkG0ZSNOosYw3HOaFFmQ
         3TIrt5+sFcGV7u284Bqmobh3eoeBX96gVKSOqp1L/H+SIjshjmkszGhuF01SccXBYJL7
         1qruoqSpE7ACg3CJUkdDOLg1NLhKRMUTjebUCyVG/kVnIUQ5SHXyepD5gcGho1IEaj3d
         6qcrzU1U+rlp2vdgZKLkuHHWb6zMBOo/yREMIrfSqWsKzDVcUwRpdFrz5UA4ImxrtENu
         WikYJdmyO+aR4CLbzwzrX7Pi2/oZ2xBloCVbEbgRmAGgTtVRdcV2xdpGp5nL5mp0L5zS
         2OgA==
X-Received: by 10.182.24.1 with SMTP id q1mr36888obf.4.1398873250197;
        Wed, 30 Apr 2014 08:54:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.65.231 with SMTP id a7ls317132obt.30.gmail; Wed, 30 Apr
 2014 08:54:09 -0700 (PDT)
X-Received: by 10.182.60.37 with SMTP id e5mr2770671obr.30.1398873249273;
        Wed, 30 Apr 2014 08:54:09 -0700 (PDT)
Received: from mail-ig0-x22e.google.com (mail-ig0-x22e.google.com [2607:f8b0:4001:c05::22e])
        by gmr-mx.google.com with ESMTPS id u5si577598ige.1.2014.04.30.08.54.09
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 08:54:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22e as permitted sender) client-ip=2607:f8b0:4001:c05::22e;
Received: by mail-ig0-x22e.google.com with SMTP id h18so7774349igc.1
        for <msysgit@googlegroups.com>; Wed, 30 Apr 2014 08:54:09 -0700 (PDT)
X-Received: by 10.50.85.37 with SMTP id e5mr5583565igz.43.1398873249128; Wed,
 30 Apr 2014 08:54:09 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 08:53:29 -0700 (PDT)
In-Reply-To: <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22e
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247724>

On Wed, Apr 30, 2014 at 5:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> MinGW builds of cURL does not ship with curl-config unless built
>> with the autoconf based build system, which is not the practice
>> recommended by the documentation. MsysGit has had issues with
>> binaries of that sort, so it has switched away from autoconf-based
>> cURL-builds.
>>
>> Unfortunately, broke pushing over WebDAV on Windows, because
>> http-push.c depends on cURL's multi-threaded API, which we could
>> not determine the presence of any more.
>>
>> Since troublesome curl-versions are ancient, and not even present
>> in RedHat 5, let's just assume cURL is capable instead of doing a
>> non-robust check.
>>
>> Instead, add a check for curl_multi_init to our configure-script,
>> for those on ancient system. They probably already need to do the
>> configure-dance anyway.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> OK, here's a proper patch. I've even tested it! ;)
>>
>>
>>  Makefile     |  8 +++-----
>>  configure.ac | 11 +++++++++++
>>  2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index e90f57e..f6b5847 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1133,13 +1133,11 @@ else
>>       REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>>       PROGRAM_OBJS += http-fetch.o
>>       PROGRAMS += $(REMOTE_CURL_NAMES)
>> -     curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
>> -     ifeq "$(curl_check)" "070908"
>> -             ifndef NO_EXPAT
>> +     ifndef NO_EXPAT
>> +             ifndef NO_CURL_MULTI
>>                       PROGRAM_OBJS += http-push.o
>>               endif
>
> Dave's "ask curl-config about proper compilation options if
> available" and this change does *not* semantically conflict, as the
> former should stress "if available" part (but note that the key word
> is "should").
>
> How old/battle tested is this change?

Not very. I've successfully tested it on two systems, msysGit and RedHat 5.

> My inclination at this point
> is to revert the merge of Dave's series from 2.0 (yes, I know we
> have been looking at fixing it and I _think_ the issue of unpleasant
> error message you reported can be fixed, but at this rate we would
> not know if we eradicated all the issues for platforms and distros
> with confidence by the final), kick it back to 'next'/'pu', and
> queue this change also in 'next'/'pu' and cook them so that we can
> merge them early in the 2.1 cycle.

Sounds like a sensible plan to me. We can keep this patch in the
msysGit repo for the 2.0 release.

> This new makefile variable needs a comment at the top, no?
>
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index f7d33da..3164b62 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -34,6 +34,10 @@ all::
>  # git-http-push are not built, and you cannot use http:// and https://
>  # transports (neither smart nor dumb).
>  #
> +# Define NO_CURL_MULTI if your libcurl is sufficiently old and lacks
> +# curl_multi_init ("git http-push" to run the deprecated dumb push over
> +# http/webdab will not be built).
> +#
>  # Define CURL_CONFIG to the path to a curl-config binary other than the
>  # default 'curl-config'.  If CURL_CONFIG is unset or points to a binary that
>  # is not found, defaults to the CURLDIR behavior.

Ah yes. Sorry for missing that. Perhaps the text should even mention
the old break-off version, that is curl > v7.9.8 as far as I can
tell...?

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
