From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Second part of msysgit/unicode
Date: Wed, 18 Jun 2014 10:33:09 -0700
Message-ID: <xmqq7g4ejf6y.fsf@gitster.dls.corp.google.com>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
	<53A0052C.6040604@gmail.com> <20140618030507.GA3809@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBXE2Q6OQKGQEJAMQ7RA@googlegroups.com Wed Jun 18 19:33:19 2014
Return-path: <msysgit+bncBCG77UMM3EJRBXE2Q6OQKGQEJAMQ7RA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f187.google.com ([209.85.220.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBXE2Q6OQKGQEJAMQ7RA@googlegroups.com>)
	id 1WxJja-0000cX-Dy
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 19:33:18 +0200
Received: by mail-vc0-f187.google.com with SMTP id im17sf281715vcb.4
        for <gcvm-msysgit@m.gmane.org>; Wed, 18 Jun 2014 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=jDBgRev9FkRpj3z9/tGDFsOSyZXccUU8bbS7NWEgNnA=;
        b=IpZtiOI/Cu09ktKg7d3jpv2u226loFcEh3RKYYb8VUO6CMpbC9kbMKgUXRT1T6cV4W
         LpKQd3TvyG81hyHRQPuKaVo1iUARdlxDghCcfoPbc8kaYMISwgQLI/RzqgaSqEQGWK5k
         bST+5CyMCVMrb0hki/GSrjLqf8iQMIDY0I8GwIp6FsOf9Wt+jesbrJAc7xBC6zdz3DYb
         o6TDP8B7wHQrNPqxnvqGdixLgpSpewBL0L6utOpm+hHatgbdgogINSDoz9eyxgL2/T/0
         JiIaN3p+f581pZSu/mfiseVhhrJhvR7/L0qyG6VxtMcFqtU7IKfVohC8xZGS5/wpth3c
         HF/A==
X-Received: by 10.182.176.99 with SMTP id ch3mr16395obc.38.1403112797498;
        Wed, 18 Jun 2014 10:33:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.81.170 with SMTP id b10ls71444oby.2.gmail; Wed, 18 Jun
 2014 10:33:16 -0700 (PDT)
X-Received: by 10.182.128.234 with SMTP id nr10mr1464236obb.0.1403112796380;
        Wed, 18 Jun 2014 10:33:16 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id y50si177877yhk.4.2014.06.18.10.33.16
        for <msysgit@googlegroups.com>;
        Wed, 18 Jun 2014 10:33:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B981E1E2F6;
	Wed, 18 Jun 2014 13:33:13 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78D961E2F4;
	Wed, 18 Jun 2014 13:33:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D47E01E2F0;
	Wed, 18 Jun 2014 13:33:08 -0400 (EDT)
In-Reply-To: <20140618030507.GA3809@camelia.ucw.cz> (Stepan Kasal's message of
	"Wed, 18 Jun 2014 05:05:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D1D90F6-F70E-11E3-8CEC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252016>

Stepan Kasal <kasal@ucw.cz> writes:

> Hello Karsten,
>
> On Tue, Jun 17, 2014 at 11:06:52AM +0200, Karsten Blees wrote:
>> Am 11.06.2014 11:37, schrieb Stepan Kasal:
>> > This is the second part of the time-proven unicode suport branch from msysgit.
>> > This batch is a collection of small independent changes, limited to mingw.c.
>> > The only exception is the last patch: it changes gitk and git-gui.
>> 
>> I'm missing the other two "Unicode file name" patches (and "Win32: fix detection
>
> indeed.  I noticed that after sending the plan quoted above.
> Luckily, the gitk/git-gui patch was not accepted and has to be
> resubmitted.
>
> So the plan for future submissions is:
>
> 1) two "Unicode file name" patches (with "fix... is_dir_empty"
> squashed)
> 2) the environament patches from your unicode branch (several
> patches)
> 3) "color term" (and env. var. TERM); updated according to your
> instructions, thus sent separately after the series
> 4) resubmit gitk / git-gui (have separate maintainers)
>
> This is work in progress, I suppose to mail 1) and 2) in a few days.
>
> Stepan

In the meantime, are Windows folks happy with the four topics queued
on 'pu' so far?  I would like to start moving them down to 'next'
and to 'master' soonish.

They consist of these individual patches:

    $ git shortlog ^master \
      sk/mingw-dirent \
      sk/mingw-main \
      sk/mingw-uni-console \
      sk/mingw-unicode-spawn-args
    Johannes Schindelin (1):
          Win32: let mingw_execve() return an int

    Karsten Blees (18):
          Win32 dirent: remove unused dirent.d_ino member
          Win32 dirent: remove unused dirent.d_reclen member
          Win32 dirent: change FILENAME_MAX to MAX_PATH
          Win32 dirent: clarify #include directives
          Win32 dirent: improve dirent implementation
          Win32: move main macro to a function
          Win32: support Unicode console output
          Win32: detect console streams more reliably
          Win32: warn if the console font doesn't support Unicode
          Win32: add Unicode conversion functions
          Win32: Thread-safe windows console output
          Win32: fix broken pipe detection
          Win32: reliably detect console pipe handles
          Win32: simplify internal mingw_spawn* APIs
          Win32: fix potential multi-threading issue
          MinGW: disable CRT command line globbing
          Win32: Unicode arguments (outgoing)
          Win32: Unicode arguments (incoming)

    Stepan Kasal (1):
          mingw: avoid const warning

Thanks.

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
