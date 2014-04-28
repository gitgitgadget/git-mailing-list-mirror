From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 11:43:22 +0200
Message-ID: <CABPQNSYsrSy2iONZOA5gjruBqGwEy6Tc1K+5_zYq3q=EMgzE9Q@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBY6F7CNAKGQEECEWCOA@googlegroups.com Mon Apr 28 11:44:06 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBY6F7CNAKGQEECEWCOA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f192.google.com ([209.85.160.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBY6F7CNAKGQEECEWCOA@googlegroups.com>)
	id 1Wei6X-0001PU-2w
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 11:44:05 +0200
Received: by mail-yk0-f192.google.com with SMTP id 200sf380692ykr.29
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=QUWM4KdmBFDyVUZ8IY7FvOAhc4QRDnlHLtSnFNUmKow=;
        b=YsS1hLLNGJudibXJdmw+9Hjri4MrPudg4FxsPvX0aMCJN+uTINbgIfBRbGD4lnPI6o
         /lTI0+EAWX0BYBavb5ntR/43gw4fSIqwZAaCAC+Wxq3ZHpRLepPIt138gBvzlYwVmZvb
         TBNgQgP81IdS5gtGF0EkTpfDtAPh5NuwTxDgHXcEMe3UMtuyKoYNzQaZdZArLc8YodB/
         iVHvpwRL7KRc39DM7fDU4xQSxugKS3177+ju8IHB0hla6s+yBkKHuZpGoor+3Xx4ZHKf
         VVCc3E87vBa6jqDJ+KyqSSIH8m8BIv67foKusghtJwqMfQwyfGPrZA/zXjKx1wrTM6Y1
         ayJg==
X-Received: by 10.51.16.5 with SMTP id fs5mr560235igd.16.1398678243996;
        Mon, 28 Apr 2014 02:44:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.23.39 with SMTP id j7ls1611898igf.16.canary; Mon, 28 Apr
 2014 02:44:02 -0700 (PDT)
X-Received: by 10.50.136.198 with SMTP id qc6mr10735971igb.4.1398678242856;
        Mon, 28 Apr 2014 02:44:02 -0700 (PDT)
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com [2607:f8b0:4001:c03::232])
        by gmr-mx.google.com with ESMTPS id iq7si1962452igb.0.2014.04.28.02.44.02
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 02:44:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::232 as permitted sender) client-ip=2607:f8b0:4001:c03::232;
Received: by mail-ie0-f178.google.com with SMTP id lx4so6393008iec.9
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 02:44:02 -0700 (PDT)
X-Received: by 10.42.223.202 with SMTP id il10mr1671518icb.65.1398678242748;
 Mon, 28 Apr 2014 02:44:02 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 02:43:22 -0700 (PDT)
In-Reply-To: <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247264>

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

And here's a stab at that. Not really tested, as I don't have an
affected system, so it's probably broken somehow ;)

But if someone want's to pick it up, at least there's a starting-point.

---

diff --git a/Makefile b/Makefile
index 29a555d..b94f830 100644
--- a/Makefile
+++ b/Makefile
@@ -1133,11 +1133,8 @@ else
  REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
  PROGRAM_OBJS += http-fetch.o
  PROGRAMS += $(REMOTE_CURL_NAMES)
- curl_check := $(shell (echo 070908; curl-config --vernum)
2>/dev/null | sort -r | sed -ne 2p)
- ifeq "$(curl_check)" "070908"
- ifndef NO_EXPAT
- PROGRAM_OBJS += http-push.o
- endif
+ ifndef NO_CAPABLE_CURL
+ PROGRAM_OBJS += http-push.o
  endif
  ifndef NO_EXPAT
  ifdef EXPATDIR
diff --git a/configure.ac b/configure.ac
index 2f43393..47991c0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -513,6 +513,16 @@ AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])

+AC_COMPILE_IFELSE(
+ [AC_LANG_PROGRAM([#include <curlver.h>],
+ [#if LIBCURL_VERSION_NUM < 0x070908
+#error version too old
+#endif
+ ])],
+ [NO_CAPABLE_CURL=YesPlease],
+ [NO_CAPABLE_CURL=])
+GIT_CONF_SUBST([NO_CAPABLE_CURL])
+
 GIT_UNSTASH_FLAGS($CURLDIR)

 GIT_CONF_SUBST([NO_CURL])

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
