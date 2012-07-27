From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] contrib: add win32 credential-helper
Date: Fri, 27 Jul 2012 19:32:08 +0200
Message-ID: <CABPQNSZt0a+447qbr6j9ELHfsmfr03VUw6-efAiu0vLicaKyEg@mail.gmail.com>
References: <1343409006-5056-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net, msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDCocuABRoEuPZ7yg@googlegroups.com Fri Jul 27 19:32:52 2012
Return-path: <msysgit+bncCOPdven-DxDCocuABRoEuPZ7yg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDCocuABRoEuPZ7yg@googlegroups.com>)
	id 1SuoPD-0006Dx-S4
	for gcvm-msysgit@m.gmane.org; Fri, 27 Jul 2012 19:32:52 +0200
Received: by pbbro8 with SMTP id ro8sf3556666pbb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Jul 2012 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=OMW/yBGW9vhlTBMXqKPZBijSYfj4hEacVCR+fwQwz9M=;
        b=cr+QTl/FStLpL4KKZMmY6VXDxgTu0uFty+5QQ5F0XJiLXq0H1FYaxsLGuQp2GZOApm
         OQdN5c/qhMmC/dSNLE5Z6gU56OSCJ9SUB2la4CVujfshYdr1LYrAs/tjuqjYGs1GCxy1
         eN1b0QweH3R32mWD1EbHR72wWfZ4G5XudKswI=
Received: by 10.68.233.226 with SMTP id tz2mr933672pbc.13.1343410370263;
        Fri, 27 Jul 2012 10:32:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.194.197 with SMTP id hy5ls3344496pbc.3.gmail; Fri, 27 Jul
 2012 10:32:49 -0700 (PDT)
Received: by 10.66.77.101 with SMTP id r5mr453095paw.27.1343410369537;
        Fri, 27 Jul 2012 10:32:49 -0700 (PDT)
Received: by 10.66.77.101 with SMTP id r5mr453094paw.27.1343410369487;
        Fri, 27 Jul 2012 10:32:49 -0700 (PDT)
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com [209.85.160.46])
        by gmr-mx.google.com with ESMTPS id pz2si560463pbb.0.2012.07.27.10.32.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 10:32:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.160.46 as permitted sender) client-ip=209.85.160.46;
Received: by mail-pb0-f46.google.com with SMTP id rp8so5408819pbb.5
        for <msysgit@googlegroups.com>; Fri, 27 Jul 2012 10:32:49 -0700 (PDT)
Received: by 10.68.204.129 with SMTP id ky1mr16189046pbc.32.1343410369245;
 Fri, 27 Jul 2012 10:32:49 -0700 (PDT)
Received: by 10.66.23.65 with HTTP; Fri, 27 Jul 2012 10:32:08 -0700 (PDT)
In-Reply-To: <1343409006-5056-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.160.46 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202365>

On Fri, Jul 27, 2012 at 7:10 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Since the Windows port of Git expects binary pipes, we need to make
> sure the helper-end also sets up binary pipes.
>
> Side-step CRLF-issue in test to make it pass.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> Sorry for the delay, but here's the third iteration of my credential
> helper for Windows' credential API.
>
> The only change since v2 is that it now supports protocols without
> a host component, as suggested by Jeff King.
>

...aaand just as I sent it out, I realized that my Makefile was a bit
on the light side. Imagine this patch on top for now, please :)

diff --git a/contrib/credential/wincred/Makefile
b/contrib/credential/wincred/Makefile
index b4f098f..bad45ca 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -4,5 +4,11 @@ CC = gcc
 RM = rm -f
 CFLAGS = -O2 -Wall

+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
 git-credential-wincred.exe : git-credential-wincred.c
 	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
+
+clean:
+	$(RM) git-credential-wincred.exe

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
