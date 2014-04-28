From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 15:12:13 +0200
Message-ID: <CABPQNSbPkF20h4Bu6Xi_f6tGvQVh9AReZEYzXn2R=79PSJTdVg@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBVNH7GNAKGQETZFCTNQ@googlegroups.com Mon Apr 28 15:12:56 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBVNH7GNAKGQETZFCTNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f192.google.com ([209.85.192.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBVNH7GNAKGQETZFCTNQ@googlegroups.com>)
	id 1WelMd-0005HT-Fo
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 15:12:55 +0200
Received: by mail-pd0-f192.google.com with SMTP id g10sf196613pdj.29
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=DdzPjtq0Xx36rwEKRFz1xkrxAwyfjaWJhGdmRfHR7BE=;
        b=MpPR61qi7Yy5gUze+DCh8h6rqYwCbl8GvzrrtByv4qkqDPdJI2LT6wOkTiMpl77dcR
         0V3gFCh8TXh004RkNTiyhoXRJKx+qLYhzZaUkDHomgOK44Yo7bsR6DwCiyi/tRt5vfog
         zpBH9Ei1q2AwoknkIncPVfsVoU4ZbiFeVtZK02/sbCYieU2P8Ah1K6gXPSF8RM13nQPe
         46rKvoDfsJoW1VWYlHxbNWMAG4I/8uNks+GjfpBoJ0dY2VnOe2ekXnCRQh4wp8Q6Q3Br
         vx3lL1H4sGJUcTWNeusD1h7kU/1tcXXkyRa2WDFdZzzVKatCosr5I+qK0It5YwahGPwb
         zjNQ==
X-Received: by 10.50.78.234 with SMTP id e10mr578501igx.17.1398690774374;
        Mon, 28 Apr 2014 06:12:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.134.36 with SMTP id ph4ls681287igb.10.gmail; Mon, 28 Apr
 2014 06:12:53 -0700 (PDT)
X-Received: by 10.42.155.137 with SMTP id u9mr11398942icw.12.1398690773653;
        Mon, 28 Apr 2014 06:12:53 -0700 (PDT)
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com [2607:f8b0:4001:c03::234])
        by gmr-mx.google.com with ESMTPS id m3si2064037igk.2.2014.04.28.06.12.53
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 06:12:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234 as permitted sender) client-ip=2607:f8b0:4001:c03::234;
Received: by mail-ie0-x234.google.com with SMTP id at1so2963332iec.25
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 06:12:53 -0700 (PDT)
X-Received: by 10.50.85.18 with SMTP id d18mr23509594igz.42.1398690773541;
 Mon, 28 Apr 2014 06:12:53 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 06:12:13 -0700 (PDT)
In-Reply-To: <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247323>

On Mon, Apr 28, 2014 at 11:01 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, Apr 28, 2014 at 10:48 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> So it seems that 08900987 ("Decide whether to build http-push in the
>> Makefile") makes a bad assumption about the availability of
>> curl-config on new libcurl installations; it's not present on "stock"
>> Windows builds.
>
> I wonder, though. That check is over 8 years old. Are that old systems
> (that haven't been upgraded) still able to build Git? Even my old
> RedHat 5 setup has curl 7.15.5...
>
> Perhaps the following is the right thing to do? If not, perhaps we
> could move this complication to configure.ac, which could get the
> version number from the header-file instead? That way, quirks only
> affect quirky systems...
>
> (white-space damaged, I'll post a proper patch if there's some agreement)
> ---
>
> diff --git a/Makefile b/Makefile
> index 29a555d..6da72e7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1133,13 +1133,8 @@ else
>      REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>      PROGRAM_OBJS += http-fetch.o
>      PROGRAMS += $(REMOTE_CURL_NAMES)
> -    curl_check := $(shell (echo 070908; curl-config --vernum)
> 2>/dev/null | sort -r | sed -ne 2p)
> -    ifeq "$(curl_check)" "070908"
> -        ifndef NO_EXPAT
> -            PROGRAM_OBJS += http-push.o
> -        endif
> -    endif
>      ifndef NO_EXPAT
> +        PROGRAM_OBJS += http-push.o
>          ifdef EXPATDIR
>              BASIC_CFLAGS += -I$(EXPATDIR)/include
>              EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib)
> $(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat

I've built an installer with this patch applied, and it seems to do the trick:

https://dl.dropboxusercontent.com/u/1737924/Git-1.9.2-http-push.exe

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
