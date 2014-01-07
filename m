From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Fwd: static initializers
Date: Tue, 7 Jan 2014 01:19:32 +0100
Message-ID: <CABPQNSY+xivBoARCP4UbugQk_C4Uv9hWH2_K7AJw_uor0K33Cg@mail.gmail.com>
References: <CAHOQ7J8vQ-t1knSiWQ+RKv3QvwW2DZBy29DBhkxu7tEeXoJ-CA@mail.gmail.com>
 <CAHOQ7J-UKvG2j2PZJqhJP=5YLniHpELtOTzF5i1WsiGkhzZHhw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: Stefan Zager <szager@google.com>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBDR53PPJ7YHRBPEQVWLAKGQEYPWF4NI@googlegroups.com Tue Jan 07 01:20:15 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBPEQVWLAKGQEYPWF4NI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f59.google.com ([209.85.219.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBPEQVWLAKGQEYPWF4NI@googlegroups.com>)
	id 1W0KP0-0004ni-Pm
	for gcvm-msysgit@m.gmane.org; Tue, 07 Jan 2014 01:20:14 +0100
Received: by mail-oa0-f59.google.com with SMTP id g12sf991420oah.24
        for <gcvm-msysgit@m.gmane.org>; Mon, 06 Jan 2014 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=uDp1VMkmZg0gyxh3EhNgoYO8gaDVFx6w992erkdlY8g=;
        b=FHpya7NDJo+sGv691Upe0d4R0wU8I5z6VGBOKk6uLZsUhdE4x2SPVpUzNemaveNek1
         P3CpixSMp69jCY11j2k8JNF8Dd5EMbUZpYqgLipAmQv0wU72HRF14foiF2u2MnoxnSu3
         GGN4ZznbH9DkG9GvDba3kc9TQXGrmcHvcb4c4DwExgAdNjmqU3fDpCNpCgnqfmBT9kjC
         c11xA+cN6DCegCmj/R2nDzQsXLFNKMe48CkraznyGc1We2wMwXaRgEBCN1rp97zSLx8I
         RZXp1uNz12a0gL4BSO1/MddP7DUmxweidMfQR12SOjkgJ47KYL0b0hIqUJTGXHjcDBGV
         7OUQ==
X-Received: by 10.49.49.232 with SMTP id x8mr265350qen.13.1389054013725;
        Mon, 06 Jan 2014 16:20:13 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.85.129 with SMTP id h1ls5985114qez.15.gmail; Mon, 06 Jan
 2014 16:20:12 -0800 (PST)
X-Received: by 10.52.159.99 with SMTP id xb3mr40042511vdb.4.1389054012864;
        Mon, 06 Jan 2014 16:20:12 -0800 (PST)
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com [2607:f8b0:4001:c05::22a])
        by gmr-mx.google.com with ESMTPS id d9si4566802yhl.2.2014.01.06.16.20.12
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 16:20:12 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a as permitted sender) client-ip=2607:f8b0:4001:c05::22a;
Received: by mail-ig0-f170.google.com with SMTP id k19so8746133igc.1
        for <msysgit@googlegroups.com>; Mon, 06 Jan 2014 16:20:12 -0800 (PST)
X-Received: by 10.42.24.210 with SMTP id x18mr61200948icb.38.1389054012429;
 Mon, 06 Jan 2014 16:20:12 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Mon, 6 Jan 2014 16:19:32 -0800 (PST)
In-Reply-To: <CAHOQ7J-UKvG2j2PZJqhJP=5YLniHpELtOTzF5i1WsiGkhzZHhw@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240089>

On Mon, Jan 6, 2014 at 11:05 PM, Stefan Zager <szager@google.com> wrote:
> Forwarding to msysgit for any guidance about win equivalents for
> PTHREAD_MUTEX_INITIALIZER or __attribute__((constructor)).

As you've probably already guessed, PTHREAD_MUTEX_INITIALIZER isn't
supported in our pthreads-emulator. I did send out a patch adding
support for it a while ago, but it hasn't been heavily tested.

__attribute__((constructor)) doesn't work on MSVC, which we also build with.

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
For more options, visit https://groups.google.com/groups/opt_out.
