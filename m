From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 11:01:37 +0200
Message-ID: <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBGNS7CNAKGQEEVJ4R6A@googlegroups.com Mon Apr 28 11:02:20 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBGNS7CNAKGQEEVJ4R6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f64.google.com ([209.85.213.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBGNS7CNAKGQEEVJ4R6A@googlegroups.com>)
	id 1WehS7-0004JL-E9
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 11:02:19 +0200
Received: by mail-yh0-f64.google.com with SMTP id z6sf131969yhz.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=7Y9WkbkDm6yd19nIcH2BlPAsTXa/3XmGFKydLwo5tvw=;
        b=dDcwPPL4FwXMJ3oolqpTd2BMlwcSbPx9lRxqQZR+FWZpyINqt0UE3SRP3mzTSDKLsL
         /oyuwrNDeNVc61zvwIPENT1imS9S9hWq+/th2XiwUPycMbHvTLeJcNIY8Iey4eTi/m3l
         LSbMVF2+ADwoBVxqaolZrQ6hMZUervoMOjpV1whMhpHWsbpXj1YcU3uavQkThvT5Kmfo
         WtyZNxhc3nUlKrVnz0ciYJ/9h8jDPVP6s8HxGG0xqERljbML/db6MDqeSMoDqm/nMDl7
         xumA1NQoFrD0h9xonVHJssp3GsgwKSsxsb0Yg0t/ml0GsojxRCHcnQes9Us8W+RtsbS3
         BBIw==
X-Received: by 10.50.22.33 with SMTP id a1mr556079igf.3.1398675738265;
        Mon, 28 Apr 2014 02:02:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.154.6 with SMTP id vk6ls420718igb.9.gmail; Mon, 28 Apr 2014
 02:02:17 -0700 (PDT)
X-Received: by 10.50.50.2 with SMTP id y2mr10671825ign.1.1398675737399;
        Mon, 28 Apr 2014 02:02:17 -0700 (PDT)
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com [2607:f8b0:4001:c03::236])
        by gmr-mx.google.com with ESMTPS id 6si1943973igs.1.2014.04.28.02.02.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 02:02:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::236 as permitted sender) client-ip=2607:f8b0:4001:c03::236;
Received: by mail-ie0-f182.google.com with SMTP id tp5so2919487ieb.13
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 02:02:17 -0700 (PDT)
X-Received: by 10.50.36.66 with SMTP id o2mr22179214igj.24.1398675737281; Mon,
 28 Apr 2014 02:02:17 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 02:01:37 -0700 (PDT)
In-Reply-To: <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::236
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247253>

On Mon, Apr 28, 2014 at 10:48 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> So it seems that 08900987 ("Decide whether to build http-push in the
> Makefile") makes a bad assumption about the availability of
> curl-config on new libcurl installations; it's not present on "stock"
> Windows builds.

I wonder, though. That check is over 8 years old. Are that old systems
(that haven't been upgraded) still able to build Git? Even my old
RedHat 5 setup has curl 7.15.5...

Perhaps the following is the right thing to do? If not, perhaps we
could move this complication to configure.ac, which could get the
version number from the header-file instead? That way, quirks only
affect quirky systems...

(white-space damaged, I'll post a proper patch if there's some agreement)
---

diff --git a/Makefile b/Makefile
index 29a555d..6da72e7 100644
--- a/Makefile
+++ b/Makefile
@@ -1133,13 +1133,8 @@ else
     REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
     PROGRAM_OBJS += http-fetch.o
     PROGRAMS += $(REMOTE_CURL_NAMES)
-    curl_check := $(shell (echo 070908; curl-config --vernum)
2>/dev/null | sort -r | sed -ne 2p)
-    ifeq "$(curl_check)" "070908"
-        ifndef NO_EXPAT
-            PROGRAM_OBJS += http-push.o
-        endif
-    endif
     ifndef NO_EXPAT
+        PROGRAM_OBJS += http-push.o
         ifdef EXPATDIR
             BASIC_CFLAGS += -I$(EXPATDIR)/include
             EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib)
$(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat

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
