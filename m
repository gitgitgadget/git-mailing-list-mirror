From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 10:48:32 +0200
Message-ID: <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local> <1398670610456-7608792.post@n2.nabble.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@gmail.com>, Nick Hengeveld <nickh@reactrix.com>
X-From: msysgit+bncBDR53PPJ7YHRBCFM7CNAKGQEJ4W6CEI@googlegroups.com Mon Apr 28 10:49:16 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBCFM7CNAKGQEJ4W6CEI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f185.google.com ([209.85.220.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBCFM7CNAKGQEJ4W6CEI@googlegroups.com>)
	id 1WehFS-0003VJ-4I
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 10:49:14 +0200
Received: by mail-vc0-f185.google.com with SMTP id lg15sf1470583vcb.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=UakDPW1lyHurkRSQ0t1edLIWcJsF24HHvrHmM4uHRWk=;
        b=ESzo4CWY/Q2BP/ttoIrjosrhLEcm7TaCrpYJu28oskXTvo5vYJIEZqU35uPuRAA9On
         tc6l80ckyZVtmlPnLXbYYTFnwTocJtDJqXnKbH9TVme6MOELi0lfl/vTOGvFI3BUhZId
         j1BUrJPWQEPXyyvC5TkS+Mz8vdegP7CdsaZ8/6wiHD+Z/3Rh07lYnsO0GINWDbNNk/+/
         Ak1rGSAZ99Nq/+Dndz7sLkQAWEBDfVgle5d/Kwoq6unSvFnooBRrlADnkRVzazmJdwxC
         vDCu57yFb2GybJ+cpuW/6Zj1PG1ILaErsjliryjCa8b14z4muGNqUTv9tuwsZ7KPfIgS
         H+bg==
X-Received: by 10.182.243.227 with SMTP id xb3mr29287obc.17.1398674953335;
        Mon, 28 Apr 2014 01:49:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.138.8 with SMTP id qm8ls1098891obb.23.gmail; Mon, 28 Apr
 2014 01:49:12 -0700 (PDT)
X-Received: by 10.182.33.161 with SMTP id s1mr12662061obi.12.1398674952395;
        Mon, 28 Apr 2014 01:49:12 -0700 (PDT)
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com [2607:f8b0:4001:c05::22b])
        by gmr-mx.google.com with ESMTPS id 6si1938326igs.1.2014.04.28.01.49.12
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 01:49:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22b as permitted sender) client-ip=2607:f8b0:4001:c05::22b;
Received: by mail-ig0-x22b.google.com with SMTP id c1so4492517igq.4
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 01:49:12 -0700 (PDT)
X-Received: by 10.43.90.202 with SMTP id bj10mr21189895icc.48.1398674952295;
 Mon, 28 Apr 2014 01:49:12 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 01:48:32 -0700 (PDT)
In-Reply-To: <1398670610456-7608792.post@n2.nabble.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247247>

On Mon, Apr 28, 2014 at 9:36 AM, Marat Radchenko <marat@slonopotamus.org> wrote:
> Silvola Tuomas wrote
>> Hello,
>>
>> I installed git for windows 1.9.0 but any push operation I tried with it
>> produced an error message saying "git: 'http-push' is not a git command".
>> Other commands like pull, add, and commit worked just fine.
>> At the end of this day I noticed that C:\Program Files
>> (x86)\Git\libexec\git-core just didn't have the file git-http-push. There
>> were git-http-backend, git-http-fetch and git-imap-send and such but no
>> git-http-push.
>>
>> I resolved my issue by uninstalling 1.9.0, installing an older version
>> instead (1.8.1.2; this is when push started working) and 1.9.0 right on
>> top of the older version. Now git push command works as expected.
>>
>> Br,
>> Tuomas Silvola
>
> From Makefile:
>
>         curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null |
> sort -r | sed -ne 2p)
>         ifeq "$(curl_check)" "070908"
>                 ifndef NO_EXPAT
>                         PROGRAM_OBJS += http-push.o
>                 endif
>         endif
>
> if there's no curl-config, http-push.c is silently skipped. This check also
> doesn't play with cross-compiling when you cannot call curl-config because
> it is for other arch.
>
> There's also a mystic git-http-push$X that is not referenced from anywhere.

We're using Curl 7.30.0 in msysGit (and thus also Git for Windows), so
we should be able to include it. However, we do not have curl-config
installed.

Looking at 08900987 ("Decide whether to build http-push in the
Makefile"), that commit is from 2005, so it seems we've broken
something.

Further, looking a bit at our curl build-script, we don't seem to to
install curl-config. HOWEVER, 37e42ab ("curl: update to 7.28.1 and
enable ipv6"), dated 1. Feb 2013 adds a function to remove
curl-config. Pat, why is this?

My knee-jerk suspicion would be that it's because it's a stale
curl-config from a previous install (that *did* install it). However,
it doesn't seem like the mingw32 Makefile (the one you get without
running configure, it seems) even tries to build curl-config. In fact,
it seems this is simply built by configure itself. Which we don't run,
again since 37e42ab ("curl: update to 7.28.1 and enable ipv6").

So it seems that 08900987 ("Decide whether to build http-push in the
Makefile") makes a bad assumption about the availability of
curl-config on new libcurl installations; it's not present on "stock"
Windows builds.

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
